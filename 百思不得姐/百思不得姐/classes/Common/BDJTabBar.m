//
//  BDJTabBar.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "BDJTabBar.h"

@implementation BDJTabBar


-(instancetype)init{
    
    if (self == [super init]){
        UIButton *addBtn=[UIButton createBtnTitle:nil bgimageNmae:@"tabBar_publish_icon" highLightBgImageNmae:@"tabBar_publish_click_icon" target:self action:@selector(publishAction)];
//        addBtn.frame=CGRectMake(180, 0, 40, 50);
        
        [self addSubview:addBtn];
    }
    return self;
}

-(void)publishAction{
   
   
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 修改按钮位置,不能使用约束方式修改
    CGFloat btnW = KScreenWidth/5;
    NSInteger index = 0;
    for (UIView *tmpView in self.subviews) {
        if ([tmpView isKindOfClass:[UIButton class]]) {
            //发布按钮
            tmpView.size=CGSizeMake(40, 40);
            tmpView.center=CGPointMake(KScreenWidth/2, 49.0f/2);
        
        }else if ([tmpView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
          
            tmpView.width=btnW;
            if (index >= 2){
                //第三个需要添加按钮宽度值
                tmpView.x=(index+1)*btnW;
            }else{
                 tmpView.x=index*btnW;
            }
            index++;
            
        }
    }
   
}

@end
