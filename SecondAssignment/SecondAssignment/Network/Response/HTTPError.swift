//
//  HTTPError.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

enum HTTPError: Error {
    case networkError(Error)
    case parsingError
    case timeout
    case unsuccessStatus(Int)
    case incorrectUrl
    case undefined
}
