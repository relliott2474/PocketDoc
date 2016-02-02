//
//  PhoneNumberViewController.swift
//  SCMC ICU meds
//
//  Created by HotRod on 1/31/16.
//  Copyright © 2016 Rod Elliott-Mullens. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // sets the bar color
        self.navigationController?.navigationBar.barTintColor = UIColor.brownColor()
        //set the back button text color
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
