//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by Akifumi Shinagawa on 10/30/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var retweetedIcon: UIImageView!
    @IBOutlet weak var nameRetweetedByLabel: UILabel!
    
    @IBOutlet weak var tweeterImage: UIImageView!
    @IBOutlet weak var tweeterNameLabel: UILabel!
    @IBOutlet weak var tweeterScreenNameLabel: UILabel!

    @IBOutlet weak var tweetedTimeLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    
    @IBOutlet weak var reweetedCountLabel: UILabel!
    @IBOutlet weak var likedCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
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
            
            tweetsLabel.text = tweet.tweetText
            
            tweeterImage.setImageWith(tweet.userImageUrl!, placeholderImage: nil)
            tweeterNameLabel.text = tweet.userName
            tweeterScreenNameLabel.text = "@" + tweet.userScreenName!
            
//            tweetedTimeLabel.text = tweet.tweetedTimeStamp
            
            reweetedCountLabel.text = String(tweet.retweetCount)
            likedCountLabel.text = String(tweet.favoritesCount)
            
//            let timeStampString = tweetedTimeStampToString(tweetedDate: tweet.tweetedTimeStamp!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        tweeterImage.layer.cornerRadius = 6
        tweeterImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tweetedTimeStampToString(tweetedDate: NSDate) -> String {
//        let date = tweetedDate as Date
//        let calendar = Calendar.current
//        
//        let year = calendar.component(.year, from: date)
//        let month = calendar.component(.month, from: date)
//        let day = calendar.component(.day, from: date)
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour):\(minutes):\(seconds)")

//        if year > 0 {
//            return String(format: "%@yr", withValue: year as Int)
//        }
//        
//        if month > 0 {
//            return String(format:"%%d%@mo", withValue: month)
//        }
//        
//        if day >= 7 {
//            let value = components.day!/7
//            return String(format:"%%d%@w", withValue: value)
//        }
//        
//        if day > 0 {
//            return String(format:"%%d%@d", withValue: day)
//        }
//        
//        if hour > 0 {
//            return String(format:"%%d%@h", withValue: hour)
//        }
//        
//        if minutes > 0 {
//            return String(format:"%%d%@m", withValue: minutes)
//        }
//        
//        if seconds > 0 {
//            return String(format:"%%d%@s", withValue: seconds)
//        }
        
        return ""
        
    }
    
    
    
    
    

}
