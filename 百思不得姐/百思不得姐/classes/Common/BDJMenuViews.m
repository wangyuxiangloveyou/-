//
//  BDJMenuViews.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 wyx. All rights reserved.
//

#import "BDJMenuViews.h"
#import "BDJMenu.h"

#define KContainerVieTag (100)
@interface BDJMenuViews()
@property(nonatomic,strong)UIScrollView *scorllView;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation BDJMenuViews

-(instancetype)initWithItens:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName{
    if (self=[super init]){
        //        左边的滚动视图
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator=NO;
        [self addSubview:scrollView];
        self.scorllView=scrollView;
        //        约束
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).width.insets(UIEdgeInsetsMake(0, 0, 0, 60));
        }];
        //        1.1循坏创建按钮
        //        1.1.1 容器视图
        UIView *containerView=[[UIView alloc]init];
        containerView.tag=KContainerVieTag;
        [scrollView addSubview:containerView];
        
        //        约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        //        循坏创建按钮
        CGFloat btnW = 60;
        //        上一次添加的子视图
        UIView *lastView=nil;
        //        遍历的序号
        NSInteger i=0;
        for (BDJSubMenu *subMenu in array){
            BDJMenuButton *btn=[[BDJMenuButton alloc]initWithTitle:subMenu.name];
            btn.btnIndex=i;
            //            默认选中第一个
            if (i==0){
                btn.clicked=YES;
            }
            [containerView addSubview:btn];
            [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
            
            //            约束
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                //                数值相等
                make.width.mas_equalTo(btnW);
                if(lastView==nil){
                    make.left.equalTo(containerView);
                }else{
                    make.left.equalTo(lastView.mas_right);
                }
            }];
            lastView=btn;
            i++;
        }
        
        //1.1.3更新容器约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView);
        }];
        
        //2,右边的按钮
        UIButton *rightBtn=[UIButton createBtnTitle:nil bgimageNmae:iconName highLightBgImageNmae:selectIconName target:self action:@selector(clickRightBtn)];
        [self addSubview:rightBtn];
        
        // 约束
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(4);
            make.right.equalTo(self).offset(-10);
            make.width.mas_equalTo(36);
            make.height.mas_equalTo(36);
        }];
        
        //3.下滑线
        self.lineView=[[UIView alloc]init];
        [self.scorllView addSubview:self.lineView];
        self.lineView.backgroundColor=[UIColor redColor];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scorllView);
            make.bottom.equalTo(self.scorllView).offset(-4);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(2);
        }];
    }
    return  self;
}

// 1切换按钮选中状态
-(void)setSelectIndex:(NSInteger)selectIndex{
    if(_selectIndex != selectIndex){
        BDJMenuButton *lastBtn=nil;
        BDJMenuButton *curBtn=nil;
        UIView *containerView=[self.scorllView viewWithTag:KContainerVieTag];
        for(BDJMenuButton *tmpBtn in containerView.subviews){
            if (tmpBtn.btnIndex==selectIndex){
                curBtn=tmpBtn;
            }else if (tmpBtn.btnIndex==_selectIndex){
                lastBtn=tmpBtn;
            }
        }
        
        //1,取消之前选中按钮
        lastBtn.clicked=NO;
        
        //2,选中当前按钮
        curBtn.clicked=YES;
        
        //3,修改下划线位置
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(curBtn);
            make.bottom.equalTo(self.scorllView).offset(-4);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(2);
        }];
        
        // 4,将当前选中按钮尽可能显示在中间位置
        CGFloat x=CGRectGetMidX(curBtn.frame)-self.scorllView.bounds.size.width/2;
        // 左边不能越界
        if (x<0){
            x=0;
        }
        //右边不能越界
        if (x>self.scorllView.contentSize.width-self.scorllView.bounds.size.width) {
            x=self.scorllView.contentSize.width-self.scorllView.bounds.size.width;
        }
        self.scorllView.contentOffset=CGPointMake(x, 0);
        _selectIndex=selectIndex;
    }
}

-(void)clickMenu:(BDJMenuButton *)btn{
    //    1切换按钮选中状态
    self.selectIndex=btn.btnIndex;
    
    //    2.切换对应界面
    [self.delegate menuView:self didClickBtnAtIndex:self.selectIndex];
}

//点击按钮
-(void)clickRightBtn{
    
}
@end

@implementation BDJMenuButton{
    //    文字
    UILabel *_titleLabel;
}

-(instancetype)initWithTitle:(NSString *)title{
    if (self=[super init]){
        //        创建文字视图
        _titleLabel=[UILabel creatLabel:title textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:20]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        //        约束
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.edges.equalTo(self);
        }];
    }
    return  self;
}

//切换选中状态
-(void)setClicked:(BOOL)clicked{
    _clicked=clicked;
    if (_clicked){
        _titleLabel.textColor=[UIColor redColor];
    }else{
        _titleLabel.textColor=[UIColor grayColor];
    }
}
@end
