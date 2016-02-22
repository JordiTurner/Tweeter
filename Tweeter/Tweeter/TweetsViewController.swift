//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by Jordi Turner on 2/21/16.
//  Copyright © 2016 Jordi Turner. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }


    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
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
        let cell = view.superview as! TweetCell
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
