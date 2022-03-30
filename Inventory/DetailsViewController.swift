//
//  DetailsViewController.swift
//  Inventory
//
//  Created by Cambrian on 2022-03-23.
//

import UIKit

class DetailsViewController: UIViewController {

    var inventory: ItemList!
    var index: Int?
    
    var userDefaults: UserDefaults!

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var SKUField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Validating index and setting item data
        if(nil != index){
            let item = inventory.items[index!]
            nameField.text = item.name
            SKUField.text = item.SKU
            descField.text = item.desc
            dateField.date = item.dateAdded
        }
    }
    
    //Implenentation for for save or update an item
    @IBAction func save(_ sender: Any) {
    let item = Item(name: nameField.text!,SKU: SKUField.text!,description: descField.text!, dateAdded: dateField.date)
    if(nil != index) {
        inventory.items.remove(at: index!)
        inventory.items.insert(item, at: index!)

    }else {
        inventory.addItem(item: item)
    }
        do {
            
            let encodedItems = try NSKeyedArchiver.archivedData(withRootObject: inventory.items, requiringSecureCoding:false)
            userDefaults.set(encodedItems, forKey: "inventory")
        } catch  {}
        
    }
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
