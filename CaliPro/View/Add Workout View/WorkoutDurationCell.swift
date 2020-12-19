//
//  WorkoutDurationCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/17.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class WorkoutDurationCell: UITableViewCell {
    @IBOutlet weak var durationTextField: UITextField!
    
    let identifier = "WorkoutDurationCell"
    
    var delegate: AddWorkoutTableViewCellDelegate?
    
    let defaultDuration = 30
    let minDuration = 1
    let maxDuration = 120
    
    override func awakeFromNib() {
        super.awakeFromNib()
        durationTextField.text = "\(defaultDuration) min"
        durationTextField.keyboardType = .numberPad
        durationTextField.delegate = self
    }
    
}


// MARK: - Text field delegate

extension WorkoutDurationCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let _ = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
           return true
        }
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard var numMinutes = textField.text else { return }
        numMinutes = numMinutes.isEmpty ? "\(defaultDuration)" : numMinutes
        
        let minutesAsInt = Int(numMinutes)!
        var minutesAsString = "\(minutesAsInt)"
        
        if Int(minutesAsString)! < minDuration || Int(minutesAsString)! > maxDuration  {
            minutesAsString = "\(defaultDuration)"
        }
        textField.text = "\(minutesAsString) min"
        delegate?.cellContentChanged(cellIdentifier: identifier, content: minutesAsString)
    }
}
