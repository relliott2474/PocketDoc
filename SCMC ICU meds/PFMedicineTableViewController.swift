//
//  PFMedicineTableViewController.swift
//  SCMC ICU meds
//
//  Created by HotRod on 7/18/15.
//  Copyright (c) 2015 Rod Elliott-Mullens. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI
let kCardiacSection:Int = 0
let kHemostasisSection:Int = 1
let kNeuroSection:Int = 2
let kPressorsSection:Int = 3
let kReversalAgentsSection:Int = 4
let kSedativesSection:Int = 5
let kSectionCount:Int = 6

class PFMedicineTableViewController: PFQueryTableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
     var sections: [Int: [PFObject]] = Dictionary()
     var sectionKeys: [Int] = Array()
    

    // these are the displayed names to the right of the table
    let indexOfClasses = ["Cardiac", "Hemostasis", "Neuro", "Pressors", "Reversal Agents", "Sedatives"]
    //let kSectionCount:Int = indexOfClasses.count
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Medications")
        if(objects?.count == 0){
        query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        if searchBar.text != "" {

          _ =  query.whereKey("name", matchesRegex:searchBar.text!.capitalizedString, modifiers:"i")
        }

        query.orderByAscending("name")
        return query
    }
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "Medications"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell:PFTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? PFTableViewCell!
        
        if cell == nil{
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        if let articleName = object?["name"] as? String{
            cell?.textLabel?.text = articleName
            if let detailInfo = object?["doserange"] as? String{
                cell?.detailTextLabel?.text = detailInfo
            }

            
        }
        return cell
    }
    
     /*  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return indexOfClasses.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // the name of the sections in the table view
        
        //return sections as? String
        switch section{
            case kCardiacSection:
                return "Cardiac"
            case kHemostasisSection:
                return "Hemostasis"
            case kNeuroSection:
                return "Neuro"
            case kPressorsSection:
                return "Pressors"
            case kReversalAgentsSection:
                return "Reversal Agents"
            case kSedativesSection:
                return "Sedatives"
            default:
                return "Unknown"
        }
    }
    
     override func objectsDidLoad(error: NSError?) {
        super.objectsDidLoad(error)

        sections.removeAll(keepCapacity: false)
        if let objects = objects as? [PFObject] {
            for object in objects {
                let priority = (object["Class"] as? Int) ?? 0
                println("# in priority\(priority)")
                var array = sections[priority] ?? Array()
                array.append(object)
                sections[priority] = array
                println(sections[priority])
            }
        }
        sectionKeys = sections.keys.array.sorted(<)

        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return indexOfClasses
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        var temp = indexOfClasses as NSArray
        return temp.indexOfObject(title)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! PFMedicineViewController
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let row = Int(indexPath.row)
            destination.currentObject1 = (objects?[row] as! PFObject)
        }

    }
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
        searchBar.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Medications"
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.tableView.rowHeight = 40.0
   }
        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        //dismiss keyboard
        searchBar.resignFirstResponder()
        //reload table data
        self.loadObjects()
        
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.loadObjects()
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        //dismiss
        searchBar.resignFirstResponder()
        self.loadObjects()
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.loadObjects()
    }
}
