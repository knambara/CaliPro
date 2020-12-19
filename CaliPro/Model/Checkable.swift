//
//  Checkable.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/09.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

struct Checkable<Item> {
    var isChecked: Bool
    var item: Item
    
    init (with item: Item, checked: Bool) {
        self.item = item
        self.isChecked = checked
    }
}
