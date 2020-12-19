//
//  ExerciseSettingCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/11.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class WorkoutBlockCell: UITableViewCell {
    @IBOutlet weak var placeholder: UILabel!
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var restTimeTextField: UITextField!
    @IBOutlet weak var minRepsTextField: UITextField!
    @IBOutlet weak var maxRepsTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate: AddWorkoutTableViewCellDelegate?
    
    var block: WorkoutBlock?
    var rowNum: Int?
    
    var numSets = 1
    var exercise: Exercise?
    let minNumSets = 1
    let maxNumSets = 10
    
    var restTime = 60
    var minReps = 10
    var maxReps = 15
    
    let restTimeRange = [15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180]
    var minRepsRange: [Int] = Array(1...20)
    var maxRepsRange: [Int] = Array(10...20)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        minusButton.isEnabled = false
        plusButton.isEnabled = true
        restTimeTextField.text = "\(restTime)"
        minRepsTextField.text = "\(minReps)"
        maxRepsTextField.text = "\(maxReps)"
        configurePickerViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeExercise))
        exerciseName.isUserInteractionEnabled = true
        exerciseName.addGestureRecognizer(tap)
    }
    
    @objc
    func changeExercise(sender:UITapGestureRecognizer) {
        print("tap working")
        print(rowNum)
        guard let row = rowNum else { return }
        let indexPath = IndexPath(row: row, section: 1)
        delegate?.callSegueFromCell(from: indexPath, to: "ShowExerciseList")
    }

    @IBAction func minusButtonPressed(_ sender: UIButton) {
        guard let block = self.block else { return }
        
        numSets -= 1
        setsLabel.text = "Sets \(numSets)"
        plusButton.isEnabled = true
        block.numberOfSets -= 1
        saveBlock()
        
        if numSets == minNumSets {
            minusButton.isEnabled = false
        }
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        guard let block = self.block else { return }
        
        numSets += 1
        setsLabel.text = "Sets \(numSets)"
        minusButton.isEnabled = true
        block.numberOfSets += 1
        saveBlock()
        
        if numSets == maxNumSets {
            plusButton.isEnabled = false
        }
    }
    
    private func configurePickerViews() {
        let restTimePicker = UIPickerView()
        restTimePicker.tag = 0
        restTimePicker.delegate = self
        restTimePicker.selectRow(3, inComponent: 0, animated: false)
        restTimeTextField.inputView = restTimePicker

        let minRepsPicker = UIPickerView()
        minRepsPicker.tag = 1
        minRepsPicker.delegate = self
        minRepsPicker.selectRow(minReps-1, inComponent: 0, animated: false)
        minRepsTextField.inputView = minRepsPicker

        let maxRepsPicker = UIPickerView()
        maxRepsPicker.tag = 2
        maxRepsPicker.delegate = self
        
        maxRepsTextField.inputView = maxRepsPicker
    }
    
    func setExercise(_ exercise: Exercise, row: Int) {
        self.exercise = exercise
        self.rowNum = row
        self.setLabels()
    }
    
    func setLabels() {
        guard let row = self.rowNum else { return }
        guard let exercise = self.exercise else { return }
        
        placeholder.text = "Exercise \(row+1)"
        exerciseName.text = exercise.name
    }
    
    func configureWorkoutBlock() {
        guard let sortOrder = self.rowNum else { return }
        guard let exercise = self.exercise else { return }
        // Re-initialize everytime for now
        block = WorkoutBlock.init(context: self.context)
        block!.exercise = exercise
        block!.sortOrderNumber = Int16(sortOrder)
        block!.numberOfSets = Int16(numSets)
        block!.restTime = Int16(restTime)
        block!.minimumReps = Int16(minReps)
        block!.maximumReps = Int16(maxReps)
        saveBlock()
    }
    
    private func saveBlock() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}

// MARK:- Picker view delegate
extension WorkoutBlockCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return restTimeRange.count
        case 1:
            return minRepsRange.count
        default:
            return maxRepsRange.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return "\(restTimeRange[row])"
        case 1:
            return "\(minRepsRange[row])"
        default:
            return "\(maxRepsRange[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let block = self.block else { return }
        
        switch pickerView.tag {
        case 0:
            restTime = restTimeRange[row]
            restTimeTextField.text = "\(restTimeRange[row])"
            block.restTime = Int16(restTime)
            saveBlock()
        case 1:
            pickerView.reloadAllComponents()
            minReps = minRepsRange[row]
            minRepsTextField.text = "\(minRepsRange[row])"
            block.minimumReps = Int16(minReps)
            saveBlock()
            maxRepsRange = Array(minReps...20)
        default:
            pickerView.reloadAllComponents()
            maxReps = maxRepsRange[row]
            maxRepsTextField.text
             = "\(maxRepsRange[row])"
            block.maximumReps = Int16(maxReps)
            saveBlock()
            minRepsRange = Array(1...maxReps)
        }
    }
    
}
