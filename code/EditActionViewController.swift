//
//  EditActionViewController.swift
//  Discuss Action
//
//  Copyright © 2017 Brandon Siebert. All rights reserved.
//

import UIKit

class EditActionViewController: UITableViewController {
    
    // MARK: - Application properties
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - View Controller properties
    var item_text:String!
    var item_detail:String!
    var isContentEditable:Bool!
    
    
    // MARK: - View Controller data source
    override func viewDidLoad() {
        super.viewDidLoad()

        item_detail = "THINGS THAT ARE DETAILS"
        isContentEditable = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Name" : "Description"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "name_cell", for: indexPath) as! Name_Cell
            
            cell.text_field.text = item_text
            
            cell.text_field.isEnabled = isContentEditable
            
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "d_cell", for: indexPath) as! Description_Cell
            
            cell.text_field.text = item_detail
            
            cell.text_field.isEditable = isContentEditable
            
            return cell
        }
    }
}

/* Create custom cell for editing the name of an action item */
class Name_Cell : UITableViewCell {
    @IBOutlet weak var text_field: UITextField!
}

/* Create custom cell for editing the description of an action item */
class Description_Cell : UITableViewCell {
    @IBOutlet weak var text_field: UITextView!
}
