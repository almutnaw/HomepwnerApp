//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Nawwaf Almutairi on 4/12/16.
//  Copyright © 2016 Nawwaf. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(sender: AnyObject){
        // Creat new item and add it to the store
        let newItem = itemStore.creatItem()
        
        // figure out where that item is in the array
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // insert this roew in the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
    }
    @IBAction func toggleEditingMode(sender: AnyObject){
        // If you are currently in editing mode...
        if editing{
            // change text of button to inform user of state
            sender.setTitle("Edit", forState: .Normal)
        
            //turn of Editing mode
            setEditing(false, animated: true)
        }
        else {
            // change the text of button to inform the user of state
            sender.setTitle("Done", forState: .Normal)
            
            //Enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = 65
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        //set the text on the cell with the description of the item 
        //that is at the nth index of items, where n = row this cell
        //will appear in on the tableView
        let item = itemStore.allItems[indexPath.row]
        
        //Config the cell with the item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // if the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deletAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {(action) -> Void in
            
            
                //Remove the item from the store
                self.itemStore.removeItem(item)
            
                // Also remove that row from the table view with an animation
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                })
            ac.addAction(deletAction)
            
            //present the view alert controller
            presentViewController(ac, animated: true
                , completion: nil)
        }
        
        
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // update the model
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
