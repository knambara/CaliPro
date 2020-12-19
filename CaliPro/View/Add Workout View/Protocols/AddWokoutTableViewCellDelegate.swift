//
//  AddWokoutTableViewCellDelegate.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/17.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

protocol AddWorkoutTableViewCellDelegate {
    func cellContentChanged(cellIdentifier: String, content: String)
    
    func callSegueFromCell(from indexPath: IndexPath, to destination: String)
}
