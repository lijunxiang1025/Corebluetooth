//
//  FirstManager.m
//  AirContaminationMeter
//
//  Created by Tom on 14/11/28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import "FirstManager.h"

@implementation FirstManager
static FirstManager *manager=nil;
+(id)shareManage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[FirstManager alloc]init];
        manager.dataArr=[NSMutableArray arrayWithCapacity:0];
        manager.isConnectArr=[NSMutableArray arrayWithCapacity:0];
        manager.belArr=[NSMutableArray arrayWithCapacity:0];
    });
    return manager;
}
@end
