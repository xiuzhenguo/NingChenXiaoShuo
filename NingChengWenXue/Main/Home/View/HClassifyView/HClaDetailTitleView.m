//
//  HClaDetailTitleView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/7.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HClaDetailTitleView.h"
#import "AllTypeModel.h"
#import "TypeListModel.h"

@interface HClaDetailTitleView()<UITableViewDelegate, UITableViewDataSource, HClaDetailCellDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation HClaDetailTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void) setup {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 200) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, BXScreenH - 200, BXScreenW, 200)];
    btn.backgroundColor = [UIColor blackColor];
    btn.alpha = 0.4;
    [btn addTarget:self action:@selector(hiddenDetailTitleView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"分数区%ld",self.array.count);
    return self.sectionArr.count;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HClaDetTitTableViewCell * cell = [HClaDetTitTableViewCell setMyTableViewCellWithTableView:tableView];
    AllTypeModel *model = self.sectionArr[indexPath.section];
    cell.delegate  = self;
    cell.section = indexPath.section;
    cell.arr       = model.Item;
    tableView.rowHeight = cell.height;
    
    return cell;
}

#pragma mark - 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AllTypeModel *model = self.sectionArr[section];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 30)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = model.GenerName;
    title.font = FIFFont;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = BXColor(195,195,195);
    CGRect titWidth = Adaptive_Width(title.text, title.font);
    title.frame = CGRectMake(BXScreenW/2.0-titWidth.size.width/2.0 - 29, 15, titWidth.size.width+58, 15);
    [backView addSubview:title];
    
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 22.5, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    leftLine.backgroundColor = BXColor(195,195,195);
    [backView addSubview:leftLine];
    
    UILabel *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), 22.5, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    rightLine.backgroundColor = BXColor(195,195,195);
    [backView addSubview:rightLine];
    
    return backView;
}

#pragma mark - tableViewCell上按钮点击事件回调
- (void)createUIButtonWithTypeName:(NSString *)typeName Tag:(NSInteger)tag Section:(NSInteger)section{
    NSLog(@"%@",typeName);
    AllTypeModel *model = self.sectionArr[section];
    TypeListModel *list = model.Item[tag - 1000];
    NSString *str = model.GenerName;
    NSString *title = [NSString stringWithFormat:@"%@·%@", str,typeName];
    self.finishButtonTitleStr(title);
    self.finishButtonTypeId([NSString stringWithFormat:@"%ld",list.Id]);
}

-(void)hiddenDetailTitleView
{
    [self removeFromSuperview];
}

@end
