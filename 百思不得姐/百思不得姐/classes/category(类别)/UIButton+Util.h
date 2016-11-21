//
//  UIButton+Util.h
//  百思不得姐
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)
//创建按钮的便利方法
+(UIButton *)createBtnTitle:(NSString *)title bgimageNmae:(NSString *)bgImageName highLightBgImageNmae:(NSString *)highLightBgImageNmae target:(id)target action:(SEL)action;

@end
