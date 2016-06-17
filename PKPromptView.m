//
//  PromptView.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "PKPromptView.h"

@interface PKPromptView ()

@property (nonatomic, strong) UIView *centerContainerView;
@property (nonatomic, strong) PKPromptUIDataSource *viewData;

@end

@implementation PKPromptView

- (instancetype)initWithFrame:(CGRect)frame entity:(PKPromptUIDataSource *)e{
    if ([self initWithFrame:frame]) {
        
        [self addSubview:self.centerContainerView];
        
        _viewData = e;
        
        if (e.title){
            self.titleLabel.text = e.title;
            [self.centerContainerView addSubview:self.titleLabel];
        }
        if (e.iconName) {
            self.imageView.image = [UIImage imageNamed:e.iconName];
            [self.centerContainerView addSubview:self.imageView];
        }
        if (e.detailTitle) {
            self.detailLabel.text = e.detailTitle;
            [self.centerContainerView addSubview:self.detailLabel];
        }
        if (e.btnTitle) {
            [self.actionBtn setTitle:e.btnTitle forState:UIControlStateNormal];
            [self.centerContainerView addSubview:self.actionBtn];
        }
        
        if (e.style == PKPromptUIStyleError) {
            [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(errorTaped:)]];
            
        }
        self.backgroundColor = [UIColor colorWithRed:(0xee)/255.0 green:(0xee)/255.0 blue:(0xee)/255.0 alpha:1.0];
        
    }
    return self;
}

- (void)errorTaped:(UITapGestureRecognizer *)tap{
    if (self.viewData.reloadExecution) {
        self.viewData.reloadExecution();
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat containerWidth = 0;
    CGFloat containerHeight = 0;
    
    if (_imageView) {
        [_imageView sizeToFit];
        containerWidth = _imageView.frame.size.width;
        containerHeight = _imageView.frame.size.height + 10.0;
    }
    
    if (_titleLabel) {
        CGSize size = [_titleLabel sizeThatFits:CGSizeMake(self.frame.size.width - 30.0, 100.0)];
        
        self.titleLabel.frame = ({ CGRect frame = self.titleLabel.frame;
            frame.origin.y = containerHeight;
            frame.size = size ;
            frame;});
        
        if (size.width > containerWidth) {
            containerWidth = size.width;
        }
        containerHeight += size.height + 10.0f;
    }
    
    if (_detailLabel) {
        CGSize size = [_detailLabel sizeThatFits:CGSizeMake(self.frame.size.width - 30.0, 100.0)];
        
        self.detailLabel.frame = ({ CGRect frame = self.detailLabel.frame;
            frame.origin.y = containerHeight;
            frame.size = size ;
            frame;});
        
        if (size.width > containerWidth) {
            containerWidth = size.width;
        }
        containerHeight += size.height + 10.0f;
    }
    
    if (_actionBtn) {
        CGSize size = [_actionBtn sizeThatFits:CGSizeMake(self.frame.size.width - 30.0f, 100.0)];
        
        self.actionBtn.frame = ({ CGRect frame = self.actionBtn.frame;
            frame.origin.y = containerHeight;
            frame.size = size ;
            frame;});

        if (size.width > containerWidth) {
            containerWidth = size.width;
        }
        containerHeight += size.height;
    }
    
    self.centerContainerView.frame = CGRectMake((CGRectGetWidth(self.frame) - containerWidth)/2.0,
                                                (CGRectGetHeight(self.frame)- containerHeight)/2.0,
                                                containerWidth,
                                                containerHeight);
    if (_imageView) {
        _imageView.center = CGPointMake(containerWidth/2.0, _imageView.center.y);
    }
    
    if (_titleLabel) {
        _titleLabel.center = CGPointMake(containerWidth/2.0, _titleLabel.center.y);
    }
    
    if (_detailLabel) {
        _detailLabel.center = CGPointMake(containerWidth/2.0, _detailLabel.center.y);
    }
    
    if (_actionBtn) {
        _actionBtn.center = CGPointMake(containerWidth/2.0, _actionBtn.center.y);
    }
}


- (UIView *)centerContainerView{
    if (!_centerContainerView) {
        _centerContainerView = [UIView new];
    }
    return _centerContainerView;
}

- (UIImageView *)imageView{
    if (!_imageView){
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        //0x807d6c
        _titleLabel.textColor = [UIColor colorWithRed:(0x80) / 255.0 green:(0x7d)/255.0 blue:(0x6c)/255.0 alpha:1.0];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_actionBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    }
    return _actionBtn;
}

@end


