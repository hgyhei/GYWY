//
//  GYNewsBaseCell.m
//  tabbar
//
//  Created by hgy on 16/2/24.
//  Copyright © 2016年 hgy. All rights reserved.
//

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#import "GYNewsBaseCell.h"

@implementation GYNewsBaseCell

// 获取数据类型对应的cell
+(NSString *)cellIdentifierForRow:(GYNewsCellModel *)newsModel{

    if (newsModel.hasHead && newsModel.photosetID&&newsModel.ads){
        return @"GYNewsFourthCell";
    }else if (newsModel.imgType){
        return @"GYNewsThirdCell";
    }else if (newsModel.imgextra){
        return @"GYNewsSecondCell";
    }else{
        return @"GYNewsFirstCell";
    }
 
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgIcon = [UIImageView new];
        [self.contentView addSubview:self.imgIcon];
        
        self.lblTitle = [UILabel new];
        self.lblTitle.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.lblTitle];
        
        self.lblSubtitle = [UILabel new];
        self.lblSubtitle.textColor = [UIColor grayColor];
        self.lblSubtitle.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.lblSubtitle];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = rgba(238, 238, 238, 1.0);
        [self.contentView addSubview:self.lineView];
        
        self.imgOther1 = [UIImageView new];
        [self.contentView addSubview:self.imgOther1];

        self.imgOther2 = [UIImageView new];
        [self.contentView addSubview:self.imgOther2];
        
         
    }
    return self;
}

@end
