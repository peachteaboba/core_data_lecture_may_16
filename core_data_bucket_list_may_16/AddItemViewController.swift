//
//  AddItemViewController.swift
//  core_data_bucket_list_may_16
//
//  Created by Andy Feng on 5/16/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController {

    var addItemDel: AddItemDelegate?
    var itemToEdit: String?
    var editItemDel: EditItemDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    @IBOutlet weak var itemField: UITextField!
    
    @IBAction func handleCancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSaveButtonPressed(_ sender: UIButton) {
        print("add btn pressed ----->\(itemField.text!)")
        
        
        if (itemToEdit != nil) {
            // Edit
            
            editItemDel?.doneEditing(editedItem: itemField.text!)
            
        } else {
            // Adding
            
            
            let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
            newItem.title = itemField.text!
            
            if context.hasChanges {
                do {
                    try context.save()
                    print("Success")
                } catch {
                    print("\(error)")
                }
            }
            
            
            addItemDel?.doneAdding()
        }
        
        
        
        
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
        // Check to see if adding or editing
        if let item = itemToEdit {
            // Editing
            
            itemField.text = item
            
            
        } else {
            // Adding
            print("adding")
            
            
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
