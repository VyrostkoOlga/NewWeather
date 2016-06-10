//
//  TimeCellTableViewCell.h
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeCellTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel * from;
@property (nonatomic, retain) IBOutlet UILabel * to;
@property (nonatomic, retain) IBOutlet UIImageView * symbol;
@property (nonatomic, retain) IBOutlet UILabel * desc;

@end
