//
//  User.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/20/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String!
    var screenname: String!
    var profileUrl: NSURL?
    var tagline: NSString!
    var tweetCount: Int = 0
    var followersCount: Int = 0
    var followingCount: Int = 0
    
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        print(dictionary)
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? String
        
        
    }
    
    static var _currentUser: User?
    static let userDidLogoutNotification = "UserDidLogout"

    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
        }
    }
}
