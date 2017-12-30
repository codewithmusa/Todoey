//
//  ViewController.swift
//  Todoey
//
//  Created by MUSA B SESAY on 27/12/2017.
//  Copyright © 2017 TechMussayApp. All rights reserved.


import UIKit
import CoreData

class TodoListViewController: UITableViewController {
     var itemArray = [Item]()
    
   // let defaults =  UserDefaults.standard
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
      //  searchBar.delegate = self
        
        loadItems()
        
       // print(dataFilePath)
        
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
    //  loadItems()
        
        
        
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
      
        //context.delete(itemArray[indexPath.row])
         // itemArray.remove(at: indexPath.row)
        
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
            
           // let context = (UIApplication.shared.delegate as!
           // AppDelegate).persistentContainer.viewContext
            
            let newItem = Item(context:self.context)
            newItem.title = textField.text!
            newItem.done = false
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
        //let encoder = PropertyListEncoder()
        do {
         //   let data =  try encoder.encode(itemArray)
           // try data.write(to: dataFilePath!)
            let context = (UIApplication.shared.delegate as!
                AppDelegate).persistentContainer.viewContext
            try context.save()
            
        } catch {
            print("Error saving context, \(error)")
          //  print("Error encoding item array, \(error)")
            
            
        }
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        self.tableView.reloadData()
        
    }
//
//    func loadItems()  {
//        let data = try? Data(contentsOf: dataFilePath!)
//        let decoder = PropertyListDecoder()
//        do {
//            itemArray = try decoder.decode([Item].self, from: data!)
//
//        } catch {
//            print("Error decoding item arrary , \(err=or)")
//        }
//    }
    func loadItems()  {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //let request : nsfetc
        
        do {
           itemArray =  try  context.fetch(request)
        } catch {
                print("Error from fetching data from context , \(error)")
      }
    }
}

//MARK: Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            itemArray =  try  context.fetch(request)
        } catch {
            print("Error from fetching data from context , \(error)")
        }
        tableView.reloadData()
        //print(searchBar.text)
        
    }
    
}











