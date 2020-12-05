//
//  DashboardViewController.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/30.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit
import CoreData

class DashboardVC: UIViewController {
    
    @IBOutlet weak var workoutTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var exerciseFRC: NSFetchedResultsController<NSFetchRequestResult>?
    private var workoutFRC: NSFetchedResultsController<NSFetchRequestResult>?
    private var splitFRC: NSFetchedResultsController<NSFetchRequestResult>?
    
    var splitSectionExpanded = true
    var workoutSectionExpanded = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let workout1 = Workout(context: context)
        workout1.name = "Test Workout"
        workout1.type = "Upper Body"
        workout1.duration = 45
        let workout2 = Workout(context: context)
        workout2.name = "Test Workout"
        workout2.type = "Upper Body"
        workout2.duration = 45
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        configureFetchedResultsController()
        
        navigationItem.title = "Dashboard"
        
        workoutTableView.dataSource = self
        workoutTableView.delegate = self
        workoutTableView.register(UINib(nibName: K.splitCellNibname, bundle: nil), forCellReuseIdentifier: K.splitCellNibname)
        workoutTableView.register(UINib(nibName: K.itemCellNibname, bundle: nil), forCellReuseIdentifier: K.itemCellNibname)
        workoutTableView.register(UINib(nibName: K.addCellNibname, bundle: nil), forCellReuseIdentifier: K.addCellNibname)
        workoutTableView.rowHeight = 100;
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    private func configureFetchedResultsController() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        let workoutFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        let splitFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Split")
        
        // let test: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        workoutFetchRequest.sortDescriptors = [sortDescriptor]
        splitFetchRequest.sortDescriptors = [sortDescriptor]
        
        exerciseFRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        workoutFRC = NSFetchedResultsController(fetchRequest: workoutFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        splitFRC = NSFetchedResultsController(fetchRequest: splitFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                
        exerciseFRC?.delegate = self
        workoutFRC?.delegate = self
        splitFRC?.delegate = self
        
        do {
            try exerciseFRC?.performFetch()
            try workoutFRC?.performFetch()
            try splitFRC?.performFetch()
        } catch {
            print("Could not perforom fetch due to error: \(error.localizedDescription)")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension DashboardVC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("CONTROLLER CONTENT HAS CHANGED")
        workoutTableView.reloadData()
    }
}

 // MARK: - DataSource

extension DashboardVC: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        section == 0 ? button.setTitle("Splits", for: .normal) : button.setTitle("Workouts", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(toggleSection), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func toggleSection(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        let numSplits = splitFRC?.sections?[0].numberOfObjects ?? 0
        let numWorkouts = workoutFRC?.sections?[0].numberOfObjects ?? 0
        
        if (section == 0) {
            for row in 0..<numSplits+1 {
                let indexPath = IndexPath(row: row, section: 0)
                indexPaths.append(indexPath)
            }
            splitSectionExpanded = !splitSectionExpanded
            if splitSectionExpanded {
                self.workoutTableView.insertRows(at: indexPaths, with: .fade)
            } else {
                self.workoutTableView.deleteRows(at: indexPaths, with: .fade)
            }
            return
        }
        
        for row in 0..<numWorkouts+1 {
            let indexPath = IndexPath(row: row, section: 1)
            indexPaths.append(indexPath)
        }
        workoutSectionExpanded = !workoutSectionExpanded
        if workoutSectionExpanded {
            self.workoutTableView.insertRows(at: indexPaths, with: .fade)
        } else {
            self.workoutTableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            if !splitSectionExpanded { return 0 }
            guard let sections = splitFRC?.sections else { return 0 }
            return sections[0].numberOfObjects+1
        }
        if !workoutSectionExpanded { return 0 }
        guard let sections = workoutFRC?.sections else { return 0 }
        return sections[0].numberOfObjects+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addButton = tableView.dequeueReusableCell(withIdentifier: K.addCellNibname) as! AddButtonCell
        let splitCell = tableView.dequeueReusableCell(withIdentifier: K.splitCellNibname ) as! WorkoutSplitCell
        let workoutCell = tableView.dequeueReusableCell(withIdentifier: K.itemCellNibname ) as! WorkoutCell
        
        if (indexPath.section == 0) {
            if (indexPath.row == splitFRC?.sections?[0].numberOfObjects) {
                return addButton
            }
            if let split = splitFRC?.object(at: indexPath) as? Split {
                print(indexPath)
                splitCell.setLabels(with: split)
            }
            return splitCell
        }
        
        if (indexPath.row == workoutFRC?.sections?[0].numberOfObjects) {
            return addButton
        }
        let path = IndexPath(row: indexPath.row, section: 0)
        if let workout = workoutFRC?.object(at: path) as? Workout {
            workoutCell.setLabels(with: workout)
        }
        return workoutCell
    }
}

 // MARK: - Delegate

extension DashboardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
