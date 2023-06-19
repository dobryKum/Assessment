//
//  Endpoint.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

protocol Endpoint {
    var compositePath: String { get }
    var queryItems: HTTPQueryItems? { get }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkConstants.URLComponents.scheme
        urlComponents.path = NetworkConstants.URLComponents.basePath + compositePath
        urlComponents.queryItems = queryItems?.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }

    var queryItems: HTTPQueryItems? {
        return nil
    }
}
