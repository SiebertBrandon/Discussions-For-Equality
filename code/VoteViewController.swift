// Name: Brandon Siebert
// Course: CSC 415
// Semester: Fall 2017
// Instructor: Dr. Pulimood 
// Project name: Discuss Action
// Description: iOS application that facilitates active discussion for social justice issues. 
// Filename: VoteViewController.swift
// Description: Controller for topic list voting view.
// Last modified on: 12/4/2017

import UIKit

class VoteViewController: UITableViewController {

    // MARK: - Application properties
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // MARK: - View Controller properties
    @IBOutlet weak var vote_button: UIBarButtonItem!
    
    
    // MARK: - View Controller data properties
    var selected_count = 0
    var topic_data : [String] = ["Test"]
    
    // MARK: - View Controller data source
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close_view_controller(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func vote_topics(_ sender: Any) {
        
        var selected_indexes:[Int] = []
        for index in 0...self.tableView.numberOfRows(inSection: 0) {
            if (self.tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType == .checkmark) {
                selected_indexes.append(index)
            }
        }
        
        print(selected_indexes)
        
        
        
        
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Calendar") as! CalendarViewController
        
        view_controller.selected_topic_indexes = selected_indexes
        
        navigationController?.pushViewController(view_controller, animated: true)
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app_delegate.Stored_Topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = app_delegate.Stored_Topics[indexPath.row].get_name()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Your Preferred Topics"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let select_cell = tableView.cellForRow(at: indexPath)
        
        if select_cell?.accessoryType == .checkmark {
            select_cell?.accessoryType = .none
            selected_count -= 1
        }
            
        else {
            select_cell?.accessoryType = .checkmark
            selected_count += 1
        }
        
        if selected_count == 0 {
            vote_button.isEnabled = false
        }
            
        else {
            vote_button.isEnabled = true
        }
    }
}
