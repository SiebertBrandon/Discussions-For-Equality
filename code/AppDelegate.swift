//
//  AppDelegate.swift
//  Discuss Action
//
//  Copyright © 2017 Brandon Siebert. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Application Properties (WRITTEN BY BRANDON SIEBERT)
    
    var window: UIWindow?
    var has_shown_about : Bool = false
    var Stored_Events : [Event] = []
    var Stored_Topics : [Topic] = []
    var Current_Date : Date = Date()
    
    var Selected_Event : Event? = nil
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //var all_stored_items : Any = [[], [], [], []]
        
        // Load data from json file
        if let path = Bundle.main.path(forResource: "topics", ofType: "json") {
            print(path)
            do {
                let topics_json_from_file = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
                let loaded_topics = try JSONDecoder().decode([Topic].self, from: topics_json_from_file.data(using: .utf8)!)
                self.Stored_Topics = loaded_topics
                print(Stored_Topics)
            }
            catch {
                print("error: \(error)")
            }
        }
        if let loaded_events = UserDefaults.standard.object(forKey: "events") {
            self.Stored_Events = loaded_events as! [Event]
            print(Stored_Events)
        }
            
        // If there is no stored session available, load from defaults json
        else if let path = Bundle.main.path(forResource: "events", ofType: "json") {
            print(path)
            do {
                let events_json_from_file = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
                self.Stored_Events = try JSONDecoder().decode([Event].self, from: events_json_from_file.data(using: .utf8)!)
                print(Stored_Events)
            }
            catch {
                print("error: \(error)")
            }
        }
        // If all else fails, initialize to empty
        else {
            self.Stored_Events = []
            self.Stored_Events.append(Event())
            print(Stored_Events)
        }
        
        var has_shown_about = UserDefaults.standard.bool(forKey: "has_shown_about")
        
        if has_shown_about {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Topics")
        }
        else {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "About")
            has_shown_about = true;
            UserDefaults.standard.set(has_shown_about, forKey: "has_shown_about")
        }
        return true
    }

    // MARK: Application state listeners (FRAMEWORK)
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

