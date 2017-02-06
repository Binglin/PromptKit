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

extension UIScrollView: UIRefreshProtocol {}

public struct ListAction : OptionSet {
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static var refreshing = ListAction(rawValue: 1 << 1)
    public static var loadMore   = ListAction(rawValue: 1 << 2)
}


protocol UIPullPushDataProtocol {
    func load(more: Bool)
}


protocol UIRefreshProtocol {
    func add(_ p: ListAction, del: UIPullPushDataProtocol)
    func beginRefreshing()
    func endRefreshing(more: Bool)
    func updateFooterWith(moreData: Bool)
}


extension Signal {
    
    func manageRefreshing(_ p: UIRefreshProtocol, more: Bool = false) {
        
        self.signal.observeResult { _ in
            p.endRefreshing(more: more)
        }
    }
}

extension UIRefreshProtocol where Self: UIScrollView {
    
    func add(_ p: ListAction = .refreshing, del: UIPullPushDataProtocol){
        
        if p.contains(.refreshing) {
            self.addRefreshHeader(del: del)
        }
        if p.contains(.loadMore) {
            self.addLoadMore(del: del)
        }
    }
    
    func addRefreshHeader(del: UIPullPushDataProtocol) {
        
        let header = MJRefreshNormalHeader { _ in
            del.load(more: false)
        }
        header?.lastUpdatedTimeLabel.textColor = UIColor.gray
        header?.stateLabel.textColor = UIColor.gray
        
        self.mj_header = header
        header?.beginRefreshing()
    }
    
    private func addLoadMore(del: UIPullPushDataProtocol) {
        let footer = MJRefreshBackNormalFooter { 
            del.load(more: true)
        }
        footer?.setTitle("没有更多了", for: .noMoreData)
        footer?.stateLabel.textColor = UIColor.gray
        self.mj_footer = footer
        self.mj_footer.isHidden = true
    }
    
    func beginRefreshing() {
        self.mj_header.beginRefreshing()
    }
    
    func endRefreshing(more: Bool) {
        if more {
            self.mj_footer.endRefreshing()
        }else{
            self.mj_header.endRefreshing()
        }
    }
    
    func updateFooterWith(moreData: Bool) {
        if moreData {
            self.mj_footer.resetNoMoreData()
        }else{
            self.mj_footer.endRefreshingWithNoMoreData()
        }
    }
}
