//  LoginView.m
//  CzyLoginDemo
//  Created by macOfEthan on 17/10/27.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//  Github:https://github.com/ITIosEthan
//  简书：http://www.jianshu.com/u/1d52648daace
/**
 *   █████▒█    ██  ▄████▄   ██ ▄█▀   ██████╗ ██╗   ██╗ ██████╗
 * ▓██   ▒ ██  ▓██▒▒██▀ ▀█   ██▄█▒    ██╔══██╗██║   ██║██╔════╝
 * ▒████ ░▓██  ▒██░▒▓█    ▄ ▓███▄░    ██████╔╝██║   ██║██║  ███╗
 * ░▓█▒  ░▓▓█  ░██░▒▓▓▄ ▄██▒▓██ █▄    ██╔══██╗██║   ██║██║   ██║
 * ░▒█░   ▒▒█████▓ ▒ ▓███▀ ░▒██▒ █▄   ██████╔╝╚██████╔╝╚██████╔╝
 *  ▒ ░   ░▒▓▒ ▒ ▒ ░ ░▒ ▒  ░▒ ▒▒ ▓▒   ╚═════╝  ╚═════╝  ╚═════╝
 */

#import "LoginView.h"
#import "NetwokerManager.h"
#import "GoodModel.h"

#define Goods_url @"http://guangdiu.com/api/getranklist.php"

@interface LoginView ()

@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) GoodModel *goodsModel;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubViews];
        
        [self isLoginEnabled];
        
        [self login];
    }
    return self;
}

- (void)login
{
    [[[[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        
        [SVProgressHUD show];
        
    }] flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
        
        return [[NetwokerManager shareManager] requestWithMethod:RequestTypePost withTargetUrl:Goods_url andParameters:nil];
    }] subscribeNext:^(id  _Nullable x) {
        
        self.goodsModel = [GoodModel yy_modelWithJSON:x];
        
        [SVProgressHUD dismiss];
        
        if (self.jumpToDetailGoodsList) {
            self.jumpToDetailGoodsList(self.goodsModel);
        }
        
    } error:^(NSError * _Nullable error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}

- (void)setupSubViews
{
    _accountTF = [UITextField new];
    _passwordTF = [UITextField new];
    _accountTF.layer.borderColor = [UIColor blueColor].CGColor;
    _passwordTF.layer.borderColor = [UIColor blueColor].CGColor;
    _accountTF.layer.borderWidth = 1;
    _passwordTF.layer.borderWidth = 1;
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    
    
    [self addSubViewsInArr:@[_accountTF, _passwordTF, _registerBtn, _loginBtn]];
    
    
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(200);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
    }];
    
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(_accountTF.mas_bottom).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
    }];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        make.top.equalTo(_passwordTF.mas_top).offset(150);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        make.top.equalTo(_passwordTF.mas_top).offset(150);
    }];
}


- (void)isLoginEnabled
{
    RACSignal *accountSignal = [[_accountTF rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        
        return @(value.length >= 6);
    }];
    
    RACSignal *passwordSignal = [[_passwordTF rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        
        return @(value.length >= 6);
    }];
    
    RACSignal *loginSignal = [RACSignal combineLatest:@[accountSignal, passwordSignal] reduce:^id _Nullable(id account, id password){
        
        return @([account boolValue] && [password boolValue]);
        
    }];
    
    [loginSignal subscribeNext:^(id  _Nullable x) {
        
        if ([x boolValue]) {
            
            [_loginBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            _loginBtn.userInteractionEnabled = YES;
        }else{
            
            [_loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _loginBtn.userInteractionEnabled = NO;
        }
    }];

}

- (void)addSubViewsInArr:(NSArray<UIView *> *)array
{
    for (UIView *view in array) {
        
        [self addSubview:view];
    }
}

@end
