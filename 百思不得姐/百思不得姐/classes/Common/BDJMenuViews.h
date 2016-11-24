//
//  BDJMenuViews.h
//  百思不得姐
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 wyx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,MenuType) {
    MenuTypeEssence=1<<0,//精华
    MenTypeNews=1<<1//最新
};

@class BDJMenuViews;
@protocol BDJMenuViewDelegate <NSObject>

-(void)menuView:(BDJMenuViews *)menuView didClickBtnAtIndex:(NSInteger)index;


//点击右边
-(void)menuView:(BDJMenuViews *)menuView didClickRihgtBtn:(MenuType)type;
@end




@interface BDJMenuViews : UIView
//
//初始化方法
/*
@param array:菜单数据
 */
-(instancetype)initWithItens:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName;
//枚举类型
@property(nonatomic,assign)MenuType type;

//代理属性
@property(nonatomic,weak)id<BDJMenuViewDelegate>delegate ;
//当前选中按钮
@property(nonatomic,assign)NSInteger selectIndex;
@end


@class  BDJSubMenu;
//菜单按钮
@interface BDJMenuButton : UIControl


-(instancetype)initWithTitle:(NSString *)title;

//是否选中
@property(nonatomic,assign)BOOL clicked;

//数据的属性
@property(nonatomic,strong)BDJSubMenu *subMenu;
//按钮序号
@property(nonatomic,assign)NSInteger btnIndex;
@end