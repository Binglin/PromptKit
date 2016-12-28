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
    
    private var viewData: PromptViewUIData
    
    init(frame: CGRect, data: PromptViewUIData) {
        self.viewData = data
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
