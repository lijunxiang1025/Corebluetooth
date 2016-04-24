//
//  BindAirTableViewCell.m
//  AirContaminationMeter
//
//  Created by Tom on 14/11/28.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//

#import "BindAirTableViewCell.h"

@implementation BindAirTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}
-(void)createView{

    titleLabel=[ZCControl createLabelWithFrame:CGRectMake(30, 10, 80, 30) Font:10 Text:@"SMART AIR X1"];
    titleLabel.textColor=[UIColor blackColor];
    [self addSubview:titleLabel];
    idefineLabel=[ZCControl createLabelWithFrame:CGRectMake(120,10, 130, 30) Font:10 Text:nil];
    [self addSubview:idefineLabel];
    imageV=[ZCControl createImageViewWithFrame:CGRectMake(5,15,20,20) ImageName:@"选中"];
    imageV.hidden=YES;
    [self addSubview:imageV];
}
-(void)config:(NSMutableArray*)dataArr and:(NSMutableArray*)isconnectArr and:(int)index{
    
    
    idefineLabel.text=dataArr[index];
    if ([isconnectArr[index]isEqualToString:@"1"]) {
        imageV.hidden=NO;
    }else{
        imageV.hidden=YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
