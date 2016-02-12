//
//  ButtonViewController.swift
//  SCMC ICU meds
//
//  Created by HotRod on 4/9/15.
//  Copyright (c) 2015 Rod Elliott-Mullens. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {
    
    @IBOutlet weak var refArticles: UIButton!
    @IBOutlet weak var refMeds: UIButton!
    
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var PhoneNumBtn: UIButton!
    let buttonColor:UIColor = UIColor.redColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // this sets the navigation bar Color
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        
        //this sets the navigation bar title text color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //this sets the back bar button color in the navigation bar.
       navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar
        borders()
        
       /* //set a pic to the background of the title bar.
        navigationController!.navigationBar.barTintColor = UIColor.clearColor()
        let image:UIImage = UIImage(named: "275locationsBend2.png")!
        
        self.navigationController!.navigationBar.setBackgroundImage(image , forBarMetrics:.Default)
        self.navigationController!.navigationBar*/
        //self.title.font = UIFont(name: "Avenir", size: 20)
        self.title = "SCHS Reference"
        
    }
    
    func borders(){
        //self.refArticles.layer.cornerRadius = 2.0
        //self.refArticles.layer.borderWidth = 1.0
        //self.refArticles.layer.borderColor = UIColor.redColor().CGColor
        refArticles.backgroundColor = buttonColor
        refMeds.backgroundColor = buttonColor
        //self.refMeds.layer.cornerRadius = 2.0
        PhoneNumBtn.backgroundColor = buttonColor
        notesButton.backgroundColor = buttonColor
        //self.refMeds.layer.borderWidth = 1.0
        //refMeds.layer.borderColor = UIColor.redColor().CGColor
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
    override func viewWillAppear(animated: Bool) {
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        borders()
    }
}
