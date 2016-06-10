//
//  TimeCellTableViewCell.m
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "TimeCellTableViewCell.h"

@implementation TimeCellTableViewCell
{
    UILabel * _from;
    UILabel * _to;
    UIImageView * _symbol;
    UILabel * _desc;
}

@synthesize from=_from;
@synthesize to=_to;
@synthesize symbol=_symbol;
@synthesize desc=_desc;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    return self;
}

-(void) dealloc
{
    [_from release];
    [_to release];
    [_symbol release];
    [_desc release];
    
    [super dealloc];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
