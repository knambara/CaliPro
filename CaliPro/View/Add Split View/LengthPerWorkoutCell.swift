//
//  LengthPerWorkoutCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/29.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class LengthPerWorkoutCell: UITableViewCell {
    
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    
    let hoursRange = [0, 1, 2]
    let minutesRange = [0, 15, 30, 45]
    
    var currentHour = 0
    var currentMinute = 30
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hoursTextField.text = "\(currentHour)"
        minutesTextField.text = "\(currentMinute)"
        configurePickerView()
    }
    
    private func configurePickerView() {
        let hoursPickerView = UIPickerView()
        hoursPickerView.delegate = self
        hoursPickerView.tag = 0
        hoursPickerView.selectRow(0, inComponent: 0, animated: false)
        hoursTextField.inputView = hoursPickerView
        
        let minutesPickerView = UIPickerView()
        minutesPickerView.delegate = self
        minutesPickerView.tag = 1
        minutesPickerView.selectRow(2, inComponent: 0, animated: false)
        minutesTextField.inputView = minutesPickerView
    }

}

extension LengthPerWorkoutCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return hoursRange.count
        default:
            return minutesRange.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return "\(hoursRange[row])"
        default:
            return "\(minutesRange[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            currentHour = hoursRange[row]
            hoursTextField.text = "\(currentHour)"
        default:
            currentMinute = minutesRange[row]
            minutesTextField.text = "\(currentMinute)"
        }
    }
}
