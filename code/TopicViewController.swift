// Name: Brandon Siebert
// Course: CSC 415
// Semester: Fall 2017
// Instructor: Dr. Pulimood 
// Project name: Discuss Action
// Description: iOS application that facilitates active discussion for social justice issues. 
// Filename: TopicViewController.swift
// Description: Provides data views for a specific event. Changes depending upon if the event is in the future or the past.
// Last modified on: 12/4/2017

import UIKit

class TopicViewController: UITableViewController {

    // MARK: - Application properties
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // MARK: - View Controller properties
    @IBOutlet weak var action_button: UIBarButtonItem!
    
    // MARK: - View Controller properties
    var this_event : Event = Event()
    var header_titles : [String] = []
    
    // MARK: - View Controller data source
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = this_event.get_topic().get_name()
        
        if this_event.did_event_pass() {
            header_titles = ["Scheduled", "Description", "Action Items"]
            action_button.title = "Add Action"
        }
        else {
            header_titles = ["Scheduled", "Description", "Tips"]
            action_button.title = "Attend"
            self.tableView.isUserInteractionEnabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button_action(_ sender: Any) {
        
        if this_event.did_event_pass() {
            
        }
        
        else {
            let alertController = UIAlertController(title: "Added to your Calendar", message: "", preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "OK", style: .default)
            {
                (action: UIAlertAction!) in
                
                self.action_button.title = "Unattend"
                self.action_button.tintColor = UIColor.red
            })
            
            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)
        }
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section != 2 { return }
        
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditAction") as! EditActionViewController

        view_controller.item_text = self.tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        
        navigationController?.pushViewController(view_controller, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        else if section == 2 {
            if this_event.did_event_pass() {
                return this_event.get_actions().count
            }
            else {
                return this_event.get_topic().get_tips().count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            if this_event.get_date() == nil {
                cell.textLabel?.text = "No Date Sceduled"
                return cell
            }
            else {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy 'at' h:mm a"
                cell.textLabel?.text = formatter.string(from: this_event.get_date()!)
                return cell
            }
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = this_event.get_topic().get_description()
            return cell
        }
        else if indexPath.section == 2 {
            if this_event.did_event_pass() {
                cell.textLabel?.text = this_event.get_actions()[indexPath.row].get_title()
                cell.detailTextLabel?.text = "\(this_event.get_actions()[indexPath.row].get_title()) votes"
                return cell
            }
            else {
                cell.textLabel?.text = this_event.get_topic().get_tips()[indexPath.row]
                return cell
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header_titles[section]
    }
}
