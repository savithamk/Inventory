//
//  ItemList.swift
//  Inventory
//
//  Created by Cambrian on 2022-03-23.
//

import Foundation

class ItemList{
    var items = [Item]()
    
    //Implementation for deleting an item
       func deleteItem(row: Int){
           items.remove(at: row)
       }
    
    //Implementation for moving an item
       func moveItem(from: Int, to: Int){
           let temp = items[from]
           deleteItem(row: from)
           items.insert(temp, at: to)
       }
    
}
