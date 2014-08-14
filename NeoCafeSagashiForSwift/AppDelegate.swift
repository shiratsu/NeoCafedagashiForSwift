//
//  AppDelegate.swift
//  NeoCafeSagashiForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/06/05.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var services_: AnyObject?
    
    let sqliteFileName = "NeoCafeSagashiForSwift.sqlite"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        let gApiKey: String? = "AIzaSyAFJf4BYgUQcDHx-btINI1dRQL5FwA5NTA"
        
        if gApiKey == nil {
            let bundleId = NSBundle.mainBundle().bundleIdentifier
            var format = "Configure APIKey inside GoogleMapAPIKey.h for your "
            "bundle `\(bundleId)`, see README.GoogleMapsSDKDemos for more information"
            NSException(name:"AppDelegate",reason:format,userInfo:nil).raise()
            
            
        }
        GMSServices.provideAPIKey(gApiKey)
        services_ = GMSServices.sharedServices()
        
        copyDefaultStoreIfNecessary()
        //MagicalRecord.setLogLevel(MagicalRecordLogLevelVerbose)
        MagicalRecord.setupCoreDataStackWithStoreNamed(sqliteFileName)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
        MagicalRecord.cleanUp()
    }

    func saveContext () {
        var error: NSError? = nil
        let managedObjectContext = self.managedObjectContext
        if managedObjectContext == nil {
            if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    // #pragma mark - Core Data stack

    // Returns the managed object context for the application.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    var managedObjectContext: NSManagedObjectContext {
        if _managedObjectContext == nil {
            let coordinator = self.persistentStoreCoordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext()
                _managedObjectContext!.persistentStoreCoordinator = coordinator
            }
        }
        return _managedObjectContext!
    }
    var _managedObjectContext: NSManagedObjectContext? = nil

    // Returns the managed object model for the application.
    // If the model doesn't already exist, it is created from the application's model.
    var managedObjectModel: NSManagedObjectModel {
        if _managedObjectModel == nil {
            let modelURL = NSBundle.mainBundle().URLForResource("NeoCafeSagashiForSwift", withExtension: "momd")
            _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        }
        return _managedObjectModel!
    }
    var _managedObjectModel: NSManagedObjectModel? = nil

    // Returns the persistent store coordinator for the application.
    // If the coordinator doesn't already exist, it is created and the application's store added to it.
    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
    
    
        if _persistentStoreCoordinator == nil {
            let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("NeoCafeSagashiForSwift.sqlite")
            
            var error: NSError? = nil
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            if _persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
                /*
                Replace this implementation with code to handle the error appropriately.

                abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                Typical reasons for an error here include:
                * The persistent store is not accessible;
                * The schema for the persistent store is incompatible with current managed object model.
                Check the error message to determine what the actual problem was.


                If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

                If you encounter schema incompatibility errors during development, you can reduce their frequency by:
                * Simply deleting the existing store:
                NSFileManager.defaultManager().removeItemAtURL(storeURL, error: nil)

                * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
                [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true}

                Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

                */
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
        return _persistentStoreCoordinator!
    }
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil

    // #pragma mark - Application's Documents directory
                                    
    // Returns the URL to the application's Documents directory.
    var applicationDocumentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as NSURL
    }
    
    func copyDefaultStoreIfNecessary(){
        var fileManager:NSFileManager = NSFileManager.defaultManager()
        
        var storeUrl:NSURL = NSPersistentStore.MR_urlForStoreName(sqliteFileName)
        NSLog("storeurl %@",storeUrl.path)
        if !fileManager.fileExistsAtPath(storeUrl.path) {
            
            var pathToStore:NSURL! = storeUrl.URLByDeletingLastPathComponent
            var error:NSError? = nil
            
            if !fileManager.createDirectoryAtPath(pathToStore.path, withIntermediateDirectories: true, attributes: nil, error: &error){
                //NSLog("---------------------------------------")
                println(error)
                //NSLog("---------------------------------------")
            }
            
            var storeUrl_shm:NSURL = pathToStore.URLByAppendingPathComponent("NeoCafeSagashiForSwift.sqlite-shm")
            var storeUrl_wal:NSURL = pathToStore.URLByAppendingPathComponent("NeoCafeSagashiForSwift.sqlite-wal")
            
            var defaultStorePath = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("NeoCafeSagashiForSwift", ofType:"sqlite"))
            var defaultStorePath_shm = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("NeoCafeSagashiForSwift", ofType:"sqlite-shm"))
            var defaultStorePath_wal = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("NeoCafeSagashiForSwift", ofType:"sqlite-wal"))
            
            //NSLog("defaultStorePath %@",defaultStorePath)
            if defaultStorePath != nil
            {
                var copyerror:NSError?
                let success =  fileManager.copyItemAtURL(defaultStorePath, toURL:storeUrl, error:&copyerror)
                
                //NSLog("---------------------------------------")
                if !success
                {
                    //NSLog("---------------------------------------")
                    NSLog("%@",copyerror!);
                    //NSLog("---------------------------------------")
                }
            }
            
            if defaultStorePath_shm != nil
            {
                var copyerror:NSError?
                let success =  fileManager.copyItemAtURL(defaultStorePath_shm, toURL:storeUrl_shm, error:&copyerror)
                
                //NSLog("---------------------------------------")
                if !success
                {
                    //NSLog("---------------------------------------")
                    NSLog("%@",copyerror!);
                    //NSLog("---------------------------------------")
                }
            }
            
            if defaultStorePath_wal != nil
            {
                var copyerror:NSError?
                let success =  fileManager.copyItemAtURL(defaultStorePath_wal, toURL:storeUrl_wal, error:&copyerror)
                
                //NSLog("---------------------------------------")
                if !success
                {
                    //NSLog("---------------------------------------")
                    NSLog("%@",copyerror!);
                    //NSLog("---------------------------------------")
                }
            }
        }
    }

}

