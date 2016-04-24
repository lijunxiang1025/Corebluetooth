//
//  FirstManager.h
//  AirContaminationMeter
//
//  Created by Tom on 14/11/28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstManager : NSObject
+(id)shareManage;


@property(nonatomic,retain)NSMutableArray*dataArr;
@property(nonatomic,retain)NSMutableArray*isConnectArr;
@property(nonatomic,retain)NSMutableArray*belArr;

@end
