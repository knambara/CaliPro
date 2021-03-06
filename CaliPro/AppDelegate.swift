//
//  AppDelegate.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/28.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Happens first
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().tintColor = UIColor(red: 35/255, green: 234/255, blue: 230/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UITabBar.appearance().clipsToBounds = true
        
        let userDefaults = UserDefaults.standard
        // var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        if userDefaults.bool(forKey: K.preloadedDataKey) == false {
            preloadData()
        } else {
            print("EXERCISES ALREADY PRELOADED")
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    // called when receives a call; e.g. prevents form to be unfilled
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    // when home button pressed or other app opened
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    private func parseCSV(fileName: String) -> [[String]]? {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            return nil
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filepath)
        } catch {
            print(error)
            return nil
        }
        
        var parsed: [[String]] = []
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count != 9 {
                continue
            }
            parsed.append(columns)
        }
        return parsed
    }
    
    private func preloadData() {
        // import data in background thread
        // managed context object must be of type private queue
        // perform changes inside block
        let userDefaults = UserDefaults.standard
        let backgroundContext = persistentContainer.newBackgroundContext()
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.perform {
            if let parsedData = self.parseCSV(fileName: "exercises") {
                print(parsedData)
                do {
                    for data in parsedData {
                        let exercise = Exercise(context: backgroundContext)
                        exercise.name = data[1]
                        exercise.category = data[2]
                        exercise.equipment = data[3]
                        exercise.instruction = data[4]
                        exercise.primary = data[5]
                        exercise.secondary = data[6]
                        exercise.difficulty = data[7]
                        exercise.unilateral = data[8] == "0" ? false : true
                    }
                    try backgroundContext.save()
                    userDefaults.set(true, forKey: K.preloadedDataKey)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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

