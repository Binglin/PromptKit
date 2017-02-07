//
//  PromptViewUIData.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

import UIKit
import ReactiveCocoa


enum PromptViewStyle: Int {
    case error = 333
    case empty
    case loading
}

struct PromptViewUIData {
    
    var title: String?
    var detailTitle: String?
    
    var iconName: String?
    
    var buttonTitle: String?
    var buttonAction: (() -> Void)?
    
    init(title: String? = nil, detailTitle: String? = nil, iconName: String? = nil,
         buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        self.title          = title
        self.detailTitle    = detailTitle
        self.iconName       = iconName
        self.buttonTitle    = buttonTitle
        self.buttonAction   = buttonAction
    }
}


extension PromptViewUIData {
    
    struct Default { }
}

extension PromptViewUIData.Default {
    
    static var empty: PromptViewUIData = {
        var d = PromptViewUIData()
        d.title = "空空如也"
        d.iconName = "pk_global_empty_icon"
        return d
    }()
    
    static var error: PromptViewUIData = {
        var d = PromptViewUIData()
        d.title = "请求失败"
        d.iconName = "pk_global_error_icon"
        return d
    }()
    
}
