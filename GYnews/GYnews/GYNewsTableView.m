//
//  GYNewsTableView.m
//  tabbar
//
//  Created by hgy on 16/2/26.
//  Copyright © 2016年 hgy. All rights reserved.
//
#define tablecellClick        @"tablecellClick"
#import "GYNewsTableView.h"
#import "MJRefresh.h"
#import "XYString.h"
#import "AFNetworking.h"
#import "GYNewsCellModel.h"
#import "MJExtension.h"
#import "GYNewsBaseCell.h"
#import "GYNewsFirstCell.h"
#import "GYNewsSecondCell.h"
#import "GYNewsThirdCell.h"
#import "GYNewsFourthCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@interface GYNewsTableView()<UITableViewDelegate,UITableViewDataSource>
{
 MJRefreshComponent *myRefreshView;
     NSInteger page;
}

@end
@implementation GYNewsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
         self.separatorColor = [UIColor clearColor];
        //..下拉刷新
        self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            myRefreshView = self.header;
  
            [self loadData];
        }];
        // 马上进入刷新状态
        [self.header beginRefreshing];
        
        //..上拉刷新
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page = page + 10;
            myRefreshView = self.footer;
            [self loadData];
        }];
        self.footer.hidden = YES;
        
        
    }
    return self;

    

}
- (void)setTitle:(NSString *)title
{
    _title = title;
}
- (void)loadData{
    
    NSString * urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/%ld-10.html",self.title,page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [XYString getObjectFromJsonString:operation.responseString];
        
        NSString *key = [dict.keyEnumerator nextObject];//.取键值
        
        NSArray *temArray = dict[key];
        
        // 数组>>model数组
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[GYNewsCellModel mj_objectArrayWithKeyValuesArray:temArray]];
        
        if (myRefreshView == self.header) {
            self.listArry = arrayM;
            self.footer.hidden = self.listArry.count==0?YES:NO;
            
        }else if(myRefreshView == self.footer){
            [self.listArry addObjectsFromArray:arrayM];
        }
        
        [self reloadData];
        [myRefreshView endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败");
        [myRefreshView endRefreshing];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    
    return self.listArry.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYNewsBaseCell * cell = nil;
    GYNewsCellModel * newsModel = self.listArry[indexPath.row];
    
    NSString * identifier = [GYNewsBaseCell cellIdentifierForRow:newsModel];
    Class mClass =  NSClassFromString(identifier);
    
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.newsModel = newsModel;
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GYNewsCellModel * newsModel = self.listArry[indexPath.row];
    NSLog(@"didSelectRowAtIndexPath");
    [[NSNotificationCenter defaultCenter] postNotificationName:tablecellClick object:newsModel];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{     GYNewsCellModel * newsModel = self.listArry[indexPath.row];
    
    NSString * identifier = [GYNewsBaseCell cellIdentifierForRow:newsModel];
    Class mClass =  NSClassFromString(identifier);
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self cellHeightForIndexPath:indexPath model:newsModel keyPath:@"newsModel" cellClass:mClass contentViewWidth:[self cellContentViewWith]];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
