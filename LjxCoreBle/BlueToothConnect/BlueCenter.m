//
//  BlueCenter.m
//  BlueToothProduct
//
//  Created by Tom on 14-8-20.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import "BlueCenter.h"
@implementation BlueCenter
static BlueCenter *blManager=nil;
+(id)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         blManager=[[BlueCenter alloc]init];
        //初始化之后走代理
        [blManager initcenManager];
    });
    return blManager;
}
//初始化信息
-(void)initcenManager{

     blManager.cenManager=[[CBCentralManager alloc]initWithDelegate:self  queue:nil];
    
}

#pragma mark 蓝牙代理
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            //如果为开启
            [self scan];
            // -scanForPeripheralsWithServices:options:方法是用于告诉Central Manager，要开始寻找一个指定的服务了。如果你将第一个参数设置为nil，Central Manager就会开始寻找所有的服务。
            //kServiceUUID和创建周边的那个工程中用的是一样的UUID。所以，再添加一次以下两行代码：
            //static NSString * const kServiceUUID = @"312700E2-E798-4D5C-8DCF-49908332DF9F";
            //static NSString * const kCharacteristicUUID = @"FFA28CDE-6525-4489-801C-1C060CAC9767";
            //记住UUID是你自己用uuidgen命令生成的。一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调：
            // - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheraladvertisementData:(NSDictionary *)advertisementDataRSSI:(NSNumber *)RSSI
            //这个调用通知Central Manager代理（在这个例子中就是view controller），一个附带着广播数据和信号质量(RSSI-Received Signal Strength Indicator)的周边被发现。这是一个很酷的参数，知道了信号质量，你可以用它去判断远近。任何广播、扫描的响应数据保存在advertisementData中，可以通过CBAdvertisementData来访问它。现在，你可以停止扫描，而去连接周边了：
            break;
        case CBCentralManagerStatePoweredOff:
            
        {
            self.isOpen=NO;
            
        }
            
            break;
        default:
            
            NSLog(@"Central Manager did change state");
            break;
    }
}
#pragma mark 蓝牙开启 扫描周围
-(void)scan{
    NSLog(@"小苹果要开始找蓝牙了 ");

    //@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID],]
    
    //中央找到有此服务的蓝牙
    
    
   // Service 服务UUID
    [self.cenManager scanForPeripheralsWithServices:nil
                                                options:nil];
    //options中的意思是否允许中央设备多次收到曾经监听到的设备的消息，这样来监听外围设备联接的信号强度，以决定是否增大广播强度，为YES时会多耗电
    
    
    
    
}


-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
   // NSLog(@"%d",peripheral.state);
    
  
     NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    NSLog(@"~~~~%@",peripheral);
    //这个属性特殊  如果没有换手机 也就是说 1个设备对应一个手机 那么这个identifier则固定不变  如果另一个手机和设备连接 则identifier变化 而且相对另一个手机不变  也就是说这是1对1的稳定连接关系  是为了做重练
    NSLog(@"此时的连接的peripheral:%@",    peripheral.identifier);
    NSLog(@"======%@",advertisementData);
    
//    if (![peripheral.name isEqualToString:@"POD Tracker-78A50410"]) {
//        <#statements#>
//    }
    
    if (self.periphral!=peripheral) {
            NSLog(@"5555555");
        self.periphral=peripheral;
        
        
        
        
//        if ([peripheral.name isEqualToString:belName]) {

            if ([self.delegate respondsToSelector:@selector(faxianfuwu:)]) {
                
                
                [self.delegate faxianfuwu:peripheral];
            }
//        }
        
        
      //  NSLog(@"我切一下~~~~~%@",self.periphral.name);
        
        //options参数是一个可选的NSDictionary，如果需要，可以用以下的键（Key），它们的值始终是一个boolean。
        //CBConnectPeripheralOptionNotifyOnConnectionKey。
        //  这是一个NSNumber的（布尔型），指示系统应该对于一个给定的外围显示一个警告，如果应用程序被挂起，当一个成功的连接而成。这是为应用程序有用而没有指定的中央背景模式并不能显示自己的警报。如果多于一个的应用程序请求的通知对于给定的外围时，这就是一个最近在前景将收到警报。
        //CBConnectPeripheralOptionNotifyOnDisconnectionKey。
        //  这是aNSNumber（布尔型），指示系统应显示断线警报的定外设，如果应用程序被暂停在断开的时间。这是有用还没有指定的中央应用背景模式，不能显示自己的警报。如果一个以上的应用程序已请求通知对于给定的外设时，这就是一个最近在前台将收到警报。
        //CBConnectPeripheralOptionNotifyOnNotificationKey。
        //  这是aNSNumber（布尔型），指示 系统应显示一个警告所有通知从一个给定的外设接收的，如果应用程序在时间被暂停。这是有用还没有指定的中央应用背景模式，不能显示自己的警报。如果一个以上的应用程序已请求通知对于给定的外围，就是那个最近是在前景将收到警报。
        
    }
    
    
    //[self performSelector:@selector(stopSc) withObject:nil afterDelay:20];
}

//-(void)stopSc{
//    //中央设备停止扫描
//    [self.cenManager stopScan];
//
//}
//连接上外围设备后我们就要找到外围设备的服务特性
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    
    
    NSLog(@"此时的连接装态为1111peripheral:%@",peripheral);
    
