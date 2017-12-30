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
    var itemArray = [Item]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        }

    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    //MARK: - Data Manipulation Methods
    
    
}
