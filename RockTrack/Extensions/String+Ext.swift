//
//  String+Ext.swift
//  RockTrack
//
//  Created by German Hernandez on 29/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

extension String {
    
    func convertStringToDate() -> Date {
        let dateFormatter           = DateFormatter()
        dateFormatter.locale        = Locale(identifier: "en_GB")
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.date(from: self)!
    }
}
