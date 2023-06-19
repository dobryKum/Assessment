//
//  AlbumsEndpoint.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

enum AlbumsEndpoint: Endpoint {
    case albums(artistName: String)
    
    var queryItems: HTTPQueryItems? {
        switch self {
        case .albums(let artistName):
            return ["term": artistName,
                    "media": "music",
                    "entity": "album",
                    "attribute": "artistTerm"]
        }
    }
    
    var compositePath: String {
        basePath
    }
    
    private var basePath: String {
        return "/search"
    }
}
