//
//  ExercisesTableViewController.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/08.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit
import CoreData

class ExercisesVC: UITableViewController {
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var sortBarButton: UIBarButtonItem!
    @IBOutlet var exercisesTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var exerciseFRC: NSFetchedResultsController<NSFetchRequestResult>?
    
    var delegate: ExerciseTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResultsController()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configureFetchedResultsController() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        
        // let test: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        exerciseFRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        exerciseFRC?.delegate = self

        do {
            try exerciseFRC?.performFetch()
        } catch {
            print("Could not perforom fetch due to error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = exerciseFRC?.sections else { return 0 }
        return sections[0].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseTableViewCell", for: indexPath) as! ExercisesTableViewCell
        
        if let exercise = exerciseFRC?.object(at: indexPath) as? Exercise {
            cell.setExercise(with: exercise)
        }
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ExercisesTableViewCell
        guard let exercise = cell.exercise else { return }
        
        if let delegate = self.delegate {
            delegate.addExercise(exercise)
            tableView.deselectRow(at: indexPath, animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }

}


// MARK: - NSFetchedResultsControllerDelegate
extension ExercisesVC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("CONTROLLER CONTENT HAS CHANGED")
    }
}


// MARK: - Exercise table view controller delegate
protocol ExerciseTableViewControllerDelegate {
    func addExercise(_ exercise: Exercise)
}
