//
//  Track.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

struct Tracks: Codable, Hashable {
    let resultCount: Int
    let results: [Track]
}


struct Track: Codable, Hashable {
    let artistName: String
    let trackName: String
    let trackViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let trackPrice: Double
    let releaseDate: String
    let trackTimeMillis: Int
}
