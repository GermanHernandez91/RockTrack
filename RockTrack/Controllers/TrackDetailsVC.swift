//
//  TrackDetailsVC.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class TrackDetailsVC: UIViewController {
    
    // MARK: - Properties
    
    var track: Track!
    
    let headerImage = RTImageView(frame: .zero)
    let backButton  = RTBackImageView(frame: .zero)
    let viewButton  = RTButton(backgroundColor: .purple, title: "More details")
    let favButton   = RTButton(backgroundColor: .blue, title: "Add to favorites")
    let trackName   = RTTitleLabel(textAlignment: .left, fontSize: 26)
    let artistName  = RTSecondaryLabel(fontSize: 22)
    let trackPrice  = RTBodyLabel(textAlignment: .left)
    let duration    = RTBodyLabel(textAlignment: .left)
    let releaseData = RTBodyLabel(textAlignment: .left)
    
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(headerImage, backButton, trackName, artistName, trackPrice, duration, releaseData, viewButton, favButton)

        configureViewController()
        configureHeaderImage()
        configureBackButton()
        configureTrackContent()
        configureViewButton()
        configureFavButton()
    }
    
    
    // MARK: - Methods
    
    func configureViewController() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    
    func configureHeaderImage() {
        headerImage.downloadImage(fromURL: track.artworkUrl100)
        
        headerImage.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: view.topAnchor),
            headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImage.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    
    func configureBackButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonPressed))
        backButton.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    func configureTrackContent() {
        let dateFormatted = track.releaseDate.convertStringToDate()
        let dateStringFormatted = dateFormatted.convertDateToString()
        let timeFormatted = String(format: "%.2f", Double(track.trackTimeMillis) / 60000)
        
        trackName.text      = track.trackName
        artistName.text     = track.artistName
        trackPrice.text     = "$\(track.trackPrice)"
        duration.text       = "Duration: \(timeFormatted) minutes"
        releaseData.text    = "Release date: \(dateStringFormatted)"
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            trackName.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: padding),
            trackName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            trackName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trackName.heightAnchor.constraint(equalToConstant: 40),
            
            artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor),
            artistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            artistName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            artistName.heightAnchor.constraint(equalToConstant: 35),
            
            trackPrice.topAnchor.constraint(equalTo: artistName.bottomAnchor),
            trackPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            trackPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trackPrice.heightAnchor.constraint(equalToConstant: 20),
            
            duration.topAnchor.constraint(equalTo: trackPrice.bottomAnchor, constant: 30),
            duration.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            duration.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            duration.heightAnchor.constraint(equalToConstant: 20),
            
            releaseData.topAnchor.constraint(equalTo: duration.bottomAnchor),
            releaseData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            releaseData.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            releaseData.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    func configureViewButton() {
        viewButton.addTarget(self, action: #selector(viewButtonPressed), for: .touchUpInside)
        
        let padding: CGFloat        = 10
        let heightPadding: CGFloat  = 50
        
        NSLayoutConstraint.activate([
            viewButton.topAnchor.constraint(equalTo: releaseData.bottomAnchor, constant: heightPadding),
            viewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            viewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            viewButton.heightAnchor.constraint(equalToConstant: heightPadding),
        ])
    }
    
    
    func configureFavButton() {
        favButton.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: viewButton.bottomAnchor, constant: 20),
            favButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            favButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            favButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    
    @objc func viewButtonPressed() {
        guard let url = URL(string: track.trackViewUrl) else {
            self.pressentAlertOnMainThread(title: "Something went wrong", message: "Invalid URL provided")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    
    @objc func favButtonPressed() {
        PersistenceManager.updateWith(track: track, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.pressentAlertOnMainThread(title: "Success", message: "You have successfully favorited this track.")
                return
            }
            
            self.pressentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
        }
    }
}
