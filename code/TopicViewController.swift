//
//  TopicViewController.swift
//  Discuss Action
//
//  Copyright © 2017 Brandon Siebert. All rights reserved.
//

import UIKit

class TopicViewController: UITableViewController {

    // MARK: - Application properties
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // MARK: - View Controller properties
    @IBOutlet weak var action_button: UIBarButtonItem!
    
    
    // MARK: - View Controller properties
    var isPastTopic:Bool!
    var topic_name:String!
    var header_titles:[String]!
    var topic_data:[[String]]!
    let topic_votes = [10, 6, 3, 1]
    
    
    // MARK: - View Controller data source
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = topic_name
        
        if isPastTopic {
            header_titles = ["Scheduled", "Description", "Action Items"]
            topic_data = [["FUNDAY"], ["Cool Stories all around bro..."], ["Do the thing 1", "Do the thing 2", "Do the thing 3"]]
            
            action_button.title = "Add Action"
        }
        
        else {
            header_titles = ["Scheduled", "Description", "Tips"]
            topic_data = [["FUNDAY"], ["Cool Stories all around bro..."],["Be nice", "Be cool", "Be Bae"]]
            
            action_button.title = "Attend"
            self.tableView.isUserInteractionEnabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button_action(_ sender: Any) {
        
        if isPastTopic {
            
        }
        
        else {
            let alertController = UIAlertController(title: "Added to your Calendar", message: "", preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "OK", style: .default)
            {
                (action: UIAlertAction!) in
                
                // APP LOGIC to ATTEND THING
                
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
        return topic_data[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 && isPastTopic {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_d", for: indexPath)
            cell.textLabel?.text = topic_data[indexPath.section][indexPath.row]
            cell.detailTextLabel?.text = "\(topic_votes[indexPath.row]) votes"
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = topic_data[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header_titles[section]
    }
}
