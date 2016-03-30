//
//  SecondViewController.swift
//  WMUC
//
//  Created by Benjamin Graney Green on 8/5/15.
//  Copyright (c) 2015 ben. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    let DIG = NSURLRequest(URL: NSURL (string: "http://wmuc.umd.edu/station/schedule/0/2?#now")!)
    
    let FM = NSURLRequest(URL: NSURL (string: "http://wmuc.umd.edu/station/schedule?#now")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page.loadRequest(FM)

        
    }
    
    @IBOutlet weak var page: UIWebView!

    @IBOutlet weak var Selector: UISegmentedControl!
    
    
    @IBAction func selector(sender: AnyObject) {
        
        switch Selector.selectedSegmentIndex
        {
        case 0:
            
            page.loadRequest(FM)
        case 1:
            page.loadRequest(DIG)
        
        default:
            break
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

