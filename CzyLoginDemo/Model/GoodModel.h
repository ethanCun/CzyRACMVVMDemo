//  GoodModel.h
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


#import <Foundation/Foundation.h>
@class DetailGoodsModel;

@interface GoodModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *rankhour;
@property (nonatomic, copy) NSString *rankdate;
@property (nonatomic, copy) NSString *displaydate;
@property (nonatomic, copy) NSString *rankduring;
@property (nonatomic, strong) NSArray<DetailGoodsModel *> *data;


@end

@interface DetailGoodsModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *mall;
@property (nonatomic, copy) NSString *image;

@end
