//
//  BDJMenuViewController.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 wyx. All rights reserved.
//

#import "BDJMenuViewController.h"
#import "BDJTableViewController.h"
#import "BDJMenu.h"
#import "BDJMenuViews.h"

@interface BDJMenuViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,BDJMenuViewDelegate>

//视图控制器数据
@property(nonatomic,strong)NSMutableArray *ctrlArray;
//分页视图控制器
@property(nonatomic,strong)UIPageViewController *pageCtrl;
//当前显示视图控制器的序号
@property (nonatomic,assign)NSInteger curPageIndex;
//菜单视图
@property (nonatomic,strong)BDJMenuViews *menuView;

@end

@implementation BDJMenuViewController

-(NSMutableArray *)ctrlArray{
    if (nil==_ctrlArray){
        _ctrlArray=[NSMutableArray array];
    }
    return  _ctrlArray;
}

-(void)setSubMenus:(NSArray *)subMenus{
    _subMenus=subMenus;
    for (BDJSubMenu *subMenu in subMenus){
        BDJTableViewController * ctrl =[[BDJTableViewController alloc]init];
        ctrl.url=subMenu.url;
        ctrl.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f  blue:arc4random_uniform(256)/255.0f  alpha:1.0f];
        [self.ctrlArray addObject:ctrl];
    }
    [self creatPageCtrl];
    [self createMenu];
    //创建导航
}

-(void)createMenu{
    BDJMenuViews *menuView=[[BDJMenuViews alloc]initWithItens:self.subMenus rightIcon:self.rightImageName rightSelectIcon:self.rightHLImageName ];
    self.menuView=menuView;
    
    //设置代理
    menuView.delegate=self;
    menuView.frame=CGRectMake(0, 0, KScreenWidth, 44);
    self.navigationItem.titleView=menuView;
}

//创建分页控制器
-(void)creatPageCtrl{
    UIPageViewController *pageCtrl=[[UIPageViewController alloc]initWithTransitionStyle:( UIPageViewControllerTransitionStyleScroll) navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageCtrl.delegate=self;
    pageCtrl.dataSource=self;
    [pageCtrl setViewControllers:@[[self.ctrlArray firstObject]] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
    [self.view addSubview:pageCtrl.view];
    self.pageCtrl=pageCtrl;
    //    约束
    [pageCtrl.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-uipageVieW
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //    1单前序号
    NSInteger curIndex=[self.ctrlArray indexOfObject:viewController];
    //    2,获取后面视图控制器
    if (curIndex + 1 >=self.ctrlArray.count){
        return  nil;
    }else{
        return  self.ctrlArray[curIndex+1];
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //    1单前序号
    NSInteger curIndex=[self.ctrlArray indexOfObject:viewController];
    //    2,获取前面视图控制器
    if (curIndex -1 <0){
        return  nil;
    }else{
        return  self.ctrlArray[curIndex-1];
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    //    获取将要滑到界面序号
    UIViewController *toCtrl=[pendingViewControllers lastObject];
    NSInteger index=[self.ctrlArray indexOfObject:toCtrl];
    self.curPageIndex=index;
}

//手动滑动pageCtrl.切换结束时调用
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    self.menuView.selectIndex=self.curPageIndex;
    //    1,上一次序号
    UIViewController *lastCtrl=[previousViewControllers lastObject];
}

#pragma mark-BDJMenuDegate
-(void)menuView:(BDJMenuViews *)menuView didClickBtnAtIndex:(NSInteger)index{
    //    获取视图控制器
    UIViewController * vc = self.ctrlArray[index];
    //        向右滑动
    UIPageViewControllerNavigationDirection dir=UIPageViewControllerNavigationDirectionForward;
    if (index < self.curPageIndex){
        //        向左滑动
        dir=UIPageViewControllerNavigationDirectionReverse;
    }
    self.curPageIndex=index;
    [self.pageCtrl setViewControllers:@[vc] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];
}

-(void)menuView:(BDJMenuViews *)menuView didClickRihgtBtn:(MenuType)type{
    NSLog(@"点击右边");
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
