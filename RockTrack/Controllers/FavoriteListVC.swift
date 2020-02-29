//
//  FavoriteListVC.swift
//  RockTrack
//
//  Created by German Hernandez on 29/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class FavoriteListVC: RTDataLoadingVC {
    
    // MARK: - Properties
    
    let tableView           = UITableView()
    var favorites: [Track]  = []
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
    
    
    // MARK: - Methods
    
    func configureViewController() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(TrackTableCell.self, forCellReuseIdentifier: TrackTableCell.reuseId)
    }
    
    
    func getFavorites() {
        showLoadingView()
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    func updateUI(with favorites: [Track]) {
        if favorites.isEmpty {
            showEmptyStateView(with: "No Favorites?\nAdd one on the search screen.", in: view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}


// MARK: UITableView Delegate / Data Source

extension FavoriteListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableCell.reuseId, for: indexPath) as! TrackTableCell
        cell.set(for: favorites[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
            
        PersistenceManager.updateWith(track: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentAlertOnMainThread(title: "Unable to delete", message: error.rawValue)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = TrackDetailsVC()
        destVC.track = favorites[indexPath.row]
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
}
