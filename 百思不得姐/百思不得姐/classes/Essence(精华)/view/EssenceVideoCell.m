//
//  EssenceVideoCell.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "EssenceVideoCell.h"
#import "BDJEssenceModel.h"

@interface EssenceVideoCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *clickMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playNumerLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentYCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeightCons;

@end



@implementation EssenceVideoCell

//播放
- (IBAction)playAction:(id)sender {
}
//更多
- (IBAction)moreBtn:(id)sender {
}
//顶一下
- (IBAction)dingaction:(id)sender {
}
//踩一下
- (IBAction)caiAction:(id)sender {
}
//评论
- (IBAction)commentAction:(id)sender {
}
//分享
- (IBAction)shareAction:(id)sender {
}

+(EssenceVideoCell *)videoCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath withModel:(BDJEssenceDetail *)detailModel{
    static NSString *cellId=@"VideoCellId";
    EssenceVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil==cell){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"EssenceVideoCell" owner:nil options:nil]lastObject];
        
    }
    //   数据
    cell.detailModel=detailModel;
    return cell;
    
}

-(void)setDetailModel:(BDJEssenceDetail *)detailModel{
    _detailModel=detailModel;
    //    1,用户图标
    NSString *headerString=[detailModel.u.header firstObject];
    NSURL *url=[NSURL URLWithString:headerString];
    [self.userImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    //    2,用户名
    self.userNameLabel.text=detailModel.u.name;
    //    3,时间
    self.passtimeLabel.text=detailModel.passtime;
    //    4,描述文字
    self.descLabel.text=detailModel.text;
    //    5图片
    NSString *videoString=[detailModel.video.thumbnail_small firstObject];
    NSURL *videoUrl=[NSURL URLWithString:videoString];
    [self.videoImageView sd_setImageWithURL:videoUrl placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    //    修改图片的高度==width/height
    CGFloat imageH=(KScreenWidth-20)*detailModel.video.height.floatValue/detailModel.video.width.floatValue;
    self.ImageHeightCons.constant=imageH;
    //    6,播放次数
    self.playNumerLabel.text=[detailModel.video.playcount stringValue];
    
    
    
    
    //    7,视频时间
    NSInteger min = 0;
    NSInteger sec=[detailModel.video.duration integerValue];
    if (sec >= 60){
        min=sec/60;
        sec=sec%60;
    }
    self.playTimeLabel.text=[NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    
    
    //    8,评论文字
    if(detailModel.top_comments.count>0){
        BDJEssenceComment *comment=[detailModel.top_comments firstObject];
        self.commentLabel.text=comment.content;
    }else{
        self.commentLabel.text=nil;
    }
    //    强制cell布局
    [self layoutIfNeeded];
    //    修改评论视图约束
    
    
    if(detailModel.top_comments.count>0){
        self.commentYCons.constant=10;
        self.commentHeightCons.constant=self.commentLabel.frame.size.height+10+10;
    }else{
        //没有评论部分
        self.commentHeightCons.constant=0;
        self.commentYCons.constant=0;
    }
    
    //    9,标签
    NSMutableString *tagString=[NSMutableString string];
    for (NSInteger i=0;i<detailModel.tags.count;i++){
        BDJEssenceTag *tag=detailModel.tags[i];
        [tagString appendFormat:@"%@",tag.name];
    }
    self.tagLabel.text=tagString;
    
    //    10,
    [self.dingBtn setTitle:detailModel.up  forState:UIControlStateNormal];
    [self.caiBtn setTitle:[detailModel.down stringValue]  forState:UIControlStateNormal];
    [self.shareBtn setTitle:[detailModel.forward stringValue]  forState:UIControlStateNormal];
    [self.commentBtn setTitle:detailModel.comment forState:UIControlStateNormal];
    
    //    强制刷新
    [self layoutIfNeeded];
    //    获取cell高度
    detailModel.cellHeight=@(CGRectGetMaxY(self.dingBtn.frame)+10+10);
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
