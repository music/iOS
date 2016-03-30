//
//  AppDelegate.swift
//  WMUC
//
//  Created by Benjamin Graney Green on 8/5/15.
//  Copyright (c) 2015 ben. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var preinterrupt = ""
    
    var channel = "FM"
    
    var launch = 1
    
    
   

    
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        if event!.type == UIEventType.RemoteControl {
            if event!.subtype == UIEventSubtype.RemoteControlPlay {
                PP.sharedInstance.Play(PP.sharedInstance.channel())
                
            } else if event!.subtype == UIEventSubtype.RemoteControlPause {
                PP.sharedInstance.Pause()
            } else if event!.subtype == UIEventSubtype.RemoteControlTogglePlayPause {
                if(PP.sharedInstance.isPlaying()){
                    PP.sharedInstance.Pause()
                }else{
                    PP.sharedInstance.Play(PP.sharedInstance.channel())
                }
            }else if event!.subtype == UIEventSubtype.RemoteControlNextTrack {
                if PP.sharedInstance.channel()=="FM" {
                    PP.sharedInstance.Play("Digital")
                }else{
                    PP.sharedInstance.Play("FM")
                }
                let image:UIImage = UIImage(named: "Playa")!
                let albumArt = MPMediaItemArtwork(image: image)
                let songInfo = [
                    MPMediaItemPropertyTitle: PP.sharedInstance.channel(),
                    MPMediaItemPropertyArtist: "WMUC",
                    MPMediaItemPropertyArtwork: albumArt
                ]
                MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo as [String : AnyObject]?
                
            }else if event!.subtype == UIEventSubtype.RemoteControlPreviousTrack{
                if PP.sharedInstance.channel()=="FM" {
                    PP.sharedInstance.Play("Digital")
                }else{
                    PP.sharedInstance.Play("FM")
                }
                let image:UIImage = UIImage(named: "Playa")!
                let albumArt = MPMediaItemArtwork(image: image)
                let songInfo = [
                    MPMediaItemPropertyTitle: PP.sharedInstance.channel(),
                    MPMediaItemPropertyArtist: "WMUC",
                    MPMediaItemPropertyArtwork: albumArt
                ]
                MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo as [String : AnyObject]?
                

            }
            
        }
    }
    
    
    func handleReachabilityChanged(notification:NSNotification){
        if(PP.sharedInstance.isPlaying()){
            preinterrupt="playing!"
        }else{
            preinterrupt="nah"
        }
        PP.sharedInstance.Pause()
        
        PP.sharedInstance.refresh()
        
        if preinterrupt == "playing!" {
            PP.sharedInstance.Play(PP.sharedInstance.channel())
        } else if preinterrupt == "nah" {
            PP.sharedInstance.Pause()
        }
        
        
        NSLog("Network reachability has changed.");
    }
    
    func applicationWillResignActive(application: UIApplication) {
        if(PP.sharedInstance.isPlaying()){
            preinterrupt="playing!"
        }else{
            preinterrupt="nah"
        }
        launch = 0
        
        
        let image:UIImage = UIImage(named: "Playa")!
        let albumArt = MPMediaItemArtwork(image: image)

        let songInfo = [
            MPMediaItemPropertyTitle: PP.sharedInstance.channel(),
            MPMediaItemPropertyArtist: "WMUC",
            MPMediaItemPropertyArtwork: albumArt
        ]
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo as [String : AnyObject]?

    }

    func applicationDidEnterBackground(application: UIApplication) {
        if(PP.sharedInstance.isPlaying()){
            preinterrupt="playing!"
        }else{
            preinterrupt="nah"
        }

        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
        if preinterrupt == "playing!" {
            PP.sharedInstance.Play(PP.sharedInstance.channel())
        } else if preinterrupt == "nah" {
            PP.sharedInstance.Pause()
        }
        
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
            if preinterrupt == "playing!" {
                PP.sharedInstance.Play(PP.sharedInstance.channel())
            } else if preinterrupt == "nah" {
                PP.sharedInstance.Pause()
            }
        

        
    }

    func applicationWillTerminate(application: UIApplication) {

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

    
    

}

