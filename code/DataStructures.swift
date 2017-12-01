//
//  DataStructures.swift
//  Discuss Action
//
//  Copyright © 2017 Brandon Siebert. All rights reserved.
//

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
    private var topic : Topic
    private var votes : Int
    
    init(topic : Topic) {
        self.topic = topic
        self.votes = 0
    }
    
    func get_topic() -> Topic {
        return self.topic
    }
    
    func get_votes() -> Int {
        return self.votes
    }
    
    func add_vote() {
        self.votes = self.votes + 1
    }
    
    func set_votes(count : Int) {
        self.votes = count
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
    private var topic : Topic
    private var date : Date?
    private var votes : Int
    private var actions : [Action]
    
    init() {
        self.topic = Topic(name: "Topic Undecided", description: "", tips: ["", "", ""])
        self.date = nil
        self.votes = 0
        self.actions = []
    }
    
    func get_topic() -> Topic {
        return topic
    }
    
    func set_topic(topic : Topic) {
        self.topic = topic
    }
    
    func get_date() -> Date? {
        if self.date != nil {
            return self.date!
        }
        else {
            return nil
        }
    }
    
    func set_date(date : Date?) {
        self.date = date
    }
    
    func get_votes() -> Int {
        return self.votes
    }
    
    func set_votes(count : Int) {
        self.votes = count
    }
    
    func add_action(action : Action) {
        self.actions.append(action)
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
}

class VotingDate : Codable {
    var ranges : [[Date]]
    var preferred_days : [Date]
    
    init() {
        self.ranges = []
        self.preferred_days = []
    }
    
    func get_ranges() -> [[Date]] {
        return self.ranges
    }
    
    func add_range(date_range : [Date]) {
        self.ranges.append(date_range)
    }
}

struct StoredData : Codable {
    var events : [Event]
    var topics : [Topic]
    var voting_topics : [VotingTopic]
    var voting_dates : [VotingDate]
    
    init(events : [Event], topics : [Topic], voting_topics : [VotingTopic], voting_dates : [VotingDate]) {
        self.events = events
        self.topics = topics
        self.voting_topics = voting_topics
        self.voting_dates = voting_dates
    }
    
    func save_to_json() {
        if let path = Bundle.main.path(forResource: "topics", ofType: "json") { do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self)
            try jsonData.write(to: URL(fileURLWithPath: path))
        }
        catch {
        }
    }
    }
}
