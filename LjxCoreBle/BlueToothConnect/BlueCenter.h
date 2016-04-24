//
//  BlueCenter.h
//  BlueToothProduct
//
//  Created by Tom on 14-8-20.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h> 
#import "UARTPeripheral.h"
@protocol BlueCenterDelegate <NSObject>

- (void)faxianfuwu:(CBPeripheral*)periphal;
- (void)connectCenter:(NSString*)name;
- (void)disConnectCenter:(NSString*)error;


@end
@interface BlueCenter : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>{
    
    CBCharacteristic *characteristic;
}
+(id)shareManager;
-(void)initcenManager;
@property (nonatomic, strong) CBCentralManager *cenManager;
@property(nonatomic,retain)CBPeripheral*periphral;
@property (nonatomic, strong) NSMutableData *data;



//判断蓝牙是否开启
@property(nonatomic)BOOL isOpen;
@property (nonatomic, retain) id <BlueCenterDelegate> delegate;



@end
