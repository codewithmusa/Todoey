//
//  Category.swift
//  Todoey
//
//  Created by yx on 01/01/2018.
//  Copyright © 2018 TechMussayApp. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
    
    
}
