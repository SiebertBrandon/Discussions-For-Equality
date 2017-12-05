// Name: Brandon Siebert
// Course: CSC 415
// Semester: Fall 2017
// Instructor: Dr. Pulimood 
// Project name: Discuss Action
// Description: iOS application that facilitates active discussion for social justice issues. 
// Filename: MainViewController.swift
// Description: Entry point for the application. Controls the main event view list.
// Last modified on: 12/4/2017

import UIKit

class MainViewController: UITableViewController {

    // MARK: - Application Properties (WRITTEN BY BRANDON SIEBERT)
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    
    var current_events : [Int] = []
    var past_events : [Int] = []
    
    // MARK: - View Controller data source
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Count
        for (index, event) in app_delegate.Stored_Events.enumerated() {
            if event.get_date() == nil {
                self.current_events.append(index)
            }
            else {
                print("Comparing: \(event.get_date()!) and \(app_delegate.Current_Date)")
                if event.get_date()! > app_delegate.Current_Date {
                    self.current_events.append(index)
                }
                else if event.get_date()! < app_delegate.Current_Date {
                    event.set_stage(stage : 3)
                    self.past_events.append(index)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add_topic(_ sender: Any) {
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Vote")
        print("Stage : \(app_delegate.Stored_Events[0].get_stage())")
        if app_delegate.Stored_Events[0].get_stage() == 0 {
            app_delegate.Selected_Event = app_delegate.Stored_Events[0]
            self.present(view_controller, animated: true, completion: nil)
        }
       
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

        if section == 0 {
            return self.current_events.count
        }
        else if section == 1 {
            return self.past_events.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Topic") as! TopicViewController
        if indexPath.section == 0 {
            view_controller.this_event = app_delegate.Stored_Events[self.current_events[indexPath.row]]
        }
        else if indexPath.section == 1 {
            view_controller.this_event = app_delegate.Stored_Events[self.past_events[indexPath.row]]
        }
        navigationController?.pushViewController(view_controller, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = app_delegate.Stored_Events[self.current_events[indexPath.row]].get_topic().get_name()
            cell.detailTextLabel?.text = app_delegate.Stored_Events[self.current_events[indexPath.row]].get_topic().get_description()
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = app_delegate.Stored_Events[self.past_events[indexPath.row]].get_topic().get_name()
            cell.detailTextLabel?.text = app_delegate.Stored_Events[self.past_events[indexPath.row]].get_topic().get_description()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Upcoming" : "Past"
    }
}
