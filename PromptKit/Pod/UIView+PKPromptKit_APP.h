//
//  UIView+PromptKit_APP.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKPrompKitProtocol.h"

@interface UIView (PKPromptKit)<PKPrompKitProtocol>



@end



@interface UIView (PKLoading)<PKLoadingViewProtocol>

@end




@interface UIView (PKEmpty)<PKEmptyViewProtocol>

@end



@interface UIView (PKError)<PKErrorViewProtocol, PKErrorToastProtocol>

@end



