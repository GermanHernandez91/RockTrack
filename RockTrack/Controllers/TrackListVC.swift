//
//  TrackListVC.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class TrackListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }
    

    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Rock Tracks"
    }
}
