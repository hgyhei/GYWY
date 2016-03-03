//
//  GYSegmentView.h
//  tabbar
//
//  Created by hgy on 16/2/28.
//  Copyright © 2016年 hgy. All rights reserved.
//
#define GYTitleButtonMaxFont 20
#define GYTitleButtonMinFont 15
#import <UIKit/UIKit.h>
/**
 *  代理
 */
@protocol GYSegmentDelegate <NSObject>
@optional
- (void)segmentTitleButtonClick:(UIButton *)btn;
@end
@interface GYSegmentView : UIView
/**
 *  标题数组
 */
@property (nonatomic,strong) NSMutableArray *titleArray;
/**
 *  标题按钮数组
 */
@property (nonatomic,strong) NSMutableArray *titleButtonArray;
/**
 *  存放每一个按钮的滚动位置 点击滚到该位置
 */
@property (nonatomic,strong) NSMutableArray *scrollOffSet;
/**
 *  滚动条
 */
@property (nonatomic,strong) UIScrollView *titleScroll;
/**
 *  代理
 */
@property (nonatomic,weak) id <GYSegmentDelegate> delegate;

@end
