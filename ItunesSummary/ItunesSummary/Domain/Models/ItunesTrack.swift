//
//  ItunesResult.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation

struct ItunesTrack: Codable {
    var trackID: Int
    var artistName: String
    var trackName: String
    var trackPrice: Double
    var currency: String
    var artworkUrl100: String
    var trackTimeMillis: Int
    var releaseDate: String
    var trackViewURL: String
    
    enum CodingKeys: String, CodingKey {
        case artistName, artworkUrl100, trackName, trackPrice, currency, trackTimeMillis, releaseDate
        case trackViewURL = "trackViewUrl"
        case trackID = "trackId"
    }
}

