//
//  ViewController.m
//  AutoPackageAppStore
//
//  Created by ZHUYN on 2018/4/2.
//  Copyright © 2018年 zynabc. All rights reserved.
//

#import "ViewController.h"
#import "APATableViewCell.h"

#define versionInfoKey @"versionInfoKey"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataAry;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubviews];
    [self getAlldata];
}

- (void)setupSubviews
{
    self.title = @"AppStore";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self getAlldata];
    }];
    [tableView.mj_header beginRefreshing];
    [self.view addSubview:tableView];
}

- (void)getAlldata
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.fir.im/apps?api_token=20da9c980e365eb85eca2cf464748a7a" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.dataAry = [APAAppInfo mj_objectArrayWithKeyValuesArray:responseObject[@"items"]];
        [self setupDataAry];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupDataAry
{
    NSDictionary *appInfoDict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:versionInfoKey];
    if (appInfoDict.count != 0)
    {
        for (APAAppInfo *appInfo in self.dataAry)
        {
            if (appInfo.master_release.versionStr.integerValue > [appInfoDict[appInfo.name] integerValue])
            {
                appInfo.isOld = YES;
            }
        }
    }
    
    NSMutableDictionary *setAppInfoDict = [NSMutableDictionary dictionary];
    for (APAAppInfo *appInfo in self.dataAry)
    {
        [setAppInfoDict setValue:appInfo.master_release.versionStr forKey:appInfo.name];
    }
    [[NSUserDefaults standardUserDefaults] setObject:setAppInfoDict forKey:versionInfoKey];
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    APATableViewCell *cell = [APATableViewCell tableViewCell:tableView];
    cell.appInfo = self.dataAry[indexPath.row];
    return cell;
}

#pragma mark - 懒加载
- (NSArray *)dataAry
{
    if (!_dataAry)
    {
        _dataAry = [NSArray array];
    }
    return _dataAry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
