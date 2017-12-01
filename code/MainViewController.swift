//
//  MainViewController.swift
//  Discuss Action
//
//  Copyright © 2017 Brandon Siebert. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    // MARK: - Application Properties (WRITTEN BY BRANDON SIEBERT)
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    
    var current_events : [Event] = []
    var past_events : [Event] = []
    
    // MARK: - View Controller data source
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Split Current and Past Events
        for event in app_delegate.Stored_Events {
            print("For Each Event")
            if event.get_date() == nil {
                self.current_events.append(event)
                print("Adding Current Event")
            }
            else if event.get_date()! > app_delegate.Current_Date {
                self.current_events.append(event)
            }
            else if event.get_date()! < app_delegate.Current_Date {
                self.past_events.append(event)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add_topic(_ sender: Any) {
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Vote")
        self.present(view_controller, animated: true, completion: nil)
    }
    
    @IBAction func about(_ sender: Any) {
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "About")
        self.present(view_controller, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        if section == 0 {
            print(current_events.count)
            return current_events.count
        }
        else if section == 1 {
            print(past_events.count)
            return past_events.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Topic") as! TopicViewController
        
        view_controller.topic_name = self.tableView.cellForRow(at: indexPath)?.textLabel?.text
        view_controller.isPastTopic = indexPath.section == 0 ? false : true
        
        navigationController?.pushViewController(view_controller, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        print(indexPath.section)
        if indexPath.section == 0 {
            cell.textLabel?.text = current_events[indexPath.row].get_topic().get_name()
            cell.detailTextLabel?.text = current_events[indexPath.row].get_topic().get_description()
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = past_events[indexPath.row].get_topic().get_name()
            cell.detailTextLabel?.text = past_events[indexPath.row].get_topic().get_description()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Upcoming" : "Past"
    }
}
