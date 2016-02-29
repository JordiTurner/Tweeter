//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/21/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "N96OeWkgJ3TB0ZZKNb3o5jZ8L", consumerSecret: 	"ZQ4FDKOQv2kWy1025r7cvQGnYLd8cc8kOq6Uy05hfw2xbeMqq1")
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in

            self.currentAccount({ (user:User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error:NSError) -> () in
                self.loginFailure?(error)
            })
            self.loginSuccess?()
            
        }) { (error: NSError!) -> Void in
                self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
        
    }
    
    func login(success: ()->(), failure: (NSError)->()) {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL (string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            }) { (error: NSError!) -> Void in
                print("Error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            success(user)
            
        }, failure: { (task: NSURLSessionDataTask?, error:NSError) -> Void in
            failure(error)
        })
        
    }
    
    func homeTimeline (success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
                
        })
    
    }
    func retweet(tweetID: String) {
        POST("1.1/statuses/retweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("Retweeted tweet \(tweetID)")
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print("failed to retweet")
            print(error)
        })
    }
    func favorite(tweetID: String) {
        POST("1.1/favorites/create.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("Favorited tweet \(tweetID)")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to favorite")
                print(error)
        })
        
    }
    func unretweet(tweetID: String) {
        POST("1.1/statuses/unretweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("Unretweeted tweet \(tweetID)")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to unretweet")
                print(error)
        })
    }
    func unfavorite(tweetID: String) {
        POST("1.1/favorites/destroy.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("Unfavorited tweet \(tweetID)")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to unfavorite")
                print(error)
        })
    }
    func tweetInfo(tweetID: String){
        print("get Tweet infor")
        
    }
    func userInfo(userHandle: String, success: (User) -> (), failure: (NSError) -> ()){
        print("get User info for user: \(userHandle)")
        
        GET("1.1/users/show.json?screen_name=\(userHandle)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })

        
    }}


