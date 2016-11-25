//
//  UILabel+Util.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 wyx. All rights reserved.
//

#import "UILabel+Util.h"

@implementation UILabel (Util)

+(UILabel *)creatLabel:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font{
    UILabel *label=[[UILabel alloc]init];
    if(title){
        label.text=title;
    }
    if(color){
        label.textColor=color;
    }
    if(font){
        label.font=font;
    }
    return  label;
}

@end
