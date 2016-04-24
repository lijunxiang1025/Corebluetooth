//
//  UARTPeripheral.h
//  BlueToothProduct
//
//  Created by Tom on 14-8-28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueCenter.h"
@protocol UARTPeripheralDelegate <NSObject>
- (void) shuaxinUI;
@end

@interface UARTPeripheral : NSObject<CBPeripheralDelegate>{
    //建立全局指针进行播放
    //目标
    NSString*sportGmaol;
    //运动帧数
    NSString*record_id;
    //
    NSString*goal_id;
    
    
    //计算UI刷新
    int a;
 
    
    
    //上传数据
    NSMutableArray*dataArray;
    
    //计算上传数据的次数
    int num;
    
    //记录当前运动数据请求时的瞬间时间
    NSDate *thisTimepostlanya;
    //
    int firstnum ;
    
    int  numberOfblueTooth;
    NSTimer *time1;
     NSTimer *time2;
    
    int timeDifferent;
}

@property (nonatomic,assign)CBPeripheral *a_peripheral;
@property (nonatomic,assign)CBService *uartService;
@property (nonatomic,assign)CBCharacteristic *rxCharacteristic;
@property (nonatomic,assign)CBCharacteristic *txCharacteristic;
@property (nonatomic,retain)id<UARTPeripheralDelegate> delegate;


@property  (nonatomic)int sum;
+(id)shareManager;

//每次刷新时记录的数组
@property(nonatomic,retain)NSMutableArray*dataArray1;
//- (void) writeString:(NSString *) string;

//- (void) initWithPeripheral:(CBPeripheral*)peripheral delegate:(id<UARTPeripheralDelegate>) delegate;

#pragma mark 控制周边写入数据
- (void) writeString:(NSData *) writeData;
@property(nonatomic,retain)NSString*name;

//信号检测
@property(nonatomic,retain)NSMutableArray*xinhaoArr;
@end
