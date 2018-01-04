//
//  ViewController.swift
//  Todoey
//
//  Created by MUSA B SESAY on 27/12/2017.
//  Copyright © 2017 TechMussayApp. All rights reserved.


import UIKit
//import CoreData
import RealmSwift

class TodoListViewController:SwipeTableViewController {
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
          loadItems()
        }
    }
    
   // let defaults =  UserDefaults.standard
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
      //  searchBar.delegate = self
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        loadItems(with: request)
     //   let request : NSFetchRequest<Item> = Item.fetchRequest()
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
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if   let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            //Ternary operation ==>
            // value = condition ? ValueIfTrue : valueIfFalse
            //  cell.accessoryType = item.done == true ? .checkmark : .none
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        
//        if item.done == true {
//           cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        return cell
 }
   //MARK -TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                //realm.delete(item)
                item.done = !item.done
            }
            } catch {
                print("Error Saving done status \(error)")
            }
    }
      
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
            
            do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                   }
                } catch {
                    print("Error saving new items \(error)")
               }
           }
            self.tableView.reloadData()
           // self.save(item: newItem)
        }
            
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Creat new Category"
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
    //MARK: - Model Manupulation methods
    
    func loadItems()  {
       todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
         try   self.realm.write {
                realm.delete(item)
            }
            } catch {
                print("Error deleting Item, \(error)")
            }
    }
   }

}


extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
      func searchBar(_ searchBar:UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                 loadItems()
                DispatchQueue.main.async {
                     searchBar.resignFirstResponder()


            }


        }

    }
}












