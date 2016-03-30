//
//  FirstViewController.swift
//  WMUC
//
//  Created by Benjamin Graney Green on 8/5/15.
//  Copyright (c) 2015 ben. All rights reserved.
//
import Foundation
import AVFoundation
import UIKit
import MediaPlayer

class FirstViewController: UIViewController {
    static let sharedInstance = FirstViewController()

    
    let Play = UIImage(named: "BackPlay") as UIImage!
    let Pause = UIImage(named: "BackPause") as UIImage!
    var preinterrupt = ""
    private var myContext=0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PP.sharedInstance.FM.addObserver(Background, forKeyPath: "FMstate", options: .New, context: &myContext)
        PP.sharedInstance.Digital.addObserver(Background, forKeyPath: "DigitalState", options: .New, context: &myContext)
        
        if PP.sharedInstance.isPlaying() == false {
            Background.highlighted = false
        
        } else if PP.sharedInstance.isPlaying() == true {
            Background.highlighted = true
        }

            if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            let image:UIImage = UIImage(named: "Playa")!
            let albumArt = MPMediaItemArtwork(image: image)
            let songInfo = [
                MPMediaItemPropertyTitle: PP.sharedInstance.channel(),
                MPMediaItemPropertyArtist: "WMUC",
                MPMediaItemPropertyArtwork: albumArt
            ]
                MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo as [String : AnyObject]?
        }
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: [])
        try! AVAudioSession.sharedInstance().setActive(true)
        
    }
    
 
    
    
    @IBOutlet weak var Background: UIImageView!
    
    
    @IBOutlet weak var PlayPause: UIButton!
    
    
    @IBOutlet weak var ChannelSelect: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        
        switch ChannelSelect.selectedSegmentIndex
        {
        case 0:
            
            PP.sharedInstance.Play("FM")
            PP.sharedInstance.Pause()
            Background.highlighted=false
            
        case 1:
            PP.sharedInstance.Play("Digital")
            PP.sharedInstance.Pause()
            
            Background.highlighted=false
            
        default:
            break
        }
        
    }

    @IBAction func Playpause() {
        

        if (PP.sharedInstance.isPlaying()){
        Background.highlighted=false
        PP.sharedInstance.Pause()
            
        }else{
            PP.sharedInstance.Play(PP.sharedInstance.channel())
            
            Background.highlighted=true

        }
        
        

    }
    
    @IBOutlet weak var Load: UIActivityIndicatorView!
    @IBOutlet weak var Load2: UIActivityIndicatorView!

    @IBOutlet weak var Load3: UIActivityIndicatorView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


