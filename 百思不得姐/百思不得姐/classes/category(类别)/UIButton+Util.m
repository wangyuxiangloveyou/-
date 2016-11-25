//
//  UIButton+Util.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "UIButton+Util.h"

@implementation UIButton (Util)

+(UIButton *)createBtnTitle:(NSString *)title bgimageNmae:(NSString *)bgImageName highLightBgImageNmae:(NSString *)highLightBgImageNmae target:(id)target action:(SEL)action{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (title != nil){
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if(bgImageName){
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:highLightBgImageNmae] forState:UIControlStateNormal];
    }
    if(target && action){
        [btn addTarget:target action:action forControlEvents:UIControlStateNormal];
    }
    return  btn;
}
@end
