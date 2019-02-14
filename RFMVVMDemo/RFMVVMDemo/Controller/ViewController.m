//
//  ViewController.m
//  RFMVVMDemo
//
//  Created by 庞日富 on 2019/2/13.
//  Copyright © 2019 庞日富. All rights reserved.
//

#import "ViewController.h"
#import "ViewModelClass.h"
#import "HomeVM.h"
#import "HeaderView.h"
#import "DetailViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView初始化 */
@property (nonatomic, strong) UITableView *tableView;
/** 总数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 分类数据 */
@property (nonatomic, strong) NSMutableArray *categoryArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.title = @"MVVM案例";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor greenColor];
    
    
    _dataArray = [NSMutableArray array];
    _categoryArray = [NSMutableArray array];
    
    
    
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH * 0.17*2+30)];
    
    self.tableView.tableHeaderView = headerView;
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    __weak typeof(self) weakself = self;
    [headerView setBlock:^(NSString *shopId) {
        detail.labelText = shopId;
        [weakself.navigationController pushViewController:detail animated:YES];
    }];
    
    HomeVM *model = [[HomeVM alloc]init];
    [model setBlockWithReturnBlock:^(id returnValue) {
        self.dataArray = returnValue;
        [headerView headerViewWithData:self.dataArray];
        [self.tableView reloadData];
        
    } WithErrorBlock:^(id errorCode) {
        
        NSLog(@"%@",errorCode);
        
    }];
    
    //获取数据列表;
    [model fetchShopList];
}

#pragma mark - 返回TableViewCell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
#pragma mark - 创建TableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        //是用代码创建的Cell
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"测试";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeVM *model = [[HomeVM alloc]init];
    [model shopListDetailWithVC:self didSelectRowAtDic:self.dataArray[indexPath.row]];
}

@end
