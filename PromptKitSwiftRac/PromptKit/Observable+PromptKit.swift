//
//  Observable+PromptKit.swift
//  PromptKit
//
//  Created by 郑林琴 on 16/8/13.
//  Copyright © 2016年 IB. All rights reserved.
//

import RxSwift

extension Observable{
    
    func observeLoading(v: LoadingViewProtocol, data: PromptViewUIData) ->  Observable<Element>{
        
        v.showLoading()
        return self.doOn(onError: { (_) in
                v.hideLoading()
            }, onCompleted: { 
                v.hideLoading()
        })
    }
    
    func observeErrorToast(v: ErrorToastProtocol) -> Observable<Element>{
        
        v.hideToast()
        return self.doOn(onError: { (e) in
            v.showToast(PromptViewUIData(title: "",
                detailTitle: nil,
                iconName: nil,
                buttonTitle: nil,
                buttonAction: nil))
        })
    }
    
    func observeError(v: ErrorViewProtocol, reloadAction: dispatch_block_t? = nil) -> Observable<Element> {
        
        v.hideError()
        return self.doOn(onError: { (e) in
            let data = PromptViewUIData(title: "", detailTitle: nil, iconName: nil, buttonTitle: nil, buttonAction: reloadAction)
            v.showError(data)
        })
    }
    
    func observeEmpty(v: UIScrollView, emptyData: PromptViewUIData) ->  Observable<Element> {
     
        v.hideEmpty()
        return self.doOn(onCompleted: {
            
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

