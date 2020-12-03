//
//  Task.swift
//  CS275IndividualProject
//
//  Created by Owen Anderson on 11/14/20.
//

import UIKit

// basic class to hold a task object
class Task: NSObject, Decodable, Encodable {
    var name: String
    var date: String
    var desc: String

    init(name: String, date: String, desc: String){
        self.name = name
        self.date = date
        self.desc = desc
    }
}
