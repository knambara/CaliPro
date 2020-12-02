//
//  Workout.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/28.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

struct Workout {
    let name: String
    let duration: Int
    let date: Date?
    let type: String?
    let sets: [WorkoutSet]
    
    init(name: String, duration: Int, createdOn date: Date? = nil, type: String? = nil, sets: [WorkoutSet]) {
        self.name = name
        self.duration = duration
        self.sets = sets
        self.date = date
        self.type = type
    }
}
