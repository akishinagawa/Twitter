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

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        tweeterImage.layer.cornerRadius = 6
        tweeterImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
