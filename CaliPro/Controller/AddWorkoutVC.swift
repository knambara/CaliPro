//
//  AddWorkoutVC.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/05.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit
import CoreData

class AddWorkoutVC: UIViewController, AddWorkoutTableViewCellDelegate, ExerciseTableViewControllerDelegate {

    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var addWorkoutTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var workoutName: String?
    var workoutType: String?
    
    var duration: Int?
    var notes: String?
    
    var exercises: [Exercise] = []
    var workoutBlocks: [WorkoutBlock] = []
    
    var rowIndexToChange: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        saveBarButton.isEnabled = false
        addWorkoutTableView.delegate = self
        addWorkoutTableView.dataSource = self
        addWorkoutTableView.estimatedRowHeight = 200
        addWorkoutTableView.rowHeight = UITableView.automaticDimension
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExerciseList" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ExercisesVC
            targetController.delegate = self
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func backBarButtonPressed(_ sender: Any) {
        // delete workout blocks
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBarButtonPressed(_ sender: Any) {
        // these checks should be redundant
        guard let workoutName = self.workoutName else { return }
        guard let workoutType = self.workoutType else { return }
        guard let duration = self.duration else { return }
        
        print("save")
        let workout = Workout(context: self.context)
        
        for workoutBlock in workoutBlocks {
            workout.addToWorkoutBlocks(workoutBlock)
            workout.name = workoutName
            workout.type = workoutType
            workout.duration = Int16(duration)
        }
        navigationController?.popViewController(animated: true)
        saveContext()
        
    }
    
    private func toggleSaveButton() {
        guard let workoutName = self.workoutName else { return }
        guard let workoutType = self.workoutType else { return }
        guard let duration = self.duration else { return }
        
        if !workoutName.isBlank() && !workoutType.isBlank() && duration > 0 && exercises.count > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - AddWorkoutTableViewCell delegate method
    
    func cellContentChanged(cellIdentifier: String, content: String) {
        switch cellIdentifier {
        case "Workout name":
            self.workoutName = content
        case "Workout type":
            self.workoutType = content
        case "WorkoutDurationCell":
            self.duration = Int(content)
        case "WorkoutNotesCell":
            self.notes = content
        default: //Notes
            return
        }
        
        toggleSaveButton()
    }
    
    func callSegueFromCell(from indexPath: IndexPath, to destination: String) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 1 {
            rowIndexToChange = row
            self.performSegue(withIdentifier: destination, sender: self)
        }
    }
    
    // MARK: - ExerciseTableViewControllerDelegate method
    
    func addExercise(_ exercise: Exercise) {
        if let row = rowIndexToChange {
            self.exercises[row] = exercise
            let block = workoutBlocks[row]
            block.exercise = exercise
            let indexPath = IndexPath(row: row, section: 1)
            addWorkoutTableView.reloadRows(at: [indexPath], with: .left)
            rowIndexToChange = nil
            saveContext()
            return
        }
        self.exercises.append(exercise)
        addWorkoutTableView.reloadData()
        toggleSaveButton()
    }
    
    // MARK: - Table view cell handlers
    
    private func prepareWorkoutIdentifierCell(for row: Int) -> WorkoutIdentifierCell {
        let cell = addWorkoutTableView.dequeueReusableCell(withIdentifier: "WorkoutIdentifierCell") as! WorkoutIdentifierCell
        cell.delegate = self
        
        if row == 0 {
            cell.setPlaceholder(placeholder: "Workout name")
            return cell
        }
        cell.setPlaceholder(placeholder: "Workout type")
        return cell
    }
    
    private func prepareAddExerciseCell() -> AddExerciseCell {
        let cell = addWorkoutTableView.dequeueReusableCell(withIdentifier: "AddExerciseCell") as! AddExerciseCell
        return cell
    }
    
    private func prepareWorkoutBlockCell(for row: Int) -> WorkoutBlockCell {
        let cell = addWorkoutTableView.dequeueReusableCell(withIdentifier: "WorkoutBlockCell") as! WorkoutBlockCell
        cell.delegate = self
        cell.setExercise(exercises[row], row: row)
        cell.configureWorkoutBlock()
        // empty list of workout blocks if table view updated
        if row == 0 {
            workoutBlocks = []
        }
        workoutBlocks.append(cell.block!)
        return cell
    }
    
    private func prepareWorkoutDurationCell() -> WorkoutDurationCell {
        let cell = addWorkoutTableView.dequeueReusableCell(withIdentifier: "WorkoutDurationCell") as! WorkoutDurationCell
        cell.delegate = self
        duration = cell.defaultDuration
        return cell
    }
    
    private func prepareWorkoutNotesCell() -> WorkoutNotesCell {
        let cell = addWorkoutTableView.dequeueReusableCell(withIdentifier: "WorkoutNotesCell") as! WorkoutNotesCell
        cell.delegate = self
        return cell
    }
        
}

// MARK: - UITableViewDataSource

extension AddWorkoutVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return exercises.count +  1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return indexPath.row == exercises.count ? 75 : 150
        case 3:
            return UITableView.automaticDimension
        default:
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            let cell = self.prepareWorkoutIdentifierCell(for: row)
            return cell
        case 1:
            if row == exercises.count {
                let cell = self.prepareAddExerciseCell()
                return cell
            }
            let cell = self.prepareWorkoutBlockCell(for: row)
            return cell
        case 2:
            let cell = self.prepareWorkoutDurationCell()
            return cell
        default:
            let cell = self.prepareWorkoutNotesCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            context.delete(workoutBlocks[indexPath.row])
            workoutBlocks.remove(at: indexPath.row)
            exercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade )
            saveContext()
            tableView.endUpdates()
            toggleSaveButton()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension AddWorkoutVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == exercises.count {
            self.performSegue(withIdentifier: "ShowExerciseList", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 1 && indexPath.row < exercises.count {
            return .delete
        }
        return .none
    }
    
}