//    if () {
//        <#statements#>
//    }
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
   // [defaults objectForKey:@"firstblueConnect"];
    self.periphral=peripheral;
    [defaults setObject:@"1" forKey:@"SmartAirConnect"];
  
   
    [defaults synchronize];
    
    
    
    if ([self.delegate respondsToSelector:@selector(connectCenter:)]) {
        [self.delegate connectCenter:peripheral.name];
    }
    
    //连接完成后，就停止检测
    [self.cenManager stopScan];
    
   
    
    NSLog(@"~~~~~~peripheral.RSSI~%@",peripheral.RSSI);
    //初始化数据
   // [self.data setLength:0];
    //确保我们收到的外围设备连接后的回调代理函数
  //  peripheral.delegate=self;
    //让外围设备找到与我们发送的UUID所匹配的服务
    
    /*************~~~~~~~~周边信息*************************/
    //将已发现的周边设备保存下来
    
    
    UARTPeripheral *uPeripheral=[UARTPeripheral shareManager];

        uPeripheral.a_peripheral =peripheral;
       uPeripheral.a_peripheral.delegate=uPeripheral;
    //
    //这里我把他代理在这里初始化 他应该会走吧 按代理的协议是这样的
    //周边设备是否有此服务 这里跳到UARTPeripheral类
    [uPeripheral.a_peripheral discoverServices:nil];
    
    //蓝牙开始发送数据
    //发送已经设置好的数据
    
    
}







-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSString*str=[NSString stringWithFormat:@"%@",error];
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"SmartAirConnect"];
    
   
    
    
}





////相当于对方的账号
//-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
//    
//    if (error) {
//        NSLog(@"Errordiscover:%@",error.localizedDescription);
//        [self clearUp];
//        return;
//    }
//    //找到我们想要的特性
//    //遍历外围设备
//    for (CBService*server in peripheral.services) {
//        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1],[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:server];
//    }
//    
//}
//
////当发现传送服务特性后我们要订阅他 来告诉外围设备我们想要这个特性所持有的数据
//-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
//{
//    if (error) {
//        NSLog(@"error  %@",[error localizedDescription]);
//        [self clearUp];
//        return;
//    }
//    //检查特性
//    for (CBCharacteristic*characteristic in service.characteristics) {
//       // if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1]]) {
//            //有来自外围的特性，找到了，就订阅他
//            // 如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//            //完成后，等待数据传进来
//            NSLog(@"订阅成功");
//            
//        //}
//    }
//    
//}
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//{
//    if (error) {
//        NSLog(@"error~~%@",error.localizedDescription);
//        return;
//    }
//    //characteristic.value 是特性中所包含的数据
//    //NSString*stringFromData=[Utils NSDataToByteTohex:characteristic.value];
//    
//    // NSLog(@"~~~~~%@",characteristic.value);
//    if ([characteristic.UUID isEqual:TRANSFER_CHARACTERISTIC_UUID1]) {
//         NSLog(@"~~~~~~%@",characteristic.value);
//    }
//   
//    
////    if ([stringFromData isEqualToString:BluetoothEnd]) {
////        //完成发送，调用代理进行传递self.data
////       // NSString*str=[[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
////        //取消订阅
////        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
////        [self.cenManager cancelPeripheralConnection:peripheral];
////        //self.blockValue(str);
////        
////    }else{
////        //数据没有传递完成，继续传递数据
////      //  [self.data appendData:characteristic.value];
////        
////    }
//    
//}
////外围设备让我们知道，我们订阅和取消订阅是否发生
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//{
//    if (error) {
//        NSLog(@"error  %@",error.localizedDescription);
//    }
//    //如果不是我们要特性就退出
////    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1]]) {
////        return;
////    }
////    
//    if (characteristic.isNotifying) {
//        NSLog(@"外围特性通知开始");
//    }else{
//        NSLog(@"外围设备特性通知结束，也就是用户要下线或者离开%@",characteristic);
//        //断开连接
//        [self.cenManager cancelPeripheralConnection:peripheral];
//        
//    }
//}
//-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
//{
//    NSLog(@"disconnected");
//    self.periphral=nil;
//    [self scan];
//}
////连接失败时的处理
//-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
//{
//    NSLog(@"Failed to connect to %@~~~%@",peripheral,[error localizedDescription]);
//    [self clearUp];
//    
//}
//
//
//
//-(void)clearUp{
//    if (![self.periphral isConnected]) {
//        return;
//    }
//    
//    if (self.periphral.services!=nil) {
//        for (CBService*server in self.periphral.services) {
//            
//            if (server.characteristics!=nil) {
//                for (CBCharacteristic*chatacter in server.characteristics) {
//                    
//                    if ([chatacter.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1]]) {
//                        
//                        //查看是否订阅了
//                        if (chatacter.isNotifying) {
//                            //如果订阅了。取消订阅
//                            [self.periphral setNotifyValue:NO forCharacteristic:chatacter];
//                            return;
//                        }
//                        
//                    }
//                    
//                }
//            }
//        }
//    }
//    //如果我们连接了，但是没有订阅，就断开连接即可
//    [self.cenManager cancelPeripheralConnection:self.periphral];
//    
//}

@end
