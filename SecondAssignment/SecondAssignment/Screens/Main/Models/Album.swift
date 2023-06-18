//
//  Album.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 18.06.23.
//

import Foundation

struct Album: Codable {
    let albumName: String
    let artistName: String
    
    enum CodingKeys: String, CodingKey {
        case albumName = "collectionName"
        case artistName
    }
}
