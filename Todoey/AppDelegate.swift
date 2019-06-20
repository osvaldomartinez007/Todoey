//
//  AppDelegate.swift
//  Todoey
//
//  Created by OSVALDO MARTINEZ on 5/27/19.
//  Copyright © 2019 OSVALDO MARTINEZ. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // first thing when launched even before appears
        // Override point for customization after application launch.


        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    // persistent container is a global variable is actually a SQL lite data base although it can be changed
    // lazy value is loaded only when needed - occupies memory only wen needed
    lazy var persistentContainer: NSPersistentContainer = {
 
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    // new method save context, save data temporarily until you are able to commit into the container
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
            
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



}

