//
//  UIViewController+PrompKit.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKPrompKitProtocol.h"

@interface UIViewController (PKPrompKit)<PKPrompKitProtocol,PKLoadingViewProtocol,PKEmptyViewProtocol,PKErrorViewProtocol, PKErrorToastProtocol>



@end
