//
//  HTTPResponse.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

struct HTTPResponse {
    let statusCode: Int
    let headers: HTTPHeaders
    let data: Data?

    init(statusCode: Int,
         headers: HTTPHeaders,
         data: Data?) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }
}
