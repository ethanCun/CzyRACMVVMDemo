//
//  ViewController.m
//  CzyLoginDemo
//
//  Created by macOfEthan on 17/10/27.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import "LoginView.h"
#import "GoodListViewController.h"

@interface ViewController ()

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView = [LoginView new];
    [self.view addSubview:self.loginView];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    WEAK(self);
    
    self.loginView.jumpToDetailGoodsList = ^(GoodModel *model){
    
        GoodListViewController *goodsListVc = [GoodListViewController new];
        
        goodsListVc.goodsModel = model;
        
        [weakself presentViewController:goodsListVc animated:YES completion:nil];
    };
}


@end
