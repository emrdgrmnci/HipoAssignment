//
//  StringExtension.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func countInstances(of stringToFind: String) -> Int {
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundedRange = range(of: stringToFind, options: [], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundedRange.upperBound, upper: endIndex))
        }
        return count
    }
}


