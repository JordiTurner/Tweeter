//
//  SingleTweetViewController.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/23/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class SingleTweetViewController: UIViewController {

    var tweet: Tweet!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = tweet.text
        timestampLabel.text = tweet.timestamp
        handleLabel.text = "@\(tweet.screenname)"
        usernameLabel.text = tweet.username
        retweetCountLabel.text = "\(tweet.retweetCount) Retweets"
        favoriteCountLabel.text = "\(tweet.favoritesCount) Favorites"
        profileImageView.layer.cornerRadius = 6.0
        profileImageView.clipsToBounds = true
        profileImageView!.setImageWithURL(tweet.profileUrl!)
        replyImageView.image = UIImage(named: "reply32.png")
        if tweet.favorited {
            favoriteImageView.image = UIImage(named: "favoriteRed32.png")
        } else {
            favoriteImageView.image = UIImage(named: "favoriteBlack32.png")
        }
        if tweet.retweeted {
            retweetImageView.image = UIImage(named: "retweetGreen32.png")
        } else {
            retweetImageView.image = UIImage(named: "retweetBlack32.png")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
