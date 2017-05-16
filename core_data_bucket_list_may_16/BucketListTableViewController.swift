//
//  BucketListTableViewController.swift
//  core_data_bucket_list_may_16
//
//  Created by Andy Feng on 5/16/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class BucketListTableViewController: UITableViewController, AddItemDelegate, EditItemDelegate {

    // Make a fixture
    var listArr = [Item]()
    var idxCache: Int?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchStuffs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // Table View Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // Set some data
        cell.textLabel?.text = listArr[indexPath.row].title
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        // Edit 
        performSegue(withIdentifier: "addVC", sender: indexPath.row)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Delete
//        listArr.remove(at: indexPath.row)
        
        context.delete(listArr[indexPath.row])
        
        if context.hasChanges {
            do {
                try context.save()
                print("Success")
                
                fetchStuffs()
                
                
            } catch {
                print("\(error)")
            }
        }
    }
    
    
    
    // Fetch all items from Core Data
    func fetchStuffs(){
        print("fetching from core data")
        
        
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        do {
            // get the results by executing the fetch request we made earlier
            let results = try context.fetch(itemRequest)
            

            
            listArr = results as! [Item]
            
            tableView.reloadData()
            
            
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        
    }
    
    
    
    
    
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! AddItemViewController
        
        if sender is Int {
            
            // Editing
            
            if let idx = sender as? Int {
                vc.itemToEdit = listArr[idx].title
                idxCache = idx
            }
            
            vc.editItemDel = self
            
            
            
        } else {
            
            // Adding
            
            vc.addItemDel = self
            
        }
        
        
        
        
        
        
    }
    

    
    
    // Protocol functions
    func doneAdding() {
//        listArr.append(item)
        fetchStuffs()
//        tableView.reloadData()
    }
    
    func doneEditing(editedItem: String) {
        
        
        
        
        if let i = idxCache {
            listArr[i].title = editedItem
        }
        
        if context.hasChanges {
            do {
                try context.save()
                print("Success")
                
                fetchStuffs()
                
                
            } catch {
                print("\(error)")
            }
        }

        
//        tableView.reloadData()
    }
    
    
    
}

