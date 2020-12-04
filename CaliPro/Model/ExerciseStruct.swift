//
//  Exercise.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/28.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

struct ExerciseStruct {
    let name: String
    let description: String
    let equipment: [String]
    
    let category: String
    let primaryMuscle: [String]
    let secondaryMuscle: [String]?
    let difficulty: String
    
    init(name: String, description: String, equipment: [String], category: String, primaryMuscle: [String], secondaryMuscle: [String]? = nil, difficulty: String) {
        self.name = name
        self.description = description
        self.equipment = equipment
        self.category = category
        self.primaryMuscle = primaryMuscle
        self.secondaryMuscle = secondaryMuscle
        self.difficulty = difficulty
    }
}
