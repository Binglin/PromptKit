//
//  SignalProducer+PromptKit.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

import ReactiveCocoa

extension SignalProducer{
    
    func observeLoading(v: LoadingViewProtocol, data: PromptViewUIData) ->  ReactiveCocoa.SignalProducer<Value, Error>{
        
        return self.on(started: { 
                v.showLoading()
            }, failed: { (_) in
                v.hideLoading()
            }, completed: { 
                v.hideLoading()
            }, interrupted: { 
                v.hideLoading()
            }, terminated: { 
                v.hideLoading()
            })
    }
    
    func observeErrorToast(v: ErrorToastProtocol) ->  ReactiveCocoa.SignalProducer<Value, Error> {
        
        return self.on(started: { 
                v.hideToast()
            }, failed: { (e) in
                v.showToast(PromptViewUIData(title: "",
                    detailTitle: nil,
                    iconName: nil,
                    buttonTitle: nil,
                    buttonAction: nil))
            })
    }
    
    func observeError(v: ErrorViewProtocol, reloadAction: dispatch_block_t? = nil) -> ReactiveCocoa.SignalProducer<Value, Error> {
        return self.on(started: { 
                v.hideError()
            }, failed: { (e) in
                let data = PromptViewUIData(title: "", detailTitle: nil, iconName: nil, buttonTitle: nil, buttonAction: reloadAction)
                v.showError(data)
            })
    }
    
    func observeEmpty(v: UIScrollView, emptyData: PromptViewUIData) ->  ReactiveCocoa.SignalProducer<Value, Error> {
        
        return self.on(started: { 
                v.hideEmpty()
            }, completed: {
                
                var morethan1 = false
                
                if let table = v as? UITableView{
                    
                    if table.numberOfSections > 0 {
                    
                        for i in 0..<table.numberOfSections{
                            if table.numberOfRowsInSection(i) > 0{
                                morethan1 = true
                                break
                            }
                        }
                    }
                    
                }else if let v = v as? UICollectionView{
                    
                    if v.numberOfSections() > 0{
                        
                        for i in 0..<v.numberOfSections(){
                            if v.numberOfItemsInSection(i) > 0{
                                morethan1 = true
                                break
                            }
                        }
                    }
                }
                
                if morethan1 == false{
                    v.showEmpty(emptyData)
                }
            })
    }
}

