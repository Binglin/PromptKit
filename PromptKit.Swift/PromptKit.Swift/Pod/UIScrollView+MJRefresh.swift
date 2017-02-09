//
//  UIScrollView+MJRefresh.swift
//  TicketSystem
//
//  Created by ET|冰琳 on 2017/1/20.
//  Copyright © 2017年 UK. All rights reserved.
//

import UIKit
import ReactiveSwift
import MJRefresh

public struct ListAction : OptionSet {
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static var refreshing = ListAction(rawValue: 1 << 1)
    public static var loadMore   = ListAction(rawValue: 1 << 2)
}


protocol UIPullPushDataProtocol {
    func loadData(action: ListAction)
}


extension Signal {
    
    func manageRefreshing(_ scrollView: UIScrollView, action: ListAction = .refreshing) {
        
        self.signal.observeResult { _ in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(10), execute: {
                scrollView.endRefreshing(action: action)
            })
        }
    }
    
    func manageRefreshing(_ scrollView: UIScrollView, action: ListAction = .refreshing, hasMore: @escaping () -> Bool) {
        
        self.observeResult { (r) in
            
            scrollView.endRefreshing(action: action)
            
            if case .success(_) = r {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(530), execute: {
                    scrollView.updateFooterWith(moreData: hasMore())
                })
                
            }
        }
    }
}

extension UIScrollView {
    
    func add(_ p: ListAction = .refreshing, del: UIPullPushDataProtocol){
        
        if p.contains(.refreshing) {
            self.addRefreshHeader(del: del)
        }
        if p.contains(.loadMore) {
            self.addLoadMore(del: del)
        }
    }
    
    private func addRefreshHeader(del: UIPullPushDataProtocol) {
        
        let header = MJRefreshNormalHeader { _ in
            del.loadData(action: .refreshing)
        }
        header?.lastUpdatedTimeLabel.textColor = UIColor.gray
        header?.stateLabel.textColor = UIColor.gray
        
        self.mj_header = header
        header?.beginRefreshing()
    }
    
    private func addLoadMore(del: UIPullPushDataProtocol) {
        let footer = MJRefreshBackNormalFooter { 
            del.loadData(action: .loadMore)
        }
        footer?.isAutomaticallyHidden = true
        footer?.setTitle("没有更多了", for: .noMoreData)
        footer?.stateLabel.textColor = UIColor.gray
        self.mj_footer = footer
    }
    
    func beginRefreshing() {
        self.mj_header.beginRefreshing()
    }
    
    func endRefreshing(action: ListAction) {
        
        if action == .refreshing {
            self.mj_header?.endRefreshing()
        }else{
            self.mj_footer?.endRefreshing()
        }
    }
    
    func updateFooterWith(moreData: Bool) {
        
        if moreData {
            self.mj_footer?.resetNoMoreData()
        }else{
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
}
