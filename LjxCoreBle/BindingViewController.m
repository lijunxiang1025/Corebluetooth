//
//  BindingViewController.m
//  AirContaminationMeter
//
//  Created by Tom on 14-11-11.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//
#import "BindingViewController.h"
#import "UARTPeripheral.h"
@interface BindingViewController ()

@end

@implementation BindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    [self  createNav];
    [self createView];
}
-(void)createNav{
    self.title=@"蓝牙绑定";
    BlueCenter*blCenter=[BlueCenter shareManager];
    blCenter.delegate=self;
}

//实验页面
-(void)createView{
    
    UIScrollView*sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, VIEWWIDTH, VIEWHEIGHT)];
    sc.contentSize=CGSizeMake(320, VIEWHEIGHT*2-300);
    sc.showsHorizontalScrollIndicator=NO;
    sc.showsVerticalScrollIndicator=NO;
    [self.view addSubview:sc];
    
    
    
    backImageV=[ZCControl createImageViewWithFrame:CGRectMake(0, 50, VIEWWIDTH, VIEWHEIGHT*2-300) ImageName:nil];
    backImageV.backgroundColor=[UIColor clearColor];
    [sc addSubview:backImageV];
    
    UILabel*label=[ZCControl createLabelWithFrame:CGRectMake(0, 0,VIEWWIDTH/2, 40) Font:15 Text:@"已连接"];
    label.textColor=[UIColor redColor];
    [backImageV addSubview:label];
    
    NSArray*titleArr=@[@"待机",@"智能模式",@"手动风速2",@"手动风速3",@"净化模式",@"臭氧模式",@"家用",@"车载",@"获取状态",@"产品寿命",@"同步时间",@"修改设备",@"定时"];
    
    for (int i=0; i<13; i++) {
        UIButton*bt=[ZCControl createButtonWithFrame:CGRectMake(30+(100+30)*(i%2), 50+i/2*(20+40), 100, 40) ImageName:nil Target:self Action:@selector(sendInstructions:) Title:titleArr[i]];
        [bt setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        bt.backgroundColor=[UIColor yellowColor];
        bt.tag=400+i;
        [backImageV addSubview:bt];
    }
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SmartAirConnect"] intValue]==1) {
//        backImageV.alpha=1;
//    }else{
//    backImageV.alpha=0;
//    }
}


-(void)sendInstructions:(UIButton*)bt{
    UARTPeripheral*per=[UARTPeripheral shareManager];
    
    switch (bt.tag-400) {
        case 0:
        {
        //待机
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x01,0x01,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
            
        }
            break;
        case 1:
        {
            
        //智能模式
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x01,0x02,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
        }
            break;
        case 2:
        {
            //手动风速2
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x01,0x03,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
        }
            break;
        case 3:
        {
            //手动风速3
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x01,0x04,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
        }
            break;
        case 4:
        {
            //净化模式
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x01,0x05,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
        }
            break;
        case 5:
        {
            //臭氧模式
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x01,0x06,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
        }
            break;
        case 6:
        {
            //家用
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x02,0x01,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
        }
            break;
        case 7:
        {
            //车载
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[4]={0xaa,0x02,0x02,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:4];
                [per writeString:data1];
            }
        }
            break;
        case 8:
        {
            //获取状态
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[3]={0xaa,0x03,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:3];
                [per writeString:data1];
            }
        }
            break;
        case 9:
        {
            //产品寿命
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[3]={0xaa,0x04,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:3];
                [per writeString:data1];
            }
        }
            break;
        case 10:
        {
            //同步时间
           
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[9]={0xaa,0x07,0x0e,0x0b,0x09,0x09,0x0b,0x0b,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:9];
                [per writeString:data1];
            }

            
        }
            break;
        case 11:
        {
            //修改设备名字
            NSLog(@"净化空气");

        }
            break;
        case 12:
        {
            //净化空气
            NSLog(@"净化空气");
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"SmartAirConnect"] intValue]==1) {
                Byte byte2[9]={0xaa,0x07,0x0e,0x0b,0x09,0x09,0x0b,0x0b,0xff};
                NSData*data1=[NSData dataWithBytes:byte2 length:9];
                [per writeString:data1];
            }
        }
            break;
        default:
            break;
    }
    
}
-(void)connectCenter:(NSString*)bluetoothName{
    
//    [UIView animateWithDuration:1 animations:^{
//        backImageV.alpha=1;
//     
//    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
