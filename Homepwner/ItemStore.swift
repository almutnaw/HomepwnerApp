//
//  ItemStore.swift
//  Homepwner
//
//  Created by Nawwaf Almutairi on 4/12/16.
//  Copyright © 2016 Nawwaf. All rights reserved.
//

import UIKit


class ItemStore {
    
    var allItems = [Item]()
    
    func creatItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item){
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        
        // get refrence to object being moved so you can reinsert it 
        let movedItem = allItems[fromIndex]
        
        //remove item from array
        allItems.removeAtIndex(fromIndex)
        
        // inser item in array at new location
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
}
