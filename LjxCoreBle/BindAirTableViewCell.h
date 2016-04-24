//
//  BindAirTableViewCell.h
//  AirContaminationMeter
//
//  Created by Tom on 14/11/28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindAirTableViewCell : UITableViewCell
{
    UIImageView*imageV;
    UILabel*titleLabel;
    UILabel*idefineLabel;
}
-(void)config:(NSMutableArray*)dataArr and:(NSMutableArray*)isconnectArr and:(int)index;
@end
