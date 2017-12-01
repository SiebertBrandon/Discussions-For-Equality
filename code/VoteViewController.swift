//
//  VoteViewController.swift
//  Discuss Action
//
//  Copyright © 2017 Brandon Siebert. All rights reserved.
//

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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close_view_controller(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func vote_topics(_ sender: Any) {
        
        // DO DATA WORK
        var selected_indexes:[Int] = []
        for index in 0...self.tableView.numberOfRows(inSection: 0) {
            if (self.tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType == .checkmark) {
                selected_indexes.append(index)
            }
        }
        
        print(selected_indexes)
        
        
        
        
        let view_controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Calendar")
        navigationController?.pushViewController(view_controller, animated: true)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic_data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = topic_data[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Vote on Topics!"
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
