//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Akifumi Shinagawa on 10/30/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tweetsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tweetsTableView.insertSubview(refreshControl, at: 0)
        
        loadTweetData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.logout()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetsTableViewCell", for: indexPath) as! TweetsTableViewCell
        cell.tweet = tweets?[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return (tweets?.count)!
        }
        else {
            return 0
        }
    }
    
    func loadTweetData() {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
                self.tweets = tweets
                self.tweetsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }, failure: { (error:Error) -> () in
                print("error: \(error.localizedDescription)")
        })
    }
  
    func refreshControlAction(refreshControl: UIRefreshControl) {
        loadTweetData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for seque called")
        
        if segue.identifier == "toTweetDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            let tweetDetailViewController = segue.destination as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        }
        else {
            
        }
    }
}
