//
//  DashboardViewController.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/30.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var workoutTableView: UITableView!
    var workouts: [Workout] = []
    var splits: [WorkoutSplit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        
        workoutTableView.dataSource = self
        workoutTableView.delegate = self
        workoutTableView.register(UINib(nibName: K.splitCellNibname, bundle: nil), forCellReuseIdentifier: K.splitCellNibname)
        workoutTableView.register(UINib(nibName: K.itemCellNibname, bundle: nil), forCellReuseIdentifier: K.itemCellNibname)
        workoutTableView.register(UINib(nibName: K.addCellNibname, bundle: nil), forCellReuseIdentifier: K.addCellNibname)
        workoutTableView.rowHeight = 100;
        
        populateWorkouts()
        populateSplits()
    }
    
    func populateWorkouts() {
        let exercise1 = Exercise(name: "pull-up", description: "test", equipment: ["pull-up bar"], category: "bodyweight", primaryMuscle: ["back"], difficulty: "intermediate")
        let workoutSet = WorkoutSet(exercise: exercise1, reps: 10, sets: 4)
        let workout = Workout(name: "Test Workout", duration: 60, sets: [workoutSet])
        workouts.append(workout)
    }
    
    func populateSplits() {
        let split1 = WorkoutSplit(name: "split1", days: ["M","T", "W", "Th", "F"])
        let split2 = WorkoutSplit(name: "split2", days: ["M","T", "W", "Th", "F"])
        let split3 = WorkoutSplit(name: "split3", days: ["M","T", "W", "Th", "F"])
        splits.append(split1)
        splits.append(split2)
        splits.append(split3)
    }

}

 // MARK: - DataSource

extension DashboardVC: UITableViewDataSource {
    
    @objc func toggleSection() {
//        var indexPaths = [IndexPath]()
//        for row in workouts.indices {
//            let indexPath = IndexPath(row: row, section: 0)
//            indexPaths.append(indexPath)
//        }
//
//        self.workoutTableView.deleteRows(at: indexPaths, with: .fade)
        print("toggled")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let label = UILabel()
        //        label.text  = "Header"
        //        label.backgroundColor = .lightGray
        //        return label
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .yellow
        
        button.addTarget(self, action: #selector(toggleSection), for: .touchUpInside)
        
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.splits.count + 1
        }
        return self.workouts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Workout splits section
        if (indexPath.section == 0) {
            if (indexPath.row == self.splits.count) {
                let addButton = tableView.dequeueReusableCell(withIdentifier: K.addCellNibname) as! AddButtonCell
                return addButton
            }
            let workoutSplitCell = tableView.dequeueReusableCell(withIdentifier: K.splitCellNibname ) as! WorkoutSplitCell
            workoutSplitCell.setLabels(with: self.splits[indexPath.row])
            return workoutSplitCell
        }
        
        // Workout items section
        if (indexPath.row == self.workouts.count) {
            let addButton = tableView.dequeueReusableCell(withIdentifier: K.addCellNibname) as! AddButtonCell
            return addButton
        }
        let workout = workouts[indexPath.row]
        let workoutCell = tableView.dequeueReusableCell(withIdentifier: K.itemCellNibname ) as! WorkoutCell
        workoutCell.setLabels(with: workout)
        return workoutCell
    }
    
}

 // MARK: - Delegate

extension DashboardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
