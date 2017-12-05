// Name: Brandon Siebert
// Course: CSC 415
// Semester: Fall 2017
// Instructor: Dr. Pulimood 
// Project name: Discuss Action
// Description: iOS application that facilitates active discussion for social justice issues. 
// Filename: DataStructures.swift
// Description: Contains data models used in the application.
// Last modified on: 12/4/2017

import Foundation

// MARK: Data structure description (WRITTEN BY BRANDON SIEBERT)

class Topic : Codable {
    private let name : String
    private let description : String
    private let tips : [String]
    
    init(name : String, description : String, tips : [String]) {
        self.name = name
        self.description = description
        self.tips = tips
    }
    
    func get_name() -> String {
        return self.name
    }
    
    func get_description() -> String {
        return self.description
    }
    
    func get_tips() -> [String] {
        return self.tips
    }
}

class VotingTopic : Codable {
    private var topics : [Topic]
    private var votes : [Int]
    
    init() {
        self.topics = []
        self.votes = []
    }
    
    func get_all_votes() -> [(topic : Topic, count : Int)] {
        var votes_tuple : [(topic : Topic, count : Int)] = []
        for (index, topic) in topics.enumerated() {
            votes_tuple.append((topic, votes[index]));
        }
        return votes_tuple
    }
    
    func add_vote(topic : Topic) {
        let topic_index = topics.index { (tmp_topic) -> Bool in
            return tmp_topic.get_name() == topic.get_name()
        }
        
        if topic_index == nil || topic_index! < 0 {
            topics.append(topic)
            votes.append(1)
        }
        else {
            votes[topic_index!] += 1
        }
    }
}

class Action : Codable {
    private var title : String
    private var description : String
    private var votes : Int
    private var did_vote : Bool = false
    
    init(title : String, description : String) {
        self.title = title
        self.description = description
        self.votes = 0
        self.did_vote = false
    }
    
    func get_title() -> String {
        return self.title
    }
    
    func get_description() -> String {
        return self.description
    }
    
    func get_votes() -> Int {
        return self.votes
    }
    
    func add_vote() {
        if !self.did_vote {
            self.votes = self.votes + 1
            self.did_vote = true
        }
    }
    
    func remove_vote() {
        if self.did_vote {
            self.votes = self.votes - 1
            self.did_vote = false
        }
    }
    
    func set_data (title: String, description: String) {
        self.title = title
        self.description = description
    }
}

class Event : Codable {
    private var chosen_topic : Topic
    private var chosen_date : Date?
    private var stage : Int
    private var topics : [Topic]
    private var votes : [Int]
    private var dates : [Date]
    private var actions : [Action]
    
    init() {
        self.chosen_topic = Topic(name: "Topic Undecided", description: "", tips: ["", "", ""])
        self.chosen_date = nil
        self.stage = 0
        self.topics = []
        self.votes = []
        self.dates = []
        self.actions = []
    }
    
    func did_event_pass() -> Bool {
        if (self.chosen_date == nil) {
            return false
        }
        else {
            return Date() > self.chosen_date!
        }
    }
    
    func get_topic() -> Topic {
        return chosen_topic
    }
    
    func set_topic(topic : Topic) {
        self.chosen_topic = topic
    }
    
    func get_date() -> Date? {
        if self.chosen_date != nil {
            return self.chosen_date!
        }
        else {
            return nil
        }
    }
    
    func set_date(date : Date?) {
        self.chosen_date = date
    }
    
    func add_topic_votes (topics : [Topic]) {
        for iter_topic in topics {
            let prev_index = self.topics.index(where: { $0.get_name() == iter_topic.get_name()})
            if  prev_index != nil {
                self.votes[prev_index!] += 1
            }
            else {
                self.topics.append(iter_topic)
                self.votes.append(1)
            }
        }
    }
    
    func add_time_votes (dates: [Date]) {
        for date in dates {
            self.dates.append(date)
        }
    }
    
    func get_stage() -> Int {
        return self.stage
    }
    
    func set_stage(stage : Int) {
        self.stage = stage
    }
    
    func add_action(action : Action) {
        self.actions.append(action)
    }
    
    func get_actions() -> [Action] {
        return self.actions
    }
    
    func delete_action(index : Int) -> Bool {
        if index > actions.count || index < 0 {
            self.actions.remove(at: index)
            return true
        }
        return false
    }
    func edit_action(index : Int, title : String, description : String) -> Bool {
        if index > actions.count || index < 0 {
            let tmp_action = Action(title : title, description : description)
            self.actions[index] = tmp_action
            return true
        }
        return false
    }
    
    func next_stage() {
        self.stage += 1
    }
    
    func make_decision() {
        let highest_voted_topic = topics[votes.index(of: votes.max()!)!]
        let decided_date = dates[0]
        
        self.chosen_topic = highest_voted_topic
        self.chosen_date = decided_date
        
        self.next_stage()
    }
    
    
}

class VotingDate : Codable {
    private var preferred_days : [Date]
    
    init() {
        self.preferred_days = []
    }
    
    func get_preferred_days() -> [Date] {
        return self.preferred_days
    }
    
    func add_preferred_days(dates : [Date]) {
        for date in dates {
            self.preferred_days.append(date)
        }
    }
    func add_preferred_days(date : Date) {
        self.preferred_days.append(date)
    }
}

struct StoredData : Codable {
    var events : [Event]
    
    init(events : [Event]) {
        self.events = events
    }
}
