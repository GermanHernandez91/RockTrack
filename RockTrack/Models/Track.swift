//
//  Track.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

struct Tracks: Codable {
    let resultCount: Int
    let results: [Track]
}


struct Track: Codable {
    let artistName, trackName: String
    let trackViewURL: String
    let artworkUrl100: String
    let trackPrice: Double
    let releaseDate: Date
    let trackTimeMillis: Int

    enum CodingKeys: String, CodingKey {
        case artistName, trackName
        case trackViewURL = "trackViewUrl"
        case artworkUrl100, trackPrice, releaseDate, trackTimeMillis
    }
}
