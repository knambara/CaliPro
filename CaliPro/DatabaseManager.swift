//
//  DatabaseManager.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/03.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation
import SQLite

final class DatabaseManager {
    let db: Connection
    
    init() throws {
        let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        db = try Connection("database/db .sqlite3")
        try setupDatabase()
    }
    
    private func setupDatabase() throws {
        let exercise = Table("exercise")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let category = Expression<String>("category")
        let equipment = Expression<String>("equipment")
        let description = Expression<String>("description")
        
        let primaryMuscle = Expression<String>("primary muscle")
        let secondaryMuscle = Expression<String>("secondary muscle")
        let difficulty = Expression<String>("difficulty")
        
        // CREATE TABLE
        try db.run(exercise.create { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(category)
            t.column(equipment)
            t.column(description)
            t.column(primaryMuscle)
            t.column(secondaryMuscle)
            t.column(difficulty)
        })
        
        //INSERT INTO
        let insert = exercise.insert(name <- "Pull-up", category <- "bodyweight", equipment <- "pull-up bar", description <- "testing", primaryMuscle <- "back", secondaryMuscle <- "biceps", difficulty <- "intermediate")
        try db.run(insert)
        
        for exercise in try db.prepare(exercise) {
            print("id: \(exercise[id]), name: \(exercise[name]), category: \(exercise[category])")
        }
    }
}
