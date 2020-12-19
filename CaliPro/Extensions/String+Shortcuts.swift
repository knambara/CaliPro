//
//  String+Shortcuts.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/17.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import Foundation

extension String {

    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    func isBlank() -> Bool {
        if self.trimmingCharacters(in: .whitespaces).isEmpty {
            return true
        }
        return false
    }
}
