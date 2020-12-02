//
//  WorkoutSplitCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/02.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class WorkoutSplitCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var splitNameLabel: UILabel!
    @IBOutlet weak var daysOfWeekLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabels(with split: WorkoutSplit) {
        self.splitNameLabel.text = split.name
        self.daysOfWeekLabel.text = ""
        
        let days = ["Su", "M", "T","W","Th","F","Sa"]
        for day in days {
            if (split.daysOfWeek[day] == true) {
                self.daysOfWeekLabel.text?.append(day)
            }
        }
    }

}
