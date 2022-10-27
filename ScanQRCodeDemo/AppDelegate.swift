//
//  AppDelegate.swift
//  ScanQRCodeDemo
//
//  Created by Swapnil Dhavan on 27/10/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Thread.sleep(forTimeInterval: 2)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .gray
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17, weight: .bold)]
            
            UINavigationBar.appearance().standardAppearance = appearance // for scrolling bg color
            UINavigationBar.appearance().compactAppearance = appearance // not sure why it's here, but u can remove it and still works
            UINavigationBar.appearance().scrollEdgeAppearance = appearance // for large title bg color
            UINavigationBar.appearance().tintColor = .white
        }
        
        UINavigationBar.appearance().barTintColor = .gray
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Inter", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black]
        UINavigationBar.appearance().isTranslucent = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController = UIViewController()
        let desC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        initialViewController = UINavigationController(rootViewController: desC)
        initialViewController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ScanQRCodeDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

