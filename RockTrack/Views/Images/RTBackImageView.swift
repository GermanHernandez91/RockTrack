//
//  RTBackImageView.swift
//  RockTrack
//
//  Created by German Hernandez on 29/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RTBackImageView: UIImageView {
    
    let backImage = Images.backCircleArrow
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        image                       = backImage
        clipsToBounds               = true
        isUserInteractionEnabled    = true
        
        if #available(iOS 13.0, *) {
            tintColor = .label
        } else {
            tintColor = .black
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
