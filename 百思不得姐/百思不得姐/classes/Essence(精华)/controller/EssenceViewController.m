//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "EssenceViewController.h"


@interface EssenceViewController ()

@end

@implementation EssenceViewController

- (void)viewDidLoad {
      [super viewDidLoad];

    self.rightImageName = @"navigationButtonRandom_26x26_";
    self.rightHLImageName = @"navigationButtonRandomClickN_26x26_";

  }

-(void)setSubMenus:(NSArray *)subMenus{
    [super setSubMenus:subMenus];
//    显示导航
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
