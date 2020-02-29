//
//  TrackListVC.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class TrackListVC: RTDataLoadingVC {
    
    enum Section { case main }
    
    // MARK: - Properties
    
    var tracks: [Track]         = []
    var filteredTracks: [Track] = []
    var isSearching: Bool       = false
    
    var collectionView: UICollectionView!
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        getTracks()
        configureCellCollectionView()
        configureSearchController()
    }
    
    
    // MARK: - Methods
    
    func configureViewController() {
        title                   = "Rock Tracks"
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a track name"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    func configureCellCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.generateCollectionCellHorizontalCell(in: view))
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: TrackCell.reuseId)
    }
    
    
    func getTracks() {
        showLoadingView()
        
        NetworkManager.shared.getTracks { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let tracks):
                self.tracks = tracks
                self.updateData(with: tracks)
                
            case .failure(let error):
                self.pressentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    func updateData(with tracks: [Track]) {
        filteredTracks = tracks
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
}


// MARK: - UICollectionViewDelegate Extension

extension TrackListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredTracks.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.reuseId, for: indexPath) as! TrackCell
        cell.set(for: filteredTracks[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = TrackDetailsVC()
        let index = indexPath.row
        destVC.track = isSearching ? filteredTracks[index] : tracks[index]
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
}


// MARK: - UISearchResultsUpdating Delegate

extension TrackListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredTracks.removeAll()
            updateData(with: tracks)
            isSearching = false
            return
        }
        
        isSearching     = true
        filteredTracks  = tracks.filter { $0.trackName.lowercased().contains(filter.lowercased()) }
        
        updateData(with: filteredTracks)
    }
}
