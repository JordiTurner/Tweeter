//
//  TweetCell.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/21/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timestampLable: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetProfileLabel: UIImageView!
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
            tweetProfileLabel.layer.cornerRadius = 6.0
            tweetProfileLabel.clipsToBounds = true
            tweetProfileLabel!.setImageWithURL(tweet.profileUrl!)
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
