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
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        if (MFMailComposeViewController.canSendMail()) {
            
            let emailTitle = "DNR Innovations Feedback"
            
            let messageBody = "Thank you for any and all suggestions to improve this program."
            
            let toRecipents = ["dnr.innovations@gmail.com"]
            
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
            
            mc.setSubject(emailTitle)
            
            mc.setMessageBody(messageBody, isHTML: false)
            
            mc.setToRecipients(toRecipents)
            
            self.present(mc, animated: true, completion: nil)
            
        }else {
            
            print("No email account found", terminator: "")
            
        }

        // Do any additional setup after loading the view.
    }

    // Email Delegate
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail cancelled", terminator: "")
        case MFMailComposeResult.saved.rawValue:
            print("Mail saved", terminator: "")
        case MFMailComposeResult.sent.rawValue:
            print("Mail sent", terminator: "")
        case MFMailComposeResult.failed.rawValue:
            print("Mail sent failure: \(error!.localizedDescription)", terminator: "")
        default:
            break
        }
        self.dismiss(animated: false, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
