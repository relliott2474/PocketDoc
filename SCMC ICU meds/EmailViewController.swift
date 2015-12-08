//
//  EmailViewController.swift
//  SCMC ICU meds
//
//  Created by Rod Elliott-Mullens on 4/21/15.
//  Copyright (c) 2015 Rod Elliott-Mullens. All rights reserved.
//

import UIKit
import MessageUI

class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        if (MFMailComposeViewController.canSendMail()) {
            
            let emailTitle = "DNR Innovations Feedback"
            
            let messageBody = "Thank you for any and all suggestions to improve this program."
            
            let toRecipents = ["dnr.innovations@gmail.com"]
            
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
            
            mc.setSubject(emailTitle)
            
            mc.setMessageBody(messageBody, isHTML: false)
            
            mc.setToRecipients(toRecipents)
            
            self.presentViewController(mc, animated: true, completion: nil)
            
        }else {
            
            print("No email account found", terminator: "")
            
        }

        // Do any additional setup after loading the view.
    }

    // Email Delegate
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled", terminator: "")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved", terminator: "")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent", terminator: "")
        case MFMailComposeResultFailed.rawValue:
            print("Mail sent failure: \(error!.localizedDescription)", terminator: "")
        default:
            break
        }
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
