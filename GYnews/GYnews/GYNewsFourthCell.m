//
//  GYNewsFourthCell.m
//  tabbar
//
//  Created by hgy on 16/2/24.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYNewsFourthCell.h"

@implementation GYNewsFourthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
    }
    return  self;
}


- (void)setup{
    // 滚动图片区
    self.cycleScrollView = [[SDCycleScrollView alloc] init];
    [self.contentView addSubview:self.cycleScrollView];
    

    //设置约束
    CGFloat margin = 0;
    self.cycleScrollView.sd_layout
    .topSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(175);
    
    [self setupAutoHeightWithBottomView:self.cycleScrollView bottomMargin:0];
    

}

- (void)setNewsModel:(GYNewsCellModel *)newsModel{

    // 获取滚动图片区数据
    NSMutableArray * imagesURLStrings = [NSMutableArray array];
    NSMutableArray * titles = [NSMutableArray array];
    [newsModel.ads enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Ads * ads = (Ads*)obj;
        [imagesURLStrings addObject:ads.imgsrc];
        [titles addObject:ads.title];

    }];
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;// 分页控件位置
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;// 分页控件风格
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.titlesGroup = titles;
    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"303"];
    
}

@end
