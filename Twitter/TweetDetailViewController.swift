//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Akifumi Shinagawa on 10/30/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var retweetedIcon: UIImageView!
    @IBOutlet weak var nameRetweetedByLabel: UILabel!
    @IBOutlet weak var tweeterImage: UIImageView!
    @IBOutlet weak var tweeterNameLabel: UILabel!
    @IBOutlet weak var tweeterScreenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetedTimeLabel: UILabel!
    @IBOutlet weak var retweetedAndLikedLabel: UILabel!

    var tweet: Tweet!
    
    @IBAction func onReplyButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func onFavoriteButton(_ sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tweet = self.tweet{
            if tweet.isRetweeted {
                retweetedIcon.isHidden = false
                nameRetweetedByLabel.isHidden = false
                nameRetweetedByLabel.text = tweet.retweeterUserName! + " Retweeted"
                
                //TODO: set height to 0
            }
            else{
                retweetedIcon.isHidden = true
                nameRetweetedByLabel.isHidden = true
                nameRetweetedByLabel.text = ""
                
                //TODO: set height to original
            }
            
            tweetLabel.text = tweet.tweetText
            
            tweeterImage.setImageWith(tweet.userImageUrl!, placeholderImage: nil)
            tweeterNameLabel.text = tweet.userName
            tweeterScreenNameLabel.text = "@" + tweet.userScreenName!
            
            //            tweetedTimeLabel.text = tweet.tweetedTimeStamp
            
            
            let retweetCountText:String?
            if tweet.retweetCount > 0 {
                retweetCountText = String(tweet.retweetCount) + " RETWEETS"
            }
            else if tweet.retweetCount == 1 {
                retweetCountText = "1 RETWEET"
            }
            else {
                retweetCountText = ""
            }
            
            let likedCountText:String?
            if tweet.favoritesCount > 0 {
                likedCountText = String(tweet.favoritesCount) + " LIKE"
            }
            else if tweet.favoritesCount == 1 {
                likedCountText = "1 LIKE"
            }
            else {
                likedCountText = ""
            }
            
            if retweetCountText != "" {
                retweetedAndLikedLabel.text = retweetCountText! + " " + likedCountText!
            }
            else {
                retweetedAndLikedLabel.text = likedCountText
            }
        }
        else {
            print("ERROR: tweet data hasn't been passed to TweetDetailViewController.")
        }
        

        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    
    

    
    // MARK: - Navigation toReplyView

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        if segue.identifier == "toReplyView" {
            let targetViewController = segue.destination as! ReplyViewController
            
            targetViewController.tweet = self.tweet
            
        }

        
    }
 

}
