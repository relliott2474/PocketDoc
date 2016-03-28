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
    var noteDate = ""
    
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var notesField: UITextView!
    @IBOutlet weak var titleTextField: UITextField!

    
    @IBAction func buttonAction(sender: AnyObject) {
        
        if titleTextField.text == ""{
                emptyStringAlert()
            
        } else if buttonView == "Save" {
            buttonOutlet.backgroundColor = UIColor.greenColor()
            var name = titleTextField.text
            if name != name?.capitalizedString{
                name = name?.capitalizedString
            }
            let text = notesField.text.capitalizedString
            let dataManager = DataManager()
            dataManager.saveNewDataToModel(name!, dataText:text)//may need to set date here.
            buttonOutlet.setTitle("Update", forState: UIControlState.Normal)
            buttonView = "Update"
            
            
        } else if buttonView == "Update"{
            buttonView = "Update"
            buttonOutlet.setTitle("Update", forState: UIControlState.Normal)
            var name = titleTextField.text
            if name != name?.capitalizedString{
                name = name?.capitalizedString
            }
            var text = notesField.text
            text = text.capitalizedString
            let dataManager = DataManager()
            let newDate = dataManager.getCurrentShortDate()
            dataManager.updateData(noteTitle, nameText:name!, dataText:text, upD:newDate)
            print("update button pushed")
            noteUpdatedAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note View"
        titleTextField.text = noteTitle
        notesField.layer.cornerRadius = 10.0
        notesField.text = notesDescription
        buttonOutlet.setTitle(buttonView, forState:.Normal)
        buttonOutlet.layer.cornerRadius = 10.0
            
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
    
    func emptyStringAlert(){
        
            let alert = UIAlertController(title: "Error", message: "Give your note a title.", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) -> Void in
            }
            presentViewController(alert, animated: true, completion: nil)
            alert.addAction(cancelAction)
            
            }
    
    func noteUpdatedAlert(){
        let alert = UIAlertController(title: "Updated", message: "Your note was updated!", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Ok.", style: .Default) { (UIAlertAction) -> Void in
        }
        presentViewController(alert, animated: true, completion:nil)
        alert.addAction(cancelAction)
    }
    
}
