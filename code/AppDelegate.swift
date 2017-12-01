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
    var Stored_Events : [Event] = []
    var Stored_Topics : [Topic] = []
    var Stored_VotingTopics : [VotingTopic] = []
    var Stored_VotingDates : [VotingDate] = []
    var Current_Date : Date = Date()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var all_stored_items : [Any] = [[], [], [], []]
        
        // Load data from json file
        if let path = Bundle.main.path(forResource: "topics", ofType: "json") {
            print(path)
            do {
                print("Load JSON From File")
                let json_from_file = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
                print("JSON Loaded")
                print(json_from_file)
                print("Decoding JSON")
                all_stored_items = try JSONDecoder().decode([StoredData].self, from: json_from_file.data(using: .utf8)!)
                self.Stored_Events = all_stored_items[0] as! [Event]
                self.Stored_Topics = all_stored_items[1] as! [Topic]
                self.Stored_VotingTopics = all_stored_items[2] as! [VotingTopic]
                self.Stored_VotingDates = all_stored_items[3] as! [VotingDate]
                print(self.Stored_Topics)
            }
            catch {/* Silent fail to default with no data */}
        }
        
        let shown_startup_about = UserDefaults.standard.bool(forKey: "shown_startup_about")
        
        if shown_startup_about {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Topics")
        }
        else {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "About")
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

