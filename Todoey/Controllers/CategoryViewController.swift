//
//  CategoryViewController.swift
//  Todoey
//
//  Created by yx on 31/12/2017.
//  Copyright © 2017 TechMussayApp. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework
//import SwipeCellKit

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    
   // var categories = [Category]()
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext

//
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
          loadCategories()
        tableView.separatorStyle = .none
        

        }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row]{
            cell.textLabel?.text = category.name
            //RandomFlatColorInArray(@[FlatWhite, FlatRed, FlatBlue])
            //cell.backgroundColor = UIColor(hexString:category.colour ?? "1D9BF6")
            guard let categoryColour = UIColor(hexString:category.colour) else {fatalError()}
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            
            
        }
         // UIColor(randomFlatColorOfShadeStyle:.Light)
        return cell
        
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender:self)
     //   print(categories[indexPath.row])

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
        
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
      //  super.updateModel(at: indexPath)
         // print("Item Deleted")
                    if let categoryForDeletion = self.categories?[indexPath.row] {
                        do {
                            try self.realm.write {
                                self.realm.delete(categoryForDeletion)
                            }
                        } catch {
                            print("Error deleting Category, \(error)")
                        }
                        tableView.reloadData()
          }
    }

    
     //MARK: - Add new Categories
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add ", style: .default) { (action) in
              
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
        //    self.categories.append(newCategory)
            self.save(category: newCategory)
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Creat new Category"
            //   print(alertTextField.text)
            
            
            //  print(alertTextField.text)
            //  print("Now")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    //MARK -Model Manupulation Method
    func save(category: Category)  {
        //let encoder = PropertyListEncoder()
        do {
            //   let data =  try encoder.encode(itemArray)
            // try data.write(to: dataFilePath!)
            
            
//            let context = (UIApplication.shared.delegate as!
//                AppDelegate).persistentContainer.viewContext
          try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("Error saving context, \(error)")
            //  print("Error encoding item array, \(error)")
            
            
        }
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        self.tableView.reloadData()
        
    }
    
    func loadCategories()  {
        categories = realm.objects(Category.self)
        tableView.reloadData()
        }

    
}
    
   
    

