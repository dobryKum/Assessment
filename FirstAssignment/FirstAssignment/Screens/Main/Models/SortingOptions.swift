//
//  SortingOptions.swift
//  FirstAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

enum SortingOptions: String, CaseIterable {
    case alphabetical = "Alphabetically"
    case frequency = "Word frequency"
    case length = "Word length"
    
    var sortMethod: (Word, Word) -> Bool {
        switch self {
        case .alphabetical:
            return { lhs, rhs in
                lhs.text < rhs.text
            }
        case .frequency:
            return { lhs, rhs in
                lhs.numberOfOccurrences > rhs.numberOfOccurrences
            }
        case .length:
            return { lhs, rhs in
                lhs.text.count > rhs.text.count
            }
        }
    }
}
