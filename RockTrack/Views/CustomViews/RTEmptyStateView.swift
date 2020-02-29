//
//  RTEmptyStateView.swift
//  RockTrack
//
//  Created by German Hernandez on 29/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RTEmptyStateView: UIView {

    let messageLabel = RTTitleLabel(textAlignment: .left, fontSize: 24)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        addSubviews(messageLabel)
        configureMessageLabel()
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines  = 3
        
        if #available(iOS 13.0, *) {
            messageLabel.textColor = .secondaryLabel
        } else {
            messageLabel.textColor = .black
        }
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
