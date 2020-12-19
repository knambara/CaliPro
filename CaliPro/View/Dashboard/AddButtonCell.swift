//
//  AddButtonCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/30.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

protocol AddButtonCellDelegate {
    func callSegueFromAddButton(myData dataobject: AnyObject)
}

class AddButtonCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    var delegate: AddButtonCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        print("addPressed")
        if self.delegate != nil {
            self.delegate.callSegueFromAddButton(myData: "add button pressed" as AnyObject)
        }
    }
    
}

