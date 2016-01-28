//
//  PFTableViewController.swift
//  ParseDownload
//
//  Created by HotRod on 7/3/15.
//  Copyright (c) 2015 Rod. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI
import QuartzCore

class PFTableViewController: PFQueryTableViewController {

    
    override func queryForTable() -> PFQuery {
    let query = PFQuery(className: "TestDataString")
        if(objects?.count == 0){
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        query.orderByAscending("artNames")
        return query
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "TestDataString"
        self.textKey = "artNames"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reading List"
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        // Do any additional setup after loading the view.
        self.tableView.rowHeight = 45.0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        var cell:PFTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? PFTableViewCell!
        
        if cell == nil{
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        if let articleName = object?["artNames"] as? String{
            cell?.textLabel?.text = articleName
        }
        
        let startColor:UIColor = UIColor.redColor()
        let endColor: UIColor = UIColor.purpleColor()
        //let startColor2:UIColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.1)
        //let endColor2:UIColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.1)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = cell!.contentView.bounds
        gradient.startPoint = CGPointMake(0.0, 0.5)
        gradient.endPoint = CGPointMake(1.0, 0.5)
        gradient.colors = [startColor.CGColor, endColor.CGColor]
        //gradient.colors = [startColor2.CGColor, endColor2.CGColor]
        
        cell!.contentView.layer.insertSublayer(gradient, atIndex: 0);

        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pdfSegue"{
        // Pass the selected object to the new view controller.
        let detailScene = segue.destinationViewController as! PFViewController
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as! PFObject)
        }
        }
    }
}
