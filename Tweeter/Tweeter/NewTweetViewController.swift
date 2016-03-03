//
//  NewTweetViewController.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/29/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    var userInfo: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.userInfo.name
        self.screenNameLabel.text = "@\(self.userInfo.screenname)"
        self.profileImage.layer.cornerRadius = 6.0
        self.profileImage.clipsToBounds = true
        self.profileImage.setImageWithURL(self.userInfo.profileUrl!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPostTweet(sender: AnyObject) {
        let originalString = textField.text
        let escapedString = originalString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        TwitterClient.sharedInstance.tweet(escapedString!)
        print("posted a tweet, now head back to timeline")
        self.performSegueWithIdentifier("postedSegue", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
