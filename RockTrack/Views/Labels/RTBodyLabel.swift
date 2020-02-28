//
//  RTBodyLabel.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RTBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        textColor                           = .secondaryLabel
        font                                = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
        adjustsFontForContentSizeCategory   = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
