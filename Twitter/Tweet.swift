//
//  Tweet.swift
//  Twitter
//
//  Created by Akifumi Shinagawa on 10/30/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var isRetweeted:Bool = false

    var userName: String?
    var userScreenName: String?
    var retweeterUserName: String?
    
    var tweetedTimeStamp: NSDate?
    var userImageUrlString: String?
    var userImageUrl: URL?
    
    var tweetText: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    
    init(dictionary: NSDictionary) {
//        print("-------->>> \(dictionary)")

        var tweetData:NSDictionary!
        
        let retweetedStatus = dictionary["retweeted_status"] as? NSDictionary
        if retweetedStatus != nil {
            isRetweeted = true
            tweetData = retweetedStatus

            let retweetUserData = dictionary["user"] as? NSDictionary
            if retweetUserData != nil {
                retweeterUserName = retweetUserData?["name"]! as? String
            }
            else{
                retweeterUserName = ""
            }
        }
        else {
            isRetweeted = false
            tweetData = dictionary
        }
        
        let userData = tweetData["user"] as? NSDictionary
        if userData != nil {
            userName = userData?["name"]! as? String
            userScreenName = userData?["screen_name"] as? String
            
            userImageUrlString = userData?["profile_image_url"] as? String
            if userImageUrlString != nil {
                userImageUrl = URL(string: userImageUrlString!)
            } else {
                userImageUrl = nil
            }
        }
        
        tweetText = tweetData["text"] as? String
        retweetCount = (tweetData["retweet_count"] as? Int) ?? 0
        favoritesCount = (tweetData["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
        if let timestampString = timestampString {
            tweetedTimeStamp = formatter.date(from: timestampString) as NSDate?
        }

    }
    
    class func tweetWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
    
        var tweets = [Tweet]()
        
        for dictionay in dictionaries {
            
            let tweet = Tweet(dictionary: dictionay)
            
            tweets.append(tweet)
            
            
        }
        
        
        
        
        
        
       
        return tweets
    
    }
    
    
    
    
    
    
    
    

}
