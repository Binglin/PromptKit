//
//  PromptView.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

import UIKit

class PromptView: UIView {

    var titleLabel: UILabel?
    
    var detailLabel: UILabel?
    
    var actionButton: UIButton?
    
    var imageView: UIImageView?
    
    private var viewData: PromptViewUIData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateViewWith(data: PromptViewUIData) {
        
    }
    
    func addTapToReload() {
        
    }
}
