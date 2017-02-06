//
//  PromptView.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "PKPromptView.h"

@interface PKPromptView ()
{
    NSDictionary<NSString *,id> *titleTextAttribute;
    NSDictionary<NSString *,id> *detailTextAttribute;
}

@property (nonatomic, strong) UIView *centerContainerView;
@property (nonatomic, strong) PKPromptUIDataSource *viewData;

@end

@implementation PKPromptView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addSubview:self.centerContainerView];
    }
    return self;
}

- (void)updateViewWithEntity:(PKPromptUIDataSource *)e{
    
    _viewData = e;
    
    if (e.title){
        self.titleLabel.text = e.title;
        [self.centerContainerView addSubview:self.titleLabel];
    }else{
        [_titleLabel removeFromSuperview];
    }
    
    if (e.iconName) {
        self.imageView.image = [UIImage imageNamed:e.iconName];
        [self.centerContainerView addSubview:self.imageView];
    }else{
        [_imageView removeFromSuperview];
    }
    
    if (e.detailTitle) {
        self.detailLabel.text = e.detailTitle;
        [self.centerContainerView addSubview:self.detailLabel];
    }else{
        [_detailLabel removeFromSuperview];
    }
    
    if (e.btnTitle) {
        [self.actionBtn setTitle:e.btnTitle forState:UIControlStateNormal];
        [self.actionBtn addTarget:self action:@selector(errorTaped:) forControlEvents:UIControlEventTouchUpInside];
        [self.centerContainerView addSubview:self.actionBtn];
    }else{
        if (e.reloadExecution) {
            [self addTapToReload];
        }
        [_actionBtn removeFromSuperview];
    }
    
    [self setNeedsLayout];
}

- (void)setTitleTextAttribute:(NSDictionary<NSString *,id> *)attribute{
    titleTextAttribute = attribute;
   
    if (_titleLabel == nil) {
        return;
    }
    UIFont *font   = titleTextAttribute[NSFontAttributeName];
    UIColor *color = titleTextAttribute[NSForegroundColorAttributeName];
    
    if (font) {
        _titleLabel.font = font;
    }
    
    if (color) {
        _titleLabel.textColor = color;
    }
}

- (void)setDetailTextAttribute:(NSDictionary<NSString *,id> *)attribute{
   
    detailTextAttribute = attribute;
    
    if (_detailLabel == nil) {
        return;
    }
    UIFont *font   = detailTextAttribute[NSFontAttributeName];
    UIColor *color = detailTextAttribute[NSForegroundColorAttributeName];
    
    if (font) {
        _detailLabel.font = font;
    }
    
    if (color) {
        _detailLabel.textColor = color;
    }
}


- (void)addTapToReload{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(errorTaped:)]];
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
        containerHeight += 20.0;
        CGSize size = CGSizeMake(self.frame.size.width - 35 * 2, 44);
        self.actionBtn.frame = CGRectMake(35, containerHeight, size.width, size.height);
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
        _titleLabel.font =  [UIFont systemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor colorWithRed:(0x80) / 255.0 green:(0x7d)/255.0 blue:(0x6c)/255.0 alpha:1.0];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font =  [UIFont systemFontOfSize:14.0];
        _detailLabel.textColor = [UIColor lightGrayColor];
    }
    return _detailLabel;
}

- (UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _actionBtn;
}

+ (void)setupDefaultAppearance {
    
    PKPromptView *appearance = [PKPromptView appearance];
    [appearance setTitleTextAttribute:@{
                                        NSForegroundColorAttributeName: [UIColor colorWithRed:(0x80) / 255.0 green:(0x7d)/255.0 blue:(0x6c)/255.0 alpha:1.0],
                                        NSFontAttributeName: [UIFont systemFontOfSize:14.0]
                                        }];
    
    [appearance setDetailTextAttribute:@{
                                         NSForegroundColorAttributeName:  [UIColor lightGrayColor],
                                         NSFontAttributeName: [UIFont systemFontOfSize:14.0]
                                         }];
    
    UIButton *button = [UIButton appearanceWhenContainedIn:[PKPromptView class], nil];

    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
}
@end


