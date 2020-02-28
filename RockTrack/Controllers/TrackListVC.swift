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
    
    var tracks: [Track] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Track>!
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        getTracks()
        configureCellCollectionView()
        configureDataSource()
    }
    
    
    // MARK: - Methods
    
    func configureViewController() {
        title                   = "Rock Tracks"
        view.backgroundColor    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCellCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.generateCollectionCellHorizontalCell(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: TrackCell.reuseId)
    }
    
    
    func getTracks() {
        showLoadingView()
        
        NetworkManager.shared.getTracks { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let tracks):
                self.tracks.append(contentsOf: tracks)
                self.updateData(on: self.tracks)
                
            case .failure(let error):
                self.pressentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    func updateData(on tracks: [Track]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Track>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tracks)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Track>(collectionView: collectionView, cellProvider: { collectionView, indexPath, track -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.reuseId, for: indexPath) as! TrackCell
            cell.set(for: track)
            return cell
        })
    }
}


// MARK: - UITableView Extension

extension TrackListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Pressed")
    }
}
