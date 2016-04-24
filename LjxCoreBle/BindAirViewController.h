//
//  BindAirViewController.h
//  AirContaminationMeter
//
//  Created by Tom on 14/11/28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueCenter.h"
#import "BindAirTableViewCell.h"
@interface BindAirViewController : UIViewController<BlueCenterDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BlueCenter*blueCenter;
}
@property(nonatomic,retain)UITableView*tableView;
@end
