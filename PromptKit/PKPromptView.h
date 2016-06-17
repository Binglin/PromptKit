//
//  PromptView.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKPromptUIDataSource.h"


/**
 app 空提示界面
 app 网络请求失败页面
 */

@interface PKPromptView : UIView

- (instancetype)initWithFrame:(CGRect)frame entity:(PKPromptUIDataSource *)entity;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *actionBtn;

@end

