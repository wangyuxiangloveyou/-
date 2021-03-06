//
//  UIView+Util.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.width=height;
    self.frame=frame;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setOrigion:(CGPoint)origion{
    CGRect frame=self.frame;
    frame.origin=origion;
    self.frame=frame;
}

-(CGPoint)origion{
    return self.frame.origin;
}

-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}

-(CGSize)size{
    return self.frame.size;
}





@end
