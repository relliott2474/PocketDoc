//
//  NotesViewController.swift
//  PocketDoc
//
//  Created by HotRod on 12/20/15.
//  Copyright © 2015 Rod Elliott-Mullens. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var note:Notes!
    
    
    @IBOutlet weak var notesField: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = note.title
        notesField.text = note.note
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        note.title = titleTextField.text!
        note.note = notesField.text

    }

}
