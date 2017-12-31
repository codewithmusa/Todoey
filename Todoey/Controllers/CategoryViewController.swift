//
//  CategoryViewController.swift
//  Todoey
//
//  Created by yx on 31/12/2017.
//  Copyright © 2017 TechMussayApp. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
           loadCategories()
        

        }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       // let category = categories[indexPath.row]
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
        
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender:self)
     //   print(categories[indexPath.row])

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
        
    }
    
    //MARK: - Data Manipulation Methods
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add ", style: .default) { (action) in
              
            let newCategory = Category(context:self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            field.placeholder = "Creat new Category"
            //   print(alertTextField.text)
            textField = field
            
            //  print(alertTextField.text)
            //  print("Now")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    //MARK -Model Manupulation Method
    func saveCategories()  {
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
    func loadCategories(with request:NSFetchRequest<Category> = Category.fetchRequest())  {
         let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories =  try  context.fetch(request)
        } catch {
            print("Error Loading categories , \(error)")
        }
    }
    
}
    
   
    

