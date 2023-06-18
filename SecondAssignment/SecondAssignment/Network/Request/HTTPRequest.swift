//
//  HTTPRequest.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

struct HTTPRequest {
    let endpoint: Endpoint
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let body: Data?

    init(
        endpoint: Endpoint,
        method: HTTPMethod,
        headers: HTTPHeaders? = nil,
        body: Data? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.headers = headers
        self.body = body
    }
}
