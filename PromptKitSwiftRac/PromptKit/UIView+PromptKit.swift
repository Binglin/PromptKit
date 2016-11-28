//
//  UIView+PromptKit.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

import UIKit


extension UIScrollView: EmptyViewProtocol{
    
    var pk_emptyView: PromptView?{
        get{
            return objc_getAssociatedObject(self, "#selector(UIView.emptyView)") as? PromptView
        }
        set{
            objc_setAssociatedObject(self, "#selector(UIView.emptyView)", newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func showEmpty(data: PromptViewUIData) {
        
        self.pk_emptyView?.removeFromSuperview()
        
        let view = PromptView(frame: self.bounds, data: data)
        self.addSubview(view)
        
        self.pk_emptyView = view
    }
    
    func hideEmpty() {
        self.pk_emptyView?.removeFromSuperview()
        self.pk_emptyView = nil
    }
}


extension UIView: LoadingViewProtocol{
    
    private var pk_LoadingView: BeansLoadingView?{
        get{
            return objc_getAssociatedObject(self, "#selector(UIView.LoadingView)") as? BeansLoadingView
        }
        set{
            objc_setAssociatedObject(self, "#selector(UIView.LoadingView)", newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func showLoading() {
        
        guard let loading = self.pk_LoadingView else{
            let loading = BeansLoadingView(frame: self.bounds)
            self.pk_LoadingView = loading
            return
        }
        self.addSubview(loading)
    }
    
    func hideLoading() {
        self.pk_LoadingView?.removeFromSuperview()
    }
}



extension UIView: ErrorViewProtocol{
    
    private var pk_errorView: PromptView?{
        get{
            return objc_getAssociatedObject(self, "#selector(UIView.errorView)") as? PromptView
        }
        set{
            objc_setAssociatedObject(self, "#selector(UIView.errorView)", newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func showError(data: PromptViewUIData) {
        let view = PromptView(frame: self.bounds, data: data)
        self.addSubview(view)
        self.pk_errorView = view
    }
    
    func hideError() {
        self.pk_errorView?.removeFromSuperview()
        self.pk_errorView = nil
    }
}

extension UIView: ErrorToastProtocol{
    
    func showToast(text: String) {
        
    }
    
    func showToast(data: PromptViewUIData) {
        
    }
    
    func hideToast() {
        
    }
}

