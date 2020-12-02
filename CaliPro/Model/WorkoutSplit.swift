//
//  Split.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/02.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

struct WorkoutSplit {
    let name: String
    let workouts: [String: Workout]?
    var daysOfWeek = ["Su": false, "M": false, "T": false,"W": false,"Th": false,"F": false,"Sa": false]
    
    init(name: String, workouts: [String: Workout]? = nil, days: [String]) {
        self.name = name
        self.workouts = workouts
        for day in days {
            if self.daysOfWeek[day] != nil {
                self.daysOfWeek[day] = true
            }
        }
    }
}
