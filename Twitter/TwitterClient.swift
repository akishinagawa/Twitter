//
//  TwitterClient.swift
//  Twitter
//
//  Created by Akifumi Shinagawa on 10/30/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



struct LoginInfo {
    static let TWITTER_URL_STRING = "https://api.twitter.com"
    static let COMSUMER_KEY = "DgAvzctGL7Bmqiju8V38drglL"
    static let COSUMER_SECRET = "vaoptnzw4V5XVlctAp0ebRz92115g5kEexBUkbQSbCBvoPKMUw"
    static let REQUEST_TOKEN_URL = "oauth/request_token"
    static let AUTHORIZE_URL = "https://api.twitter.com/oauth/authorize"
    static let ACCESS_TOKEN_URL = "oauth/access_token"
    
    static let VERIFY_CREDENTIAL_URL = "1.1/account/verify_credentials.json"
    static let HOME_TIMELINE_URL = "1.1/statuses/home_timeline.json"
    
    static let RETWEET_URL_PARTIAL = "1.1/statuses/retweet/"
    
    static let STATUS_UPDATE_URL = "1.1/statuses/update.json?"
    
}

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: LoginInfo.TWITTER_URL_STRING), consumerKey: LoginInfo.COMSUMER_KEY, consumerSecret: LoginInfo.COSUMER_SECRET)
 
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure

        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: LoginInfo.REQUEST_TOKEN_URL, method: "GET", callbackURL: URL(string: "codepathtwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let tokenString:String = (requestToken?.token)! as String
            let url = URL(string: LoginInfo.AUTHORIZE_URL + "?oauth_token=" + tokenString)!
            UIApplication.shared.open(url)
        }, failure: { (error:Error?) -> Void in
            print("Request Token Failed. - error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl (url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: LoginInfo.ACCESS_TOKEN_URL, method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential?) -> Void in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                
            }, failure: { (error: Error) -> () in
                    
                self.loginFailure?(error)
            })

        }, failure: { (error:Error?) -> Void in
            print("Request Access Token Failed. - error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }

    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get(LoginInfo.HOME_TIMELINE_URL, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, resposne: Any?) -> Void in
            let dictionaries = resposne as! [NSDictionary]
            let tweets = Tweet.tweetWithArray(dictionaries: dictionaries)
            
                success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                
                failure(error)
        })
    }

    func currentAccount(success: @escaping (User) ->(), failure: @escaping (Error) -> ()) {
        get(LoginInfo.VERIFY_CREDENTIAL_URL, parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
        }, failure: { (task:URLSessionDataTask?, error:Error) -> Void in
            print("Request Access Token Failed. - error: \(error.localizedDescription)")
            failure(error)
            
        })
    }
    
    
    func sendTweet(statusString: String, success: @escaping () ->(), failure: @escaping (Error) -> ()) {
        let encodedStatusString = statusString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let replyTweetURLString:String = LoginInfo.STATUS_UPDATE_URL + "status=" + encodedStatusString!
        
        post(replyTweetURLString, parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response: Any?) -> Void in
            success()
            }, failure: { (task:URLSessionDataTask?, error:Error) -> Void in
                print("Send Tweet Failed. - error: \(error.localizedDescription)")
                failure(error)
        })
    }
    
    func sendReplyTweet(targetId: String, statusString: String, success: @escaping () ->(), failure: @escaping (Error) -> ()) {
        let encodedStatusString = statusString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let replyTweetURLString:String = LoginInfo.STATUS_UPDATE_URL + "status=" + encodedStatusString! + "&in_reply_to_status_id=" + targetId

        post(replyTweetURLString, parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response: Any?) -> Void in
                success()
            }, failure: { (task:URLSessionDataTask?, error:Error) -> Void in
                print("Send Reply Failed. - error: \(error.localizedDescription)")
                failure(error)
        })
    }
    
    
    
    
    
    
    
    
    
    
    

}
