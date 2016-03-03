//
//  LoginViewController.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/20/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(sender: AnyObject) {
        TwitterClient.sharedInstance.login({ () -> () in
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }) { (error:NSError) -> () in
            print("Error: \(error.localizedDescription)")
            
        }
        
        
        
        
    }
}
