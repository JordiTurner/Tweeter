//
//  UserTweetCell.swift
//  Tweeter
//
//  Created by Jordi Turner on 3/3/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLable: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var tweetProfileImage: UIImageView!
    
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            timestampLable.text = tweet.timestamp
            handleLabel.text = "@\(tweet.screenname)"
            nameLabel.text = tweet.username
            retweetLabel.text = "\(tweet.retweetCount)"
            favoriteLabel.text = "\(tweet.favoritesCount)"
            tweetProfileImage.layer.cornerRadius = 6.0
            tweetProfileImage.clipsToBounds = true
            tweetProfileImage.setImageWithURL(tweet.profileUrl!)
            if tweet.favorited {
                favoriteImage.image = UIImage(named: "favoriteRed32.png")
            } else {
                favoriteImage.image = UIImage(named: "favoriteBlack32.png")
            }
            if tweet.retweeted {
                retweetImage.image = UIImage(named: "retweetGreen32.png")
            } else {
                retweetImage.image = UIImage(named: "retweetBlack32.png")
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
