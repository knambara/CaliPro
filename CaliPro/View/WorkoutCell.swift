//
//  WorkoutCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/30.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {

    @IBOutlet weak var workoutContainer: UIView!
    @IBOutlet weak var workoutTitleLabel: UILabel!
    @IBOutlet weak var workoutDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        workoutContainer.layer.cornerRadius = workoutContainer.frame.size.height / 5
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        workoutContainer.addGestureRecognizer(gesture)
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        print("yay")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabels(with workout: Workout) {
        self.workoutTitleLabel.textColor = .white
        self.workoutDurationLabel.textColor = .white
        self.workoutTitleLabel.text = workout.name
        self.workoutDurationLabel.text = "\(workout.duration) min."
    }
}
