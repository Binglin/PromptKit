//
//  PromptView.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

import UIKit

class PromptView: UIView {

    var imageView: UIImageView?

    var titleLabel: UILabel?
    
    var detailLabel: UILabel?
    
    var actionButton: UIButton?
    
    fileprivate let centerContainer = UIView()
    
    fileprivate var viewData: PromptViewUIData!
    
    //UI_APPEARANCE
    dynamic var imageTitlePadding: CGFloat = 12
    dynamic var titleDetailPadding: CGFloat = 6
    dynamic var detailButtonPadding: CGFloat = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(centerContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var containerHeight: CGFloat = 0.0
        let minEdge: CGFloat = 15
        
        let maxWidth = self.frame.width - 2 * minEdge
        
        // img
        if let img = imageView {
            img.sizeToFit()
            img.center = CGPoint(x: self.frame.width / 2.0, y: img.frame.height/2.0)
            containerHeight = img.frame.height
        }
        
        // title
        if let title = titleLabel {
            if let _ = imageView {
                containerHeight += imageTitlePadding
            }
            let size = title.sizeThatFits(CGSize(width: maxWidth, height:  100.0))
            title.frame = CGRect(origin: CGPoint(x: minEdge, y: containerHeight),
                                 size: CGSize(width: maxWidth, height: size.height))
            containerHeight += size.height
        }
        
        // detail
        if let detail = detailLabel {
            containerHeight += titleDetailPadding
            let size = detail.sizeThatFits(CGSize(width: maxWidth, height:  100.0))
            detail.frame = CGRect(origin: CGPoint(x: minEdge, y: containerHeight),
                                  size: CGSize(width: maxWidth, height: size.height))
            containerHeight += size.height
        }
        
        // btn
        if let actionBtn = actionButton {
            containerHeight += detailButtonPadding
            let size = CGSize(width: self.frame.size.width - 35 * 2, height: 44)
            actionBtn.frame = CGRect(origin: CGPoint(x: 35, y: containerHeight), size: size)
            actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            containerHeight += size.height
        }
        
        // center container
        centerContainer.frame = CGRect(origin: CGPoint(x: 0, y: (self.frame.height - containerHeight)/2.0),
                                       size: CGSize(width: self.frame.width, height: containerHeight))
    }
}

extension PromptView {
   
    func updateViewWith(data: PromptViewUIData) {
        
        viewData = data
        
        // icon
        if let icon = data.iconName {
            
            let imageView = UIImageView(image: UIImage.init(named: icon))
            self.centerContainer.addSubview(imageView)
            
            self.imageView = imageView
        }
        
        // title
        if let title = data.title {
            
            let label = createTitle()
            label.text = title
            centerContainer.addSubview(label)
            
            titleLabel = label
        }else{
            titleLabel?.removeFromSuperview()
        }
        
        // detail
        if let detail = data.detailTitle {
            
            let label = createDetail()
            label.text = detail
            centerContainer.addSubview(label)
            
            detailLabel = label
        }else{
            detailLabel?.removeFromSuperview()
        }
        
        // button
        if let btnTitle = data.buttonTitle {
            let btn = createButton()
            btn.setTitle(btnTitle, for: .normal)
            
            btn.addTarget(self, action: #selector(PromptView.errorTaped(_:)), for: .touchUpInside)
            centerContainer.addSubview(btn)
            actionButton = btn
        }else{
            if let _ = data.buttonAction {
                addTapToReload()
            }
            actionButton?.removeFromSuperview()
        }

    }
    
    func addTapToReload() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PromptView.errorTaped(_:))))
    }
    
    @objc fileprivate func errorTaped(_ gesture: UITapGestureRecognizer?) {
        viewData.buttonAction?()
    }
    
}

extension PromptView {
    
    dynamic func setTitleTextAttribute(_ attri: [String : Any]) {
        
        let font = attri[NSFontAttributeName] as? UIFont
        let color = attri[NSFontAttributeName] as? UIColor
        
        if let f = font {
            titleLabel?.font = f
        }
        
        if let c = color {
            titleLabel?.textColor = c
        }
    }
    
    dynamic func setDetailTextAttribute(_ attri: [String : Any]) {
       
        let font = attri[NSFontAttributeName] as? UIFont
        let color = attri[NSFontAttributeName] as? UIColor
        
        if let f = font {
            detailLabel?.font = f
        }
        
        if let c = color {
            detailLabel?.textColor = c
        }
    }
}


extension PromptView {
    
    fileprivate func createTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor(colorLiteralRed: (0x80) / 255.0,
                                  green: (0x7d)/255.0,
                                  blue: (0x6c)/255.0,
                                  alpha: 1.0)
        return label
    }
    
    fileprivate func createDetail() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.lightGray
        return label
    }
    
    fileprivate func createButton() -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: .highlighted)
        return btn
    }
}
