//
//  ViewController.swift
//  TwitterDemoBlog
//
//  Created by TheAppGuruz-New-6 on 16/11/15.
//  Copyright © 2015 TheAppGuruz-New-6. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    
    @IBOutlet weak var btnPostTweet: UIButton!
    @IBOutlet weak var btnMyProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblSuccess: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        FHSTwitterEngine.sharedEngine().permanentlySetConsumerKey("DU5qWMBw7eexdQRgoUyfNa7o5", andSecret: "zLFQAqzZ6kpoIKhazk8SG4RQ2fdXcCgQ5PodYrLwOfl6bf47Wf")
        FHSTwitterEngine.sharedEngine().loadAccessToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - UIButton Action methods
    @IBAction func btnMyProfileClicked(sender: AnyObject)
    {
        UIApplication .sharedApplication() .networkActivityIndicatorVisible = true
        let result = FHSTwitterEngine.sharedEngine().getHomeTimelineSinceID(FHSTwitterEngine.sharedEngine().authenticatedID, count: 10)
        print("Home feed = \(result)")
        
        let alert = UIAlertController(title: "Complete", message: "Latest 10 home feed has been fetched. Check your debugger.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func btnPostTweetClicked(sender: AnyObject)
    {
        let alert = UIAlertController(title: "Tweet", message: "Write a tweet below. Make sure you're using a testing account.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Write a tweet here..." })
        alert.addAction(UIAlertAction(title: "Post", style: .Default, handler:
        { action in
            var title = String()
            var message = String()
            let textField = alert.textFields![0] as UITextField
            let result = FHSTwitterEngine.sharedEngine() .postTweet(textField.text!)
            
            if(result != nil)
            {
                title = "Error"
                message = "error occured while poting"
            }
            else
            {
                title = "Success"
                message = "Successfully posted."
            }
            let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler:nil))
            self.presentViewController(alertView, animated: true, completion: nil)

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnLogoutClicked(sender: AnyObject)
    {
        FHSTwitterEngine .sharedEngine() .clearAccessToken()
        
        self.btnLogin.hidden = false
        self.btnPostTweet.hidden = true
        self.btnMyProfile.hidden = true
        self.btnLogout.hidden = true
        self.lblSuccess.hidden = true
    }
    @IBAction func btnLoginViaTwitterClicked(sender: AnyObject)
    {
        let loginController = FHSTwitterEngine .sharedEngine() .loginControllerWithCompletionHandler { (Bool success) -> Void in
            
        self.btnLogin.hidden = true
        self.btnPostTweet.hidden = false
        self.btnMyProfile.hidden = false
        self.btnLogout.hidden = false
        self.lblSuccess.hidden = false

        } as UIViewController
        self .presentViewController(loginController, animated: true, completion: nil)
    }
}

