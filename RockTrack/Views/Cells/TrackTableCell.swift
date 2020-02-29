//
//  TrackTableCell.swift
//  RockTrack
//
//  Created by German Hernandez on 29/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class TrackTableCell: UITableViewCell {
    
    static let reuseId: String = "TrackTableCell"
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    func set(for track: Track) {
        textLabel?.text = track.trackName
        detailTextLabel?.text = track.artistName
    }
    
    
    private func configure() {
        accessoryType = .disclosureIndicator
    }
}
