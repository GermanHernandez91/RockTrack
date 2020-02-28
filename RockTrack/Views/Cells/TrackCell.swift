//
//  TrackCell.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    static let reuseId = "TrackCell"
    
    let trackImageView = RTImageView(frame: .zero)
    let trackName = RTTitleLabel(textAlignment: .left, fontSize: 22)
    let artistName = RTSecondaryLabel(fontSize: 18)
    let trackPrice = RTBodyLabel(textAlignment: .left)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    func set(for track: Track) {
        trackImageView.downloadImage(fromURL: track.artworkUrl100)
        
        trackName.text  = track.trackName
        artistName.text = track.artistName
        trackPrice.text = "$\(track.trackPrice)"
    }
    
    
    private func configure() {
        addSubviews(trackImageView, trackName, artistName, trackPrice)
        
        trackImageView.layer.cornerRadius   = 5
        trackImageView.layer.maskedCorners  = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        contentView.layer.cornerRadius  = 20
        contentView.layer.borderWidth   = 1
        contentView.layer.borderColor   = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor       = UIColor.lightGray.cgColor
        layer.shadowOffset      = CGSize(width: 0, height: 2)
        layer.shadowRadius      = 6
        layer.shadowOpacity     = 1
        layer.masksToBounds     = false
        layer.shadowPath        = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor   = UIColor.clear.cgColor
        
        backgroundColor = .systemBackground
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            trackImageView.topAnchor.constraint(equalTo: self.topAnchor),
            trackImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            trackImageView.heightAnchor.constraint(equalToConstant: 150),
            trackImageView.widthAnchor.constraint(equalToConstant: 180),
            
            trackName.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            trackName.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: padding),
            trackName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            trackName.heightAnchor.constraint(equalToConstant: 40),
            
            artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor),
            artistName.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: padding),
            artistName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            artistName.heightAnchor.constraint(equalToConstant: 30),
            
            trackPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            trackPrice.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: padding),
            trackPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            trackPrice.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
