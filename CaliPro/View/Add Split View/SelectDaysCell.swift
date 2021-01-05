//
//  SelectDaysCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/23.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class SelectDaysCell: UITableViewCell {

    var selectedDays: [String: Bool] = [
        "sunday": false,
        "monday": false,
        "tuesday": false,
        "wednesday": false,
        "thursday": false,
        "friday": false,
        "saturday": false,
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didPressButton(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "SUN":
            selectedDays["sunday"] = !selectedDays["sunday"]!
            sender.backgroundColor = selectedDays["sunday"]! ? #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1) : #colorLiteral(red: 0.1815615892, green: 0.3587294221, blue: 0.4445202351, alpha: 1)
        case "MON":
            selectedDays["monday"] = !selectedDays["monday"]!
            sender.backgroundColor = selectedDays["monday"]! ? #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1) : #colorLiteral(red: 0.1815615892, green: 0.3587294221, blue: 0.4445202351, alpha: 1)
        case "TUE":
            selectedDays["tuesday"] = !selectedDays["tuesday"]!
            sender.backgroundColor = selectedDays["tuesday"]! ? #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1) : #colorLiteral(red: 0.1815615892, green: 0.3587294221, blue: 0.4445202351, alpha: 1)
        case "WED":
            selectedDays["wednesday"] = !selectedDays["wednesday"]!
            sender.backgroundColor = selectedDays["wednesday"]! ? #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1) : #colorLiteral(red: 0.1815615892, green: 0.3587294221, blue: 0.4445202351, alpha: 1)
        case "THU":
            selectedDays["thursday"] = !selectedDays["thursday"]!
            sender.backgroundColor = selectedDays["thursday"]! ? #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1) : #colorLiteral(red: 0.1815615892, green: 0.3587294221, blue: 0.4445202351, alpha: 1)
        case "FRI":
            selectedDays["friday"] = !selectedDays["friday"]!
            sender.backgroundColor = selectedDays["friday"]! ? #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1) : #colorLiteral(red: 0.1815615892, green: 0.3587294221, blue: 0.4445202351, alpha: 1)
        default:
            selectedDays["saturday"] = !selectedDays["saturday"]!
            sender.backgroundColor = selectedDays["saturday"]! ? #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1) : #colorLiteral(red: 0.1815615892, green: 0.3587294221, blue: 0.4445202351, alpha: 1)
        }
    }
}
