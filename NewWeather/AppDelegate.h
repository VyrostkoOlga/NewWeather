//
//  AppDelegate.h
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
#import "ForecastViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) ForecastViewController * ctrl;
@property (nonatomic, retain) UINavigationController * naviCtrl;


@end

