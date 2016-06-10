//
//  WeatherParser.h
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@class Weather;

@interface WeatherParser : NSObject

-(Time *) parseTimeFromFile: (NSString *) filename;
-(Forecast *) parseForecastFromFile: (NSString *) filename;
-(Weather *) parseWeatherFromFile: (NSString *) filename;
-(Weather *) parseWeatherFromData: (NSString *) data;

@end
