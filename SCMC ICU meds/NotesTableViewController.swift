//
//  NotesTableViewController.swift
//  PocketDoc
//
//  Created by HotRod on 12/20/15.
//  Copyright © 2015 Rod Elliott-Mullens. All rights reserved.
//

import UIKit
import CoreData

var notesArray = [NSManagedObject]()

class NotesTableViewController: UITableViewController {
    
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        title = "Notes List"
        self.tableView.rowHeight = rowHeight + 20
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notesCell", forIndexPath: indexPath)

        // Configure the cell...
        let noteHeading = notesArray[indexPath.row]
        //cell.textLabel!.text = notesArray[indexPath.row].title  // if using a class
        cell.textLabel?.text = noteHeading.valueForKey("noteTitle") as? String // accesses the CoreData
        cell.detailTextLabel?.text = noteHeading.valueForKey("noteDate") as? String
        print(noteHeading.valueForKey("noteDate"))
        print(notesArray[indexPath.row])
        return cell
    }
    
     //Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDel.managedObjectContext
            context.deleteObject(notesArray[indexPath.row] as NSManagedObject)
            notesArray.removeAtIndex(indexPath.row)
            print("notesArray after removal \(notesArray)")
            tableView.reloadData()
            
            do{
                try context.save()
            }catch{
                abort()
            }
           
                           }
          }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showNote"{
        
         let destVC = segue.destinationViewController as! NotesViewController
          if let selectedIndexPath = tableView.indexPathForSelectedRow{
            let row = Int(selectedIndexPath.row)
            let noteArray = notesArray[row]
            //let noteForSegue = notesArray[selectedIndexPath]
            destVC.noteTitle = (noteArray.valueForKey("noteTitle") as! String)
            destVC.notesDescription = (noteArray.valueForKey("noteText") as! String)
            destVC.buttonView = "Update"
            }
            
        }else if segue.identifier == "addNote"{
            let destVC = segue.destinationViewController as! NotesViewController
            destVC.buttonView = "Save"
            }
         }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "NoteFile")
        let sortedNames = NSSortDescriptor(key: "noteTitle", ascending: true)
        request.sortDescriptors = [sortedNames]
        
        do{
            let results = try context.executeFetchRequest(request)
            notesArray = results as! [NSManagedObject]
        }catch let error as NSError{
            print("could not fetch \(error)")
        }
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    func controllerWillChangeContent(controller:NSFetchedResultsController){
        self.tableView.beginUpdates()
    }
    func controller(controller:NSFetchedResultsController, didChangeSection sectionInfo:NSFetchedResultsSectionInfo, atIndex sectionIndex:Int, forChangeType type:NSFetchedResultsChangeType){
        switch type{
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Move:
                break
        case .Update:
            break
        }
    }
    
    func controller(controller:NSFetchedResultsController, didChangeObject anObject:NSManagedObject, atIndex indexPath:NSIndexPath?, forChangeType type:NSFetchedResultsChangeType, newIndexPath:NSIndexPath?){
        switch type{
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            break
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            self.tableView.insertRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        }
    }
    func controllerDidChangeContent(controller:NSFetchedResultsController){
        self.tableView.endUpdates()
    }
}
