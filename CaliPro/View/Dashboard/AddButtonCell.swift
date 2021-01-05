//
//  AddButtonCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/11/30.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

protocol AddButtonCellDelegate {
    func callSegueFromAddButton(from section: Int)
}

class AddButtonCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    
    var delegate: AddButtonCellDelegate!
    var section: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setSection(_ section: Int) {
        self.section = section
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        guard let section = self.section else { return }
        
        delegate.callSegueFromAddButton(from: section)
        
    }
    
}

