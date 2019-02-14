

#import "HomeVM.h"
#import "DetailViewController.h"

@implementation HomeVM

- (void)fetchShopList{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //在此new一个字典数组
    NSMutableDictionary *dic2 =[NSMutableDictionary dictionary];
    dic2[@"id"] = @(1);
    dic2[@"icon"] = @"image";
    dic2[@"title"] = @"儿童车";
    dic2[@"itemId"] = @"123";
    dic[@"data"] = @[dic2,dic2,dic2];
    
    NSMutableArray *arr = dic[@"data"];
    self.returnBlock(arr);

}

- (void)shopListDetailWithVC:(UIViewController *)vc didSelectRowAtDic:(NSDictionary *)dic{
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.labelText = dic[@"title"];
    detailVC.shopId = dic[@"itemId"];
    [vc.navigationController pushViewController:detailVC animated:YES];
}

@end


