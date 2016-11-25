//
//  EEssenceImageCell.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "EssenceImageCell.h"
#import "BDJEssenceModel.h"

@interface EssenceImageCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentYCons;

@end



@implementation EssenceImageCell

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

+(EssenceImageCell *)imageCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath withModel:(BDJEssenceDetail *)detailModel{
    static NSString *cellId=@"imageCell";
    EssenceImageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil==cell){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"EssenceImageCell" owner:nil options:nil]lastObject];
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
    NSString *imageString=[detailModel.image.thumbnail_small firstObject];
    NSURL *videoUrl=[NSURL URLWithString:imageString];
    [self.bigImageView sd_setImageWithURL:videoUrl placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    //    修改图片的高度==width/height
    CGFloat imageH=(KScreenWidth-20)*detailModel.image.height.floatValue/detailModel.image.width.floatValue;
    if (imageH >= 400){
        imageH=400;
    }
    self.ImageHeightCons.constant=imageH;
    
    //    6,评论文字
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
    
    //    7,标签
    NSMutableString *tagString=[NSMutableString string];
    for (NSInteger i=0;i<detailModel.tags.count;i++){
        BDJEssenceTag *tag=detailModel.tags[i];
        [tagString appendFormat:@"%@",tag.name];
    }
    self.tagLabel.text=tagString;
    
    // 8,
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
