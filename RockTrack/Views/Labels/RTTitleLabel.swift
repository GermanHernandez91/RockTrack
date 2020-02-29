//
//  RTTitleLabel.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RTTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        if #available(iOS 13.0, *) {
            textColor = .label
        } else {
            textColor = .black
        }
        numberOfLines               = 0
        minimumScaleFactor          = 0.90
        lineBreakMode               = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
