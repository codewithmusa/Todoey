//
//  ViewController.swift
//  Todoey
//
//  Created by MUSA B SESAY on 27/12/2017.
//  Copyright © 2017 TechMussayApp. All rights reserved.


import UIKit

class TodoListViewController: UITableViewController {
     var itemArray = [Item]()
    
   // let defaults =  UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        
        //let dataFilePath = FileManager.default.urls(for: doc)
        
//
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        newItem.done = true
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy TechMussayApp TodoeyList"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Build iOSApp"
//        itemArray.append(newItem3)
//
        loadItems()
        
        
        
//        if let  items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }

         }
    
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        //Ternary operation ==>
        // value = condition ? ValueIfTrue : valueIfFalse
      //  cell.accessoryType = item.done == true ? .checkmark : .none
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        if item.done == true {
           cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
 }
   //MARK -TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
//        if  itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
//
       // tableView.reloadData()
        
       
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user click the Add Item button on our UIAlert
          //  print("Success")
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
         //   print(alertTextField.text)
            textField = alertTextField
            
          //  print(alertTextField.text)
          //  print("Now")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    //MARK -Model Manupulation Method
    func saveItems()  {
        let encoder = PropertyListEncoder()
        do {
            let data =  try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
            
        }
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        self.tableView.reloadData()
        
    }
    func loadItems()  {
        let data = try? Data(contentsOf: dataFilePath!)
        let decoder = PropertyListDecoder()
        do {
            itemArray = try decoder.decode([Item].self, from: data!)
            
            } catch {
                print("Error decoding item arrary , \(error)")
            }
    }
}


