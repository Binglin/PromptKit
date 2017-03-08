//
//  UIView+PromptKit.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD

extension UIView: ErrorToastProtocol { }

extension UIScrollView: EmptyViewProtocol { }

extension UIView: LoadingViewProtocol { }

extension UIView: ErrorViewProtocol { }

extension UIView: MBLoadingProtocol { }

// MARK: - UIScrollView
extension EmptyViewProtocol where Self: UIScrollView {
    
    func showEmpty(data: PromptViewUIData) {
        
        self.hideEmpty()
        
        let view = PromptView(frame: CGRect(origin: .zero, size: self.bounds.size))
        view.updateViewWith(data: data)
        view.tag = PromptViewStyle.empty.rawValue
        self.addSubview(view)
    }
    
    func hideEmpty() {
        let emptyView = self.viewWithTag(PromptViewStyle.empty.rawValue) as? PromptView
        emptyView?.removeFromSuperview()
    }
}



// MARK: - UIView
extension LoadingViewProtocol where Self: UIView {
    
    func showLoading() {
        
        let loading = self.viewWithTag(PromptViewStyle.loading.rawValue) as? BeansLoadingView
        
        guard let beans = loading else{
            
            let loading = BeansLoadingView(frame: CGRect(origin: .zero, size: self.bounds.size))
            loading.tag = PromptViewStyle.loading.rawValue
            loading.startAnimating()
            self.addSubview(loading)
            
            return
        }
        self.addSubview(beans)
    }
    
    func hideLoading() {
        let loading = self.viewWithTag(PromptViewStyle.loading.rawValue) as? BeansLoadingView
        loading?.removeFromSuperview()
    }
}


// MARK: - MBProgressHUD
extension MBLoadingProtocol where Self: UIView {
    
    func showMBLoading(text: String?) {
        var hud = MBProgressHUD(for: self)
        if let hud = hud {
            self.addSubview(hud)
        }else {
            
            //if self.next is UIViewController { }
            hud = MBProgressHUD.showAdded(to: self, animated: true)
        }
        hud?.mode = .indeterminate
        hud?.label.text = text
        hud?.removeFromSuperViewOnHide = true
        hud?.show(animated: true)
    }
    
    func hideMBLoading(){
        let hud = MBProgressHUD(for: self)
        hud?.hide(animated: true)
    }
}



// MARK: - UIView
extension ErrorViewProtocol where Self: UIView {
    
    func showError(data: PromptViewUIData) {
        
        self.hideError()
        
        let view = PromptView(frame: CGRect(origin: .zero, size: self.bounds.size))
        view.updateViewWith(data: data)
        view.tag = PromptViewStyle.error.rawValue
        self.addSubview(view)
    }
    
    func hideError() {
        let errorView = self.viewWithTag(PromptViewStyle.error.rawValue) as? PromptView
        errorView?.removeFromSuperview()
    }
}



// MARK: - UIView
extension ErrorToastProtocol where Self: UIView {
    
    func showToast(text: String) {
        
        var hud = MBProgressHUD(for: self)
        
        if let hud = hud {
            self.addSubview(hud)
        }else{
            hud = MBProgressHUD.showAdded(to: self, animated: true)
        }
        
        hud?.detailsLabel.text = text
        hud?.mode = .text
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(10)) {
            hud?.show(animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(1), execute: {
            hud?.hide(animated: true)
        })
        
    }
    
    func showToast(data: PromptViewUIData) {
        self.showToast(text: data.title!)
    }
    
    func hideToast() {
        MBProgressHUD(for: self)?.hide(animated: true)
    }
}


