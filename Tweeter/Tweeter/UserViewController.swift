//
//  UserViewController.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/28/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    var userHandle:String!
    var userInfo: User!
    var tweets: [Tweet]!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        TwitterClient.sharedInstance.userInfo(userHandle, success: { (user: User) -> () in
            self.userInfo = user
            self.nameLabel.text = self.userInfo.name
            self.handleLabel.text = "@\(self.userInfo.screenname)"
            self.profileImage.layer.cornerRadius = 6.0
            self.profileImage.clipsToBounds = true
            self.profileImage.setImageWithURL(self.userInfo.profileUrl!)
            self.numFollowersLabel.text = "\(self.userInfo.followersCount)"
            self.numFollowingLabel.text = "\(self.userInfo.followingCount)"
            self.numTweetsLabel.text = "\(self.userInfo.tweetCount)"
            }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
        })
        TwitterClient.sharedInstance.userTimeline(userHandle,success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        }
        else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserTweetCell", forIndexPath: indexPath) as! UserTweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onText(sender: AnyObject) {
    }
    @IBAction func onRetweet(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! UserTweetCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets[indexPath!.row]
        if tweet.retweeted == false{
            print("Retweeting")
            self.tweets![indexPath!.row].retweetCount += 1
            tweet.retweeted = true
            TwitterClient.sharedInstance.retweet(tweet.ID)
            self.tableView.reloadData()
        } else if tweet.retweeted == true{
            print("Unretweeting")
            self.tweets![indexPath!.row].retweetCount -= 1
            tweet.retweeted = false
            TwitterClient.sharedInstance.unretweet(tweet.ID)
            self.tableView.reloadData()
        }
    }
    @IBAction func onFavorite(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! UserTweetCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets[indexPath!.row]
        if tweet.favorited == false{
            print("Retweeting")
            self.tweets![indexPath!.row].favoritesCount += 1
            tweet.favorited = true
            TwitterClient.sharedInstance.favorite(tweet.ID)
            self.tableView.reloadData()
        } else if tweet.favorited == true{
            print("Unretweeting")
            self.tweets![indexPath!.row].favoritesCount -= 1
            tweet.favorited = false
            TwitterClient.sharedInstance.unfavorite(tweet.ID)
            self.tableView.reloadData()
        }

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "UserTweetSegue") {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! UserTweetCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets[indexPath!.row]
            let tweetVC = segue.destinationViewController as! SingleTweetViewController;
            tweetVC.tweet = tweet
            
            
        }
    }
    

}
