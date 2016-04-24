//
//  UARTPeripheral.m
//  BlueToothProduct
//
//  Created by Tom on 14-8-28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import "UARTPeripheral.h"

@implementation UARTPeripheral

//单例初始化
static UARTPeripheral * UARtPmanager=nil;
+(id)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UARtPmanager=[[self alloc]init];
       
        UARtPmanager.sum=0;
        UARtPmanager.xinhaoArr=[NSMutableArray arrayWithCapacity:0];
//        UARtPmanager.delegate=self;
        [UARtPmanager addNot];
    });
    
    return UARtPmanager;
    
}


-(void)addNot{

    
    
    
}

#pragma mark 周边设备的代理

//发现特征后
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    //打印错误 看不懂就算了 我也看不懂
    if (error)
    {
        NSLog(@"Error discovering services: %@", error);
        return;
    }
    
    
    //发现周边的服务
    for (CBService *s in [peripheral services])
    {
        //周边的服务是否为我想要的
//        if ([s.UUID isEqual: [CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]])
//        {
        //服务只管中央和周边连接
        //特征 通道管理交互信息
            
            NSLog(@"Found correct service");
            self.uartService = s;
            ////发现给定服务的特点
           // [peripheral readRSSI];
            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID], [CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1] ] forService:self.uartService];
        
//        }
        
    
    }
}


////现在，如果一个特征被发现，周边代理会接收-
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
    
        
    self.name=peripheral.name;
    if (error)
    {
        NSLog(@"Error discovering characteristics: %@", error);
        return;
    }
    //这个时候 特性发现后进入这里
    for (CBCharacteristic *c in [service characteristics])
    {
        if ([c.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1]])
        {
            //此特性是 外围设备发给手机的通道
            self.rxCharacteristic = c;
            //有来自外围的特性，找到了，就订阅他
            // 如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:self.rxCharacteristic];
            
         
        }
        else if ([c.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]])
            
        {
            //此通道是 手机下发给外围蓝牙的数据通道
            NSLog(@"Found TX characteristic");
            self.txCharacteristic = c;
            [self  performSelector:@selector(giveOrder) withObject:nil afterDelay:2];
            //[self giveOrder];
        }
        
        
    }
}
//连接后写入数据
-(void)giveOrder{
   
    
}

//这个函数类似网络请求时候只需收到数据的那个函数
- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error receiving notification for characteristic %@: %@", characteristic, error);
        return;
    }
    
    NSLog(@"Received data on a characteristic.%@",characteristic.value);
    //若果是这个通道 则 接受数据
    if (characteristic == self.rxCharacteristic)
    {
        
        NSLog(@"%@~~~~~~~~~",characteristic.value);
//        
//        NSString *string = [NSString stringWithUTF8String:[[characteristic value] bytes]];
        //接受的数据
        NSData*receiveData= [NSData dataWithData:characteristic.value];
       // NSString*str=[[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
      //  NSMutableString*str1=[NSMutableString stringWithCapacity:0];
        NSUInteger len = [receiveData length];
        Byte * byteData = (Byte*)malloc(len);
        memcpy(byteData, [receiveData bytes], len);
      //<fabc123124>
        if(byteData[0]==15){
            
            //做什么事情
            //[f,a,b,c,1,2,3,1,2,4]
            //f 让你拍照
            //a  让你放音乐
        }
        
        
    }
    
}


//外围设备让我们知道，我们订阅和取消订阅是否发生
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"error  %@",error.localizedDescription);
    }
    //如果不是我们要特性就退出
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1]]) {
        return;
    }
    
    if (characteristic.isNotifying) {
        NSLog(@"外围特性通知开始");
    }else{
        NSLog(@"外围设备特性通知结束，也就是用户要下线或者离开%@",characteristic);
        //断开连接
        
        
        //这里可以写个代理 或者通知 （我把中心和周边封成两个库 所以就这样，下面方法是断开连接）
        //[self.centralManager cancelPeripheralConnection:peripheral];
    }
}

#pragma mark 控制周边写入数据
- (void) writeString:(NSData *) writeData
{

    if(self.txCharacteristic != nil) {
        NSLog(@"pwmData right!");
       [self.a_peripheral writeValue:writeData  forCharacteristic:self.txCharacteristic type:CBCharacteristicWriteWithResponse];
    }else
    {
        NSLog(@"pwmData ERROR!");
        
    }
    

    
    
    

}
#pragma mark 读取到蓝牙信号强度 防丢
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error{
     NSLog(@"读取到蓝牙信号强度 防丢5.0");
    
    if (!peripheral.RSSI) {
        return;
    }
    NSLog(@"当前信号~~~~%@",peripheral.RSSI);
    int rssi = abs([peripheral.RSSI intValue]);
    CGFloat ci = (rssi - 49) / (10 * 2.);
    //    a=-8.173*log()-75.562;
    
    NSLog(@"%f",ci);
//[[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"fdKG"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"fdKG"] intValue]==1) {
        [_xinhaoArr addObject:[NSString stringWithFormat:@"%@",peripheral.RSSI]];
        
        if (_xinhaoArr.count==5) {
            float a1=0;
            for (int i=0; i<5; i++) {
               int rssi1= abs([self.xinhaoArr[i] intValue]);
                a1=a1+rssi1;
            }
            if (a1/5>90.0) {
                [ZCControl baojing];
                // Byte byte2[6]={0Xaa,0X3a,0X02,h1,d1-1,0x00};
                Byte byte[4]={0xaa,0x43,0x01,0x00};
                byte[3]=byte[0]+byte[1]+byte[2];
                NSData*data=[NSData dataWithBytes:byte length:4];
                [self writeString:data];
            }
            [_xinhaoArr removeAllObjects];
            _xinhaoArr=nil;
        }
    }
    
}
- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error NS_AVAILABLE(NA, 8_0){
         NSLog(@"读取到蓝牙信号强度 防丢8.0");
    
    NSLog(@"%@",RSSI);
    int rssi = abs([RSSI intValue]);

    CGFloat ci = (rssi - 49) / (10 * 2.);
    //    a=-8.173*log()-75.562;
    
    NSLog(@"%f",ci);
    //[[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"fdKG"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"fdKG"] intValue]==1) {
        if (_xinhaoArr.count==5) {
            float a1=0;
            for (int i=0; i<5; i++) {
                int rssi1= abs([self.xinhaoArr[i] intValue]);
                a1=a1+rssi1;
            }
            if (a1/5>90.0) {
                [ZCControl baojing];
                // Byte byte2[6]={0Xaa,0X3a,0X02,h1,d1-1,0x00};
                Byte byte[4]={0xaa,0x43,0x01,0x00};
                byte[3]=byte[0]+byte[1]+byte[2];
                NSData*data=[NSData dataWithBytes:byte length:4];
                [self writeString:data];
            }
            [_xinhaoArr removeAllObjects];
            _xinhaoArr=nil;
        }
        
       
        
        
    }

    
}


- (void)connectCenter:(NSString*)name{
    
}
- (void)disConnectCenter:(NSString*)error{
    
}
@end
