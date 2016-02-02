//
//  NotesViewController.swift
//  PocketDoc
//
//  Created by HotRod on 12/20/15.
//  Copyright © 2015 Rod Elliott-Mullens. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    var noteTitle = ""
    var notesDescription = ""
    var buttonView = ""
    //var note:Notes!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var notesField: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBAction func buttonAction(sender: AnyObject) {
        
        if buttonView == "Save" {
            buttonOutlet.backgroundColor = UIColor.greenColor()
            var name = titleTextField.text
            name = name?.capitalizedString
            var text = notesField.text
            text = text.capitalizedString
            let dataManager = DataManager()
            dataManager.saveNewDataToModel(name!, dataText:text)
        }else if buttonView == "Update"{
            let name = titleTextField.text?.capitalizedString
            let text = notesField.text.capitalizedString
            let dataManager = DataManager()
            dataManager.updateData(name!, textFieldText:text)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note View"
        titleTextField.text = noteTitle
        notesField.text = notesDescription
        buttonOutlet.setTitle(buttonView, forState: .Normal)
        if buttonView == "Save" {
            buttonOutlet.backgroundColor = UIColor.greenColor()
            }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = note.title
        notesField.text = note.noteText
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        note.title = titleTextField.text!
        note.noteText = notesField.text
        
    }*/
    
    
    
}
