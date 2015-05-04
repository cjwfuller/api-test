//
//  ViewController.swift
//  api-test
//
//  Created by Chris Fuller on 30/04/2015.
//  Copyright (c) 2015 Chris Fuller. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBAction func buttonTouched(sender: AnyObject) {
        let url = NSURL(string: "http://beta-api.gousto.co.uk/recipe/1")
        
        let started = NSDate()
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var error: NSError?
            if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options:
                NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                    let interval = NSDate().timeIntervalSinceDate(started)
                    var ti = NSInteger(interval)
                    var ms = String(Int((interval % 1) * 1000))
                    
                    if let result = json["result"] as? NSDictionary {
                        if let data = result["data"] as? NSDictionary {
                            if let recipe = data["recipe"] as? NSDictionary {
                                if let title = recipe["title"] as? NSString {
                                    var alert = UIAlertController(title: "Recipe", message: "Retrieved: " + (title as String) + " in " + ms + " ms" as String, preferredStyle: UIAlertControllerStyle.Alert)
                                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
                                    self.presentViewController(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
            }
        }
        
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

