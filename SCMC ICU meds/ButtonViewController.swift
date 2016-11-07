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
    
    let buttonColor:UIColor = UIColor.red
    let barColorTint:UIColor = UIColor(red:0.94, green:0.33, blue:0.31, alpha:1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this sets the navigation bar Color
        navigationController!.navigationBar.barTintColor = buttonColor
        
        //this sets the navigation bar title text color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //this sets the back bar button color in the navigation bar.
       navigationController!.navigationBar.tintColor = UIColor.white
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
        
        //let lighterColor = UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0)
        //self.refArticles.layer.cornerRadius = 2.0
        //self.refArticles.layer.borderWidth = 1.0
        //self.refArticles.layer.borderColor = UIColor.redColor().CGColor
        refArticles.backgroundColor = buttonColor
        refMeds.backgroundColor = buttonColor
        //self.refMeds.layer.cornerRadius = 2.0
        //PhoneNumBtn.backgroundColor = buttonColor
        notesButton.backgroundColor = buttonColor
        //self.refMeds.layer.borderWidth = 1.0
        //refMeds.layer.borderColor = UIColor.redColor().CGColor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.navigationBar.barTintColor = UIColor.red
        borders()
    }
    
   }
