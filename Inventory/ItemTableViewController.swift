//
//  ItemTableViewController.swift
//  Inventory
//
//  Created by Cambrian on 2022-03-23.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    let inventory = ItemList()
    var selectedIndex:Int?
    
    var userDefaults = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        do {
            if let data = userDefaults.object(forKey: "inventory") {
                let decodedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? [Item]
                inventory.items = decodedItems!
            }
        } catch  {}
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return inventory.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        
        //To display item name
        let item = inventory.items[indexPath.row]
        cell.textLabel?.text = item.name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            inventory.deleteItem(row: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateUserDefaultsData()
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        inventory.moveItem(from: fromIndexPath.row, to: to.row)
        updateUserDefaultsData()
    }
    
    func updateUserDefaultsData(){
        do {
            
            let encodedItems = try NSKeyedArchiver.archivedData(withRootObject: inventory.items, requiringSecureCoding:false)
            userDefaults.set(encodedItems, forKey: "inventory")
        } catch  {}
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let dst = segue.destination as! DetailsViewController
        
        dst.inventory = inventory;
        dst.userDefaults =  userDefaults;
        
        if(segue.identifier == "edit"){
            let senderRow: UITableViewCell = sender as! UITableViewCell
            dst.index = tableView.indexPath(for: senderRow)?.row
        }
    }

}
