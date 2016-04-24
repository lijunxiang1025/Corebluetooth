//
//  BindAirViewController.m
//  AirContaminationMeter
//
//  Created by Tom on 14/11/28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import "BindAirViewController.h"
@interface BindAirViewController ()

@end

@implementation BindAirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:0.94 green:0.95 blue:0.94 alpha:1];
    [self createNav];
    [self createView];
}
-(void)createNav{
    self.title=@"连接设备";
    UIButton*bt=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 12, 20) ImageName:@"left" Target:self Action:@selector(goback) Title:nil];
    UIBarButtonItem*leftBt=[[UIBarButtonItem alloc]initWithCustomView:bt];
    self.navigationItem.leftBarButtonItem=leftBt;
  
   
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createView{
    
   
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, VIEWWIDTH, VIEWHEIGHT-80) style:UITableViewStyleGrouped];
    self.tableView.dataSource   =self;
    self.tableView.delegate     =self;
    [self.view addSubview:self.tableView];
    
    blueCenter=[BlueCenter shareManager];
    blueCenter.delegate=self;
    
}
-(void)faxianfuwu:(CBPeripheral *)periphal{
    
    
    FirstManager*firstManager=[FirstManager shareManage];
    if(firstManager.dataArr.count==0){
        
        NSString*str2=[NSString stringWithFormat:@"%@",periphal.identifier];
        
        NSLog(@"~~~%@",str2);
        NSString*str4=[[str2 componentsSeparatedByString:@"> "] lastObject];
        NSLog(@"~~~%@",str4);
        
        [firstManager.dataArr addObject:str4];
        
        NSLog(@"%@",firstManager.dataArr);
        
        
        if (periphal.state!=0) {
            [firstManager.isConnectArr addObject:@"1"];
        }else{
            [firstManager.isConnectArr addObject:@"0"];
        }
        [firstManager.belArr addObject:periphal];
        [self.tableView reloadData];

        return;
    }
    
    NSString*bleName=[NSString  stringWithFormat:@"%@",periphal.identifier];
    NSString*bleName1=[[bleName componentsSeparatedByString:@"> "] lastObject];

    for (int i=0;i<firstManager.dataArr.count;i++){
        
        
        NSString*str1=firstManager.dataArr[i];
        
        if ([bleName1 isEqualToString:str1] ) {
            
            return;
        }
    }
    
    [firstManager.dataArr addObject:bleName1];
    if (periphal.state!=0) {
        [firstManager.isConnectArr addObject:@"1"];
    }else{
        [firstManager.isConnectArr addObject:@"0"];
    }
    [firstManager.belArr addObject:periphal];

    [self.tableView reloadData];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FirstManager*manager=[FirstManager shareManage];
    return manager.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    BindAirTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell==nil) {
        cell=[[BindAirTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    FirstManager*manager=[FirstManager shareManage];
    
    NSLog(@"%@~~~%@",manager.dataArr,manager.isConnectArr);
    [cell config:manager.dataArr and:manager.isConnectArr and:indexPath.row];
    return cell ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    FirstManager*manager=[FirstManager shareManage];

    if ([manager.isConnectArr[indexPath.row] isEqualToString:@"1"]) {
        BlueCenter*center=[BlueCenter shareManager];
        [center.cenManager cancelPeripheralConnection:manager.belArr[indexPath.row]];
        manager.isConnectArr[indexPath.row]=@"0";
        [self.tableView reloadData];
        return;
    }
    else{
        BlueCenter*center=[BlueCenter shareManager];
        for (int i=0; i<manager.belArr.count; i++) {
            CBPeripheral  *per=manager.belArr[i];
            [center.cenManager cancelPeripheralConnection:per];
            manager.isConnectArr[i]=@"0";

        }
        
        [center.cenManager connectPeripheral:manager.belArr[indexPath.row] options:nil];
        manager.isConnectArr[indexPath.row]=@"1";
        [self.tableView reloadData];
    }
    
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
