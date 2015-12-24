//
//  SettingsViewController.swift
//  Codinator
//
//  Created by Vladimir on 03/06/15.
//  Copyright (c) 2015 Vladimir Danila. All rights reserved.
//

import UIKit
import MessageUI
import Social
import Crashlytics

class SettingsViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var purpleViewPartTwo: UIView!
    
    @IBOutlet weak var aboutContainer: UIView!
    @IBOutlet weak var generalContainer: UIView!
    @IBOutlet weak var securityContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()



        
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
                let maskPath = UIBezierPath(roundedRect: purpleView.bounds, byRoundingCorners: [UIRectCorner.BottomLeft, UIRectCorner.BottomRight], cornerRadii: CGSizeMake(15.0, 15.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = maskPath.CGPath
        self.purpleView.layer.mask = maskLayer

        
        let maskPath2 = UIBezierPath(roundedRect: purpleViewPartTwo.bounds, byRoundingCorners: [UIRectCorner.TopLeft,UIRectCorner.TopRight], cornerRadii: CGSizeMake(15.0, 15.0))
        
        let maskLayer2 = CAShapeLayer()
        maskLayer2.frame = self.view.bounds
        maskLayer2.path = maskPath2.CGPath
        self.purpleViewPartTwo.layer.mask = maskLayer2
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
    
    
    
    
    @IBAction func segmentDidChange(sender: AnyObject) {
        
        switch self.segmentController.selectedSegmentIndex{
            
        case 0:
            self.generalContainer.hidden = true
            self.securityContainer.hidden = true
            self.aboutContainer.hidden = false
        case 1:
            self.aboutContainer.hidden = true
            self.securityContainer.hidden = true
            self.generalContainer.hidden = false
        case 2:
            self.aboutContainer.hidden = true
            self.generalContainer.hidden = true
            self.securityContainer.hidden = false
        default:
            print("error")
        }
        
        
        
    }
    
    
    
    
    
    
    //MARK: Social
    
    @IBAction func tweetPressed(sender: AnyObject) {
        
        
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)){
            
            let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet.setInitialText("#Codinator is amazing. Editing projects on the go has never been easier. You really should try it out!")
            tweetSheet.addURL(NSURL(string: "https://itunes.apple.com/us/app/codinator/id1024671232?ls=1&mt=8"))
            
            self.presentViewController(tweetSheet, animated: true, completion: nil)
            
            Answers.logCustomEventWithName("tweetPressed",
                customAttributes: [:])
            
        }
    
    
    }
    
    
    
    @IBAction func ratePressed(sender: AnyObject) {

        
        
        
        
        let alert = UIAlertController(title: "Review", message: "Do you enjoy using Codinator?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.view.tintColor = UIColor.purpleColor()
        
        let enjoy = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
           
            UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/app/codinator/id1024671232?ls=1&mt=8")!)
        }
        
        let hate = UIAlertAction(title: "Not really", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
           
            //Show email
            self.presentMail("Codinnator Feedback", message: "Codinator is not working properly for me. Here is a brief description of what's going on:", includeLink: false)
        
        }
        
        
        
        alert.addAction(enjoy)
        alert.addAction(hate)
        
        
        
        self.presentViewController(alert, animated: true, completion: {
            Answers.logCustomEventWithName("Rate pressed",
                customAttributes: [:])
        })
        
        
        
    }

    
    
    
    @IBAction func mailPressed(sender: AnyObject) {
        //SHOW EMAIL
        
        presentMail("Codinator", message: "Hey,<br>Coding on the go has never been easy... But Codinator is a real life changer! It makes coding really confortable on mobile devices and even supports versioning.<br><br><a href=\"https://itunes.apple.com/us/app/codinator/id1024671232?ls=1&mt=8\">You should really try it out.</a>", includeLink: true)
        
    }
    
    
    
    func presentMail(title: String, message: String, includeLink: Bool){
        
        if (MFMailComposeViewController.canSendMail()){
            
            let mailController = MFMailComposeViewController()
            mailController.setSubject(title)
            mailController.setMessageBody(message, isHTML: includeLink)
            
            if (!includeLink){
                mailController.setToRecipients(["vladidanila@icloud.com"])
            }
            
            
            mailController.mailComposeDelegate = self
            
            self.presentViewController(mailController, animated: true, completion: nil)
      
        }
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func backDidPush(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    

}