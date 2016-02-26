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
    
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    func saveNewDataToModel(nameText:String, dataText:String){
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        
        // add empty string check here
        
        let newData = NSEntityDescription.insertNewObjectForEntityForName("NoteFile", inManagedObjectContext: context)
        if nameText != newData{
            newData.setValue(nameText, forKey: "noteTitle")
            newData.setValue(dataText, forKey: "noteText")
        do{
            try context.save()
            if let name = newData.valueForKey("noteTitle"){
                if let text = newData.valueForKey("noteText"){
                    print(name, text)
                }
            }
            
        }catch{
            print("failed to save data")
        }
        }//if statement
        }
    
    func removeData(nameText:String){
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "NoteFile")
        request.predicate = NSPredicate(format: "noteTitle = %@", nameText)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.executeFetchRequest(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    context.deleteObject(result)
                    do{
                        try context.save()
                    }catch{
                        print("no data removed")
                    }
                    
                }
            }
        }catch{
            print("unable to complete fetch request")
        }
        }
    
    func updateData (nameText:String, textFieldText:String){
        
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "NoteFile")
        request.predicate = NSPredicate(format: "noteTitle = %@", nameText)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.executeFetchRequest(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    result.setValue(nameText,forKey:"noteTitle")
                    result.setValue(textFieldText, forKey:"noteText")
                    do{
                        try context.save()
                        print("saved updated data")
                        if let newtitle = result.valueForKey("noteTitle") as? String{
                            if let newdocument = result.valueForKey ("noteText") as? String{
                                print("new data \(newtitle,newdocument)")
                            }
                        }
                    }catch {
                        print("failed to save updata data")
                    }
                }//for loop
            }//results.count
            
            
        }//do
        catch{
            print("failed to update the data")
        }
        
        
    }
    
    
    
    
    
}