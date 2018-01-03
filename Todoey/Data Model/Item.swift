//
//  Item.swift
//  Todoey
//
//  Created by yx on 01/01/2018.
//  Copyright © 2018 TechMussayApp. All rights reserved.
//

import Foundation

import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc  dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var ParentCategory = LinkingObjects(fromType: Category.self, property: "items")
    //@objc dynamic var dateCreated = NSDate()
    
    
    
}
