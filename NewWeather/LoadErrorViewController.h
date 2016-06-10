//
//  LoadErrorViewController.h
//  NewWeather
//
//  Created by Ольга Выростко on 23.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoadErrorViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel * mainTitle;
@property (nonatomic, retain) IBOutlet UIButton * restart;
@property (nonatomic, retain) IBOutlet UIImageView * image;

@property (nonatomic, retain) id <WeatherLoadingProtocol> delegate;

@end
