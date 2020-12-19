//
//  WorkoutConfigurationCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/07.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class WorkoutIdentifierCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
        
    var delegate: AddWorkoutTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func setPlaceholder(placeholder: String) {
        placeholderLabel.text = placeholder
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let delegate = self.delegate else { return }
        guard let identifier = placeholderLabel.text else { return }
        
        delegate.cellContentChanged(cellIdentifier: identifier, content: text)
    }
}
