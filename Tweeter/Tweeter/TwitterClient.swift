//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/15/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
let twitterConsumerKey = "N96OeWkgJ3TB0ZZKNb3o5jZ8L"
let twitterConsumerSecret = "ZQ4FDKOQv2kWy1025r7cvQGnYLd8cc8kOq6Uy05hfw2xbeMqq1"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient{
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL,consumerKey:twitterConsumerKey, consumerSecret:twitterConsumerSecret)
        }
        return Static.instance
    }
}
