//
//  ExercisesTableViewCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/08.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class ExercisesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
        
    var exercise: Exercise?
    
    var expanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setExercise(with exercise: Exercise) {
        self.exercise = exercise
        
        nameLabel.text = exercise.name
        categoryLabel.text = exercise.category
    }
}

