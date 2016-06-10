//
//  ForecastViewController.h
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Forecast.h"
#import "DetailViewController.h"
#import "TimeCellTableViewCell.h"

@interface ForecastViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) Forecast * forecast;
@property (nonatomic, retain) NSArray * times;
@property (nonatomic, retain) IBOutlet UITableView * tbl;
@property (nonatomic, retain) NSDate * updateTime;

@end
