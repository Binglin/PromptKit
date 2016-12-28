//
//  UIViewController+PromptKit.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

import UIKit


extension UIViewController: LoadingViewProtocol{
    
    func showLoading() {
        self.view.showLoading()
    }
    
    func hideLoading() {
        self.view.hideLoading()
    }
}

extension UIViewController: ErrorViewProtocol{
    
    func showError(data: PromptViewUIData) {
        self.view.showError(data)
    }
    
    func hideError() {
        self.view.hideError()
    }
}


extension UIViewController: ErrorToastProtocol{
    
    func showToast(text: String) {
        self.view.showToast(text)
    }
    
    func showToast(data: PromptViewUIData) {
        self.view.showToast(data)
    }
    
    func hideToast() {
        self.view.hideToast()
    }
}

