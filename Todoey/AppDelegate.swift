//
//  AppDelegate.swift
//  Todoey
//
//  Created by yx on 27/12/2017.
//  Copyright © 2017 TechMussayApp. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
//        let data = Data()
//        data.name = "Musa"
//        data.age = 12
//
        do {
          _ = try Realm()
           //  try realm.write {
             //   realm.add(data)
      } catch {
            print("Error initialising new realm, \(error)")
        }
    

    //    print("didFinishlaunchingwithoption")
        
        return true
    }
}
