//
//  Expandable.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/02.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

struct Expandable<Item> {
    var isExpanded: Bool
    var items: [Item]
    
    init (with items: [Item], expanded: Bool) {
        self.items = items
        self.isExpanded = expanded
    }
}
