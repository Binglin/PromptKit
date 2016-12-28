//
//  PromptKitProtocol.swift
//  PromptKit
//
//  Created by 郑林琴 on 16/8/7.
//  Copyright © 2016年 IB. All rights reserved.
//

import Foundation


protocol LoadingViewProtocol {
    func showLoading()
    func hideLoading()
}

protocol EmptyViewProtocol {
    func showEmpty(data: PromptViewUIData)
    func hideEmpty()
}


protocol ErrorViewProtocol {
    func showError(data: PromptViewUIData)
    func hideError()
}


protocol ErrorToastProtocol {
    func showToast(text: String)
    func showToast(data: PromptViewUIData)
    func hideToast()
}
