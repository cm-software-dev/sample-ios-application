//
//  ItunesResponse.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation

struct ItunesResponse: Codable {
    let resultCount: Int
    let results: [ItunesTrack]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
}
