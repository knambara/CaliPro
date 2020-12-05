//
//  WorkoutSet.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/28.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

struct WorkoutSet {
    let exercise: ExerciseStruct
    let reps : Int
    let sets: Int
    
    init(exercise: ExerciseStruct, reps: Int, sets: Int) {
        self.exercise = exercise
        self.reps = reps
        self.sets = sets
    }
}
