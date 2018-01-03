//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by yx on 04/01/2018.
//  Copyright © 2018 TechMussayApp. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Item Deleted")
            //            if let categoryForDeletion = self.categories?[indexPath.row] {
            //                do {
            //                    try self.realm.write {
            //                        self.realm.delete(categoryForDeletion)
            //                    }
            //                } catch {
            //                    print("Error deleting Category, \(error)")
            //                }
            //                tableView.reloadData()
            //            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        // options.transitionStyle = .border
        return options
    }
    
    
    
}
//extension CategoryViewController: SwipeTableViewCellDelegate {




