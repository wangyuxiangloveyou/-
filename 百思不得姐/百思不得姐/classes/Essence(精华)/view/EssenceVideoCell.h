//
//  EssenceVideoCell.h
//  百思不得姐
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  BDJEssenceDetail;
@interface EssenceVideoCell : UITableViewCell

//数据
@property (nonatomic,strong)BDJEssenceDetail *detailModel;

//便利创建cell的方法
+(EssenceVideoCell *)videoCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath withModel:(BDJEssenceDetail *)detailModel;
@end
