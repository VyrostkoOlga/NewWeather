//
//  Weather.h
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"
#import "WeatherLoader.h"

@class Weather;

@protocol WeatherLoadingProtocol

-(void) didLoadWeatherSucceded: (Weather *) weather;
-(void) didLoadWeatherFailed: (NSError *) error;
-(void) restartLoading;

@end

@interface Weather : NSObject

@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * country;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;

@property (nonatomic, retain) Forecast * forecast;

-(NSString *) description;
+(Weather *) sample;
+(void) loadWeatherFromUrl: (NSURL *) url thenCallback: (id <WeatherLoadingProtocol>) target;
@end
