//
//  UIHelper.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

enum UIHelper {
    
    static func generateCollectionCellHorizontalCell(in view: UIView) -> UICollectionViewFlowLayout {
        let flowLayot = UICollectionViewFlowLayout()
        
        flowLayot.sectionInset = UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20)
        flowLayot.itemSize = CGSize(width: view.frame.width - 40, height: 100)
        flowLayot.minimumLineSpacing = 20
        
        return flowLayot
    }
}
