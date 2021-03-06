//
//  PKListCounter.swift
//  TicketSystem
//
//  Created by ET|冰琳 on 2017/1/20.
//  Copyright © 2017年 UK. All rights reserved.
//

import UIKit

protocol PKListCounter {
    
    func hasRows() -> Bool
}

extension UITableView {
    
    override func hasRows() -> Bool {
        for i in 0..<self.numberOfSections {
            if self.numberOfRows(inSection: i) > 0 {
                return true
            }
        }
        return false
    }
}

extension UICollectionView {
    
    override func hasRows() -> Bool {
        for i in 0..<self.numberOfSections {
            if self.numberOfItems(inSection: i) > 0 {
                return true
            }
        }
        return false
    }
}

extension UIView: PKListCounter {
    func hasRows() -> Bool {
        
        for v in self.subviews {
            if v.hasRows() { return true }
        }
        return false
    }
}
