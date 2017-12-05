// Name: Brandon Siebert
// Course: CSC 415
// Semester: Fall 2017
// Instructor: Dr. Pulimood 
// Project name: Discuss Action
// Description: iOS application that facilitates active discussion for social justice issues. 
// Filename: CalendarViewController.swift
// Description: Enables voting functionality to select dates for topics.
// Last modified on: 12/4/2017

import UIKit

class CalendarViewController: UITableViewController {
    
    // MARK: - Application properties
    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    
    // MARK: - View Controller properties
    @IBOutlet weak var submit_button: UIBarButtonItem!

    // MARK: - View Controller properties
    var selected_count = 0
    var selected_topic_indexes : [Int] = []
    var day_data:[Date] {
        var temp:[Date] = []
        for count in 1...10 {
            temp.append(Calendar.current.date(byAdding: .day, value: count, to: Date())!)
        }
        return temp
    }
    
    // MARK: - View Controller data source
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit_days(_ sender: Any) {
        
        // DO DATA WORK
        var selected_indexes:[Int] = []
        for index in 0...self.tableView.numberOfRows(inSection: 0) {
            if (self.tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType == .checkmark) {
                selected_indexes.append(index)
            }
        }
        
        print(selected_indexes)
        var voted_days : [Date] = []
        for selected_index in selected_indexes {
            voted_days.append(day_data[selected_index])
        }
        
        var voted_topics : [Topic] = []
        for selected_topic_index in selected_topic_indexes {
            voted_topics.append(app_delegate.Stored_Topics[selected_topic_index])
        }
        
        if app_delegate.Selected_Event != nil {
            print("Adding votes to event")
            app_delegate.Selected_Event!.add_topic_votes(topics: voted_topics)
            app_delegate.Selected_Event!.add_time_votes(dates: voted_days)
            app_delegate.Selected_Event!.make_decision()
            app_delegate.Stored_Events[0] = app_delegate.Selected_Event!
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day_data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = convert_to_formatted_date(input_date: day_data[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select which days you prefer to meet"
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
            submit_button.isEnabled = false
        }
        
        else {
            submit_button.isEnabled = true
        }
    }
    
    
    // MARK: - Helper functions
    func convert_to_formatted_date(input_date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return dateFormatter.string(from: input_date)
    }
}

