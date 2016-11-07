//
//  DataManager.swift
//  SCMC ICU meds
//
//  Created by Rod Elliott-Mullens on 1/25/16.
//  Copyright © 2016 Rod Elliott-Mullens. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    func saveNewDataToModel(_ nameText:String, dataText:String){
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let newData = NSEntityDescription.insertNewObject(forEntityName: "NoteFile", into: context)
        // sets the new transferred data to be saved.
        if nameText != newData{
            let dateV = getCurrentShortDate()
            newData.setValue(dateV, forKey: "noteDate")
            newData.setValue(nameText, forKey: "noteTitle")
            newData.setValue(dataText, forKey: "noteText")
            
            /*if let name = newData.valueForKey("noteTitle"){
                if let text = newData.valueForKey("noteText"){
                    print(name, text)
                }
            }*/

        do{
            try context.save()
            if let name = newData.value(forKey: "noteTitle"){
                if let text = newData.value(forKey: "noteText"){
                    print(name, text)
                }
            }
            }catch{
                print("failed to save data")
            }
         }
        }
    
    
    func updateData (_ title:String, nameText:String, dataText:String, upD:String){
        
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteFile")
        request.predicate = NSPredicate(format: "noteTitle = %@", title)
        //request.predicate = NSPredicate(format: "noteTitle = %@", nameText)  // this will help to search.
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    result.setValue(nameText,forKey:"noteTitle")
                    result.setValue(dataText, forKey:"noteText")
                    result.setValue(upD, forKey: "noteDate")
                    do{
                        try context.save()
                        print("saved updated data")
                        if let newtitle = result.value(forKey: "noteTitle") as? String{
                            if let newdocument = result.value (forKey: "noteText") as? String{
                                if let newD = result.value(forKey: "noteDate") as? String{
                                   print("new data \(newtitle,newdocument, newD)")
                                }
                                
                            }
                        }
                    }catch {
                        print("failed to save updata data")
                    }
                }
            }
            
        }//do
        catch{
            print("failed to update the data")
        }
    }
    func getCurrentShortDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let DateInFormat = dateFormatter.string(from: todaysDate)
        return DateInFormat
    }
}
