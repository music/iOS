//
//  Archive.swift
//  WMUC
//
//  Created by Benjamin Graney Green on 10/22/15.
//  Copyright (c) 2015 ben. All rights reserved.
//


import UIKit

class Archive: UIViewController {
    
    
    let StreamRip = NSURLRequest(URL: NSURL (string: "http://wmuc.umd.edu/stream_ripper")!)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        webPage.loadRequest(StreamRip)
    }
    
    @IBOutlet weak var webPage: UIWebView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func back(sender: AnyObject) {
        if(webPage.canGoBack){
            webPage.goBack()
        }
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

