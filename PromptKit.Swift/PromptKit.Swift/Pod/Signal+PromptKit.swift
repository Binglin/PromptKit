//
//  Signal+PromptKit.swift
//  TicketSystem
//
//  Created by ET|冰琳 on 2017/1/17.
//  Copyright © 2017年 UK. All rights reserved.
//

import Foundation
import ReactiveSwift


extension SignalProducer {
    
    func pipe() -> (Signal<Value, Error>, Disposable ){
        
        var signal: Signal<Value, Error>!
        var disposable: Disposable!
        
        self.startWithSignal { (s, dispose) in
            signal = s
            disposable = dispose
        }
        return (signal, disposable)
    }
}



// MARK: - loading
extension Signal {
    
    func manage(loading del: LoadingViewProtocol) {
        del.showLoading()
        self.observeResult { _ in
            del.hideLoading()
        }
    }
    
    func manage(mbLoading del: MBLoadingProtocol, text: String? = nil) {
  
        del.showMBLoading(text: text)
        self.observeResult { _ in
            del.hideMBLoading()
        }
    }
    
}



// MARK: - empty
extension Signal {

    func manage(empty del: EmptyViewProtocol, data: PromptViewUIData = PromptViewUIData.Default.empty) {
        del.hideEmpty()
        
        self.observeFailed { _ in
            del.hideEmpty()
        }
        self.observeCompleted {
            // todo 计算数量
            var morethan1 = false
            
            if let del = del as? PKListCounter{
                morethan1 = del.hasRows()
            }
            
            if morethan1 {
                del.hideEmpty()
            }else{
                del.showEmpty(data: data)
            }
        }
    }
    
}



// MARK: - error | toast
extension Signal {
    
    func manage(error del: ErrorViewProtocol, buttonTitle: String? = nil, reload: (() -> Void)?) {

        var defaultData = PromptViewUIData.Default.error
        defaultData.buttonTitle = buttonTitle
        defaultData.buttonAction = reload
        self.manage(error: del, data: defaultData)

    }
    
    func manage(error del: ErrorViewProtocol,  data: PromptViewUIData = PromptViewUIData.Default.empty) {
        
        del.hideError()
        
        self.observeFailed { err in
            
            var uiData = data
            
            uiData.title = err.localizedDescription
            
            var listHasData = false
            
            if let del = del as? PKListCounter {
                listHasData = del.hasRows()
            }
           
            guard listHasData else {
                del.showError(data: uiData)
                return
            }
            
            guard let delToast = del as? ErrorToastProtocol else {
                del.showError(data: uiData)
                return
            }
            
            delToast.showToast(data: uiData)
        }
    }
    
    func manage(toast del: ErrorToastProtocol) {
        del.hideToast()
        self.observeFailed { err in
            del.showToast(text: err.localizedDescription)
        }
    }

}


