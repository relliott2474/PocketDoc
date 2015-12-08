//
//  PFMedicineViewController.swift
//  SCMC ICU meds
//
//  Created by HotRod on 7/18/15.
//  Copyright (c) 2015 Rod Elliott-Mullens. All rights reserved.
//

import UIKit
import Parse
import Bolts

class PFMedicineViewController: UIViewController {
    var currentObject1 = PFObject?()
    let groups = ["Cardiac", "Hemostasis", "Neuro", "Pressors", "Reversal Agents", "Sedatives"]
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var doseLabel: UILabel!
    
    @IBOutlet weak var textInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let object = currentObject1{
            let nameObject: AnyObject? = object.objectForKey("name")
            nameLabel.text = nameObject as? String
            //navigationItem.title = nameObject as? String
            
            //does label
            let doseObject:AnyObject? = object.objectForKey("doserange")
            doseLabel.text = doseObject as? String
            
            // textview
            let textObject:AnyObject? = object.objectForKey("textInfo")
            textInfo.text = textObject as? String
            
            
        }

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
