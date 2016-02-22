//
//  Tweet.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/20/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var username: String?
    var screenname: String!
    var timestamp: String!
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileUrl: NSURL?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        print(dictionary)
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            let timestampFull = formatter.dateFromString(timestampString)! as NSDate
            let shortFormatter = NSDateFormatter()
            shortFormatter.dateFormat = "MMM d"
            timestamp = shortFormatter.stringFromDate(timestampFull)
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        let user = dictionary["user"] as? NSDictionary
        if let user = user {
            username = user["name"] as? String
            screenname = user["screen_name"] as! String
            let profileUrlString = user["profile_image_url"] as? String
            if let profileUrlString = profileUrlString {
                profileUrl = NSURL(string: profileUrlString)
            }
        }
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
            
        }
        return tweets
    }

}
