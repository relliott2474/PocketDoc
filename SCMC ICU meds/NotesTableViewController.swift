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
        self.tableView.rowHeight = rowHeight + 10
        navigationController!.navigationBar.barTintColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath)

        // Configure the cell...
        let noteHeading = notesArray[indexPath.row]
        //cell.textLabel!.text = notesArray[indexPath.row].title  // if using a class
        cell.textLabel?.text = noteHeading.value(forKey: "noteTitle") as? String // accesses the CoreData
        cell.detailTextLabel?.text = noteHeading.value(forKey: "noteDate") as? String//displays the note date.
        return cell
    }
    
     //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.managedObjectContext
            context.delete(notesArray[indexPath.row] as NSManagedObject)
            notesArray.remove(at: indexPath.row)
            //print("notesArray after removal \(notesArray)")
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showNote"{
        
         let destVC = segue.destination as! NotesViewController
          if let selectedIndexPath = tableView.indexPathForSelectedRow{
            let row = Int(selectedIndexPath.row)
            let noteArray = notesArray[row]
            //let noteForSegue = notesArray[selectedIndexPath]
            destVC.noteTitle = (noteArray.value(forKey: "noteTitle") as! String)
            destVC.notesDescription = (noteArray.value(forKey: "noteText") as! String)
            destVC.buttonView = "Update"
            }
            
        }else if segue.identifier == "addNote"{
            let destVC = segue.destination as! NotesViewController
            destVC.buttonView = "Save"
            }
         }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteFile")
        let sortedNames = NSSortDescriptor(key: "noteTitle", ascending: true)
        request.sortDescriptors = [sortedNames]
        
        do{
            let results = try context.fetch(request)
            notesArray = results as! [NSManagedObject]
        }catch let error as NSError{
            print("could not fetch \(error)")
        }
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    func controllerWillChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.beginUpdates()
    }
    func controller(_ controller:NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo:NSFetchedResultsSectionInfo, atIndex sectionIndex:Int, forChangeType type:NSFetchedResultsChangeType){
        switch type{
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
                break
        case .update:
            break
        }
    }
    
    func controller(_ controller:NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject:NSManagedObject, atIndex indexPath:IndexPath?, forChangeType type:NSFetchedResultsChangeType, newIndexPath:IndexPath?){
        switch type{
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            break
        case .move:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
            self.tableView.insertRows(at: [indexPath!], with: .fade)
        }
    }
    func controllerDidChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.endUpdates()
    }
}
