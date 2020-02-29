//
//  Date+Ext.swift
//  RockTrack
//
//  Created by German Hernandez on 29/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

extension Date {
    
    func convertDateToString() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "dd MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
