//
//  RTDataLoadingVC.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RTDataLoadingVC: UIViewController {
    
    var containerView: UIView!
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        if (containerView != nil) {
            DispatchQueue.main.async {
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
}
