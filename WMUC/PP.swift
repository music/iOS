//
//  PP.swift
//  WMUC
//
//  Created by Benjamin Graney Green on 8/15/15.
//  Copyright (c) 2015 ben. All rights reserved.
//

import Foundation
import AVFoundation
import SystemConfiguration
private var myContext=0;

class PP:NSObject {
    static let sharedInstance = PP()
    dynamic var Digital = AVPlayer(URL: NSURL(string: "http://wmuc.umd.edu/wmuc2-high.m3u")!)
    dynamic var FM = AVPlayer(URL: NSURL(string: "http://wmuc.umd.edu/wmuc-high.m3u")!)
    private var playing = false
    private var play = "FM"
    private override init() {
        super.init()
    FM.addObserver(self, forKeyPath: "FMstate", options: .New, context: &myContext)
    Digital.addObserver(self, forKeyPath: "DigitalState", options: .New, context: &myContext)
        
        let theSession = AVAudioSession.sharedInstance()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playInterrupt:", name: AVAudioSessionInterruptionNotification, object: theSession)
    }
   
    func Play(station: String) {
            if(station=="FM"){
                Digital.pause()
                FM.play()
                play="FM"
            }else{
                FM.pause()
                Digital.play()
                play="Digital"
            }
            playing=true
    }
    
    func Pause(){
            Digital.pause()
            
            FM.pause()
            
            playing=false
        
    }
    
    func channel()-> String{
        return play
    }
    
    func isPlaying() -> Bool{
       return playing
    }
    
    func ready() -> Bool{
        if play=="FM"{
            if FM.rate == 0.0 {
            return false
            }else{
                return true
            }
            
        }else if play == "Digital"{
            if (Digital.rate == 0.0) {
            return false
            }else{
                return true
            }

        }else{
            return false
        }
    }
    func refresh(){
          Digital = AVPlayer(URL: NSURL(string: "http://wmuc.umd.edu/wmuc2-high.m3u")!)
          FM = AVPlayer(URL: NSURL(string: "http://wmuc.umd.edu/wmuc-high.m3u")!)
          playing = false
    }
    
    func playInterrupt(notification: NSNotification)
    {
        if notification.name == AVAudioSessionInterruptionNotification && notification.userInfo != nil
        {
            var info = notification.userInfo!
            var intValue: UInt = 0
            
            (info[AVAudioSessionInterruptionTypeKey] as! NSValue).getValue(&intValue)
            
            if let type = AVAudioSessionInterruptionType(rawValue: intValue)
            {
                switch type
                {
                case .Began:
                    print("aaaaarrrrgggg you stole me")
                    self.Pause()
                case .Ended:
        
                    self.Play(play)
                default:
                    print("this is unexpected...")
                }
            }
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myContext {
            if let newValue = change?[NSKeyValueChangeNewKey] {
                print("Date changed: \(newValue)")
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    
    deinit {
        FM.removeObserver(self, forKeyPath: "FMstate", context: &myContext)
        Digital.removeObserver(self, forKeyPath: "DigitalState", context: &myContext)
    }
}