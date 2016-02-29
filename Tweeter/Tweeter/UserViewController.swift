//
//  UserViewController.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/28/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var userHandle:String!
    var userInfo: User!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.userInfo(userHandle, success: { (user: User) -> () in
            self.userInfo = user
            self.nameLabel.text = self.userInfo.name
            self.handleLabel.text = "@\(self.userInfo.screenname)"
            self.profileImage.layer.cornerRadius = 6.0
            self.profileImage.clipsToBounds = true
            self.profileImage.setImageWithURL(self.userInfo.profileUrl!)
            
            }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
        
        
        /*

        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
        self.tweets = tweets
        self.tableView.reloadData()
        
        }, failure: { (error:NSError) -> () in
        print(error.localizedDescription)
        })
        
        */
        
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
