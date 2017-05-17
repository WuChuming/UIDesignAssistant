//
//  BYDclassSourceController.m
//  BYDnetwork
//
//  Created by WuChuMing on 17/5/16.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "BYDclassSourceController.h"
#import "ZTLetterIndex.h"

#define kkkScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define kkkScreenHeight ([[UIScreen mainScreen]bounds].size.height)
@interface BYDclassSourceController ()<UITableViewDataSource, UITableViewDelegate, ZTLetterIndexDelegate>
{
    ZTLetterIndex  *_letterIndex;
}

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *chagedArr;

@property (nonatomic, strong) NSMutableArray *filterArr;

@end

@implementation BYDclassSourceController

- (void)viewWillAppear:(BOOL)animated{
    [[XFAssistiveTouch sharedInstance] hideAssistiveTouch];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[XFAssistiveTouch sharedInstance] showAssistiveTouch];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButton];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.view.backgroundColor = [UIColor grayColor];
//    self.dataSource = [NSMutableArray array];
//    for (int i = 0; i < 26; ++i) {
//        NSMutableArray *temp = [NSMutableArray array];
//        for (int i = 0; i < arc4random()%5+3; ++i) {
//            [temp addObject:[NSString stringWithFormat:@"%d",arc4random()%10000]];
//        }
//        [self.dataSource addObject:temp];
//    }

    
    
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        
        NSRange range = NSMakeRange(0,obj1.length);
        
        return [obj1 compare:obj2 options:comparisonOptions range:range];
        
    };
    NSArray *resultArray = [self.dataSource sortedArrayUsingComparator:sort];
    NSString *previouStr = nil;
    NSMutableArray *tempArr = nil;
    [self.chagedArr removeAllObjects];

    for (NSString *obj in resultArray) {
        
        if (obj.length > 1) {
        if (![[obj substringWithRange:NSMakeRange(0, 1)] isEqualToString:previouStr]) {
            if (tempArr) {
                [self.chagedArr addObject:tempArr];
            }
        tempArr = [NSMutableArray array];
        [self.letterArray addObject:[obj substringWithRange:NSMakeRange(0, 1)]];
            previouStr = [obj substringWithRange:NSMakeRange(0, 1)];
        }
        [tempArr addObject:obj];
            
        }
    }
    
    if (tempArr) {
        [self.chagedArr addObject:tempArr];
    }
    
    _letterIndex = [[ZTLetterIndex alloc] initWithFrame:CGRectMake(kkkScreenWidth-30, 64, 30, kkkScreenHeight-64)];
    _letterIndex.dataArray = self.letterArray; //在其他用于展示的属性赋值之后赋值
    _letterIndex.delegate = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:_letterIndex];
}

- (void)setBackButton{
    
    self.navigationItem.title = @"传送门";
    
    UIButton *cbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    cbutton.frame = CGRectMake(20, 0, 64, 44);
    cbutton.backgroundColor = [UIColor clearColor];
    [cbutton setTitle:@"返回" forState:0];
    [cbutton setTitleColor:[UIColor purpleColor] forState:0];
    [cbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cbutton];

}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (void)setLetterArray:(NSMutableArray *)letterArray{
//    self.letterArray = letterArray;
//    _letterIndex = [[ZTLetterIndex alloc] initWithFrame:CGRectMake(kkkScreenWidth-40, (kkkScreenHeight - 16*25 - 40)/2, 32, 16*25 + 40 + 8)];
//    _letterIndex.dataArray = self.letterArray; //在其他用于展示的属性赋值之后赋值
//    _letterIndex.delegate = self;
//    [self.view addSubview:_letterIndex];
//}
//



#pragma mark - ZTLetterIndexDelegate
- (void)ZTLetterIndex:(ZTLetterIndex *)indexView didSelectedItemWithIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)ZTLetterIndex:(ZTLetterIndex *)indexView beginChangeItemWithIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)ZTLetterIndex:(ZTLetterIndex *)indexView endChangeItemWithIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)ZTLetterIndex:(ZTLetterIndex *)indexView isChangingItemWithIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - UITableViewDelegate&DateSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.chagedArr[indexPath.section][indexPath.row];
    
//    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.letterArray[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.chagedArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chagedArr[section] count];
//    return self.dataSource.count;
}

#pragma ----mark---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = self.chagedArr[indexPath.section][indexPath.row];
    id myObj = [[NSClassFromString(str) alloc] init];
    if ([myObj isKindOfClass:[UIViewController class]]) {
     [self.navigationController pushViewController:myObj animated:YES];
    }
   
    
    
}


#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:scrollView.contentOffset];
    [_letterIndex selectIndex:indexPath.section];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)letterArray{
    if (!_letterArray) {
        _letterArray = [NSMutableArray array];
    }
    return _letterArray;
}

- (NSMutableArray *)chagedArr{
    if (!_chagedArr) {
        _chagedArr = [NSMutableArray array];
    }
    return _chagedArr;
}
- (NSMutableArray *)filterArr{
    if (!_filterArr) {
        _filterArr = [NSMutableArray array];
    }
    return _filterArr;
}

@end
