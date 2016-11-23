//
//  BDJTabBarController.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//


#import "BDJTabBarController.h"
#import "BDJTabBar.h"
#import "BDJMenu.h"
#import "EssenceViewController.h"

@interface BDJTabBarController ()

@end

@implementation BDJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UITabBar appearance].tintColor=[UIColor colorWithWhite:64.0f/255.9f alpha:1.0f];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setValue:[[BDJTabBar alloc]init] forKey:@"tabBar"];
//    创建视图控制器
       [self creatViewController];
//    获取菜单数据
    [self loadMenuData];

//    [self downloadMenuData];
}
//获取菜单数据
-(void)loadMenuData{
    NSString *filePath=[self menuFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
//        读文件
        NSData *data=[NSData dataWithContentsOfFile:filePath];
        BDJMenu *menu=[[BDJMenu alloc]initWithData:data error:nil];
        [self showAllMenuData:menu];
    }
    //更新菜单数据
    [self downloadMenuData];
}
// 下周菜单数据
-(void)downloadMenuData{
//    http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/
    NSString *urlstring=@"http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/";
    [BDJDownload downloadWithURLString:urlstring succes:^(NSData *data) {
//解析
        BDJMenu *menu=[[BDJMenu alloc]initWithData:data error:nil];
        
        NSString *path=[self menuFilePath];
//        如果plist文件不存在,显示菜单数据
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
               [self showAllMenuData:menu];
        }
     
        //存在本地
        [data writeToFile:path atomically:YES];
        
    } fail:^(NSError *error) {
        
    }];
    
}

//百度存储菜单数据的文件名
-(NSString *)menuFilePath{
   NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [docPath stringByAppendingPathComponent:@"menu.plist"];
    
    
}
//显示菜单数据
-(void)showAllMenuData:(BDJMenu *)menu{
    
//    设置精华菜单数据
    UINavigationController *essenceNavCtrl=[self.viewControllers firstObject];
    EssenceViewController *essenceCtrl=[essenceNavCtrl.viewControllers firstObject];
    essenceCtrl.subMenus=[[menu.menus firstObject]submenus];
    
  
    
}
//创建视图控制器
-(void)creatViewController{
    //1精华
    [self addSubController:@"EssenceViewController" imageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon" title:@"精华"];
    
    // 2,最新
    [self addSubController:@"NewsViewController" imageName:@"tabBar_new_icon" selectImageName:@"tabBar_me_click_icon" title:@"最新"];
    //3,添加
//    [self addSubController:@"AddViewController" imageName:@"tabBar_publish_icon" selectImageName:@"tabBar_publish_click_icon" title:@"添加"];
    //4,关注
    [self addSubController:@"AttentionViewController" imageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    //5,我的
    [self addSubController:@"ProfileViewController" imageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon" title:@"我的"];
}

//添加单个视图控制器
-(void)addSubController:(NSString *)ctrlName imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName title:(NSString *)title{
    //1,创建视图控制器对象
    Class cls=NSClassFromString(ctrlName);
    UIViewController *tmpCtrl=[[cls alloc]init];
    
    //2.设置文字
    tmpCtrl.tabBarItem.title=title;
    
    //3,图片
    tmpCtrl.tabBarItem.image=[UIImage imageNamed:imageName];
    tmpCtrl.tabBarItem.selectedImage=[UIImage imageNamed:selectImageName];
    
    //4导航
    UINavigationController *navCtrl=[[UINavigationController alloc]initWithRootViewController:tmpCtrl];
    
    
    //5. 让tabCtrl管理这个视图控制器
    [self addChildViewController:navCtrl];
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
