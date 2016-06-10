//
//  ParsingOperation.h
//  NewWeather
//
//  Created by Ольга Выростко on 28.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherParser.h"

@class Weather;
@class WeatherParser;
@protocol WeatherLoadingProtocol;

@interface ParsingOperation : NSOperation

@property (nonatomic, retain) Weather * weather;

-(id) initWithLoader: (id) loader Parser: (WeatherParser *) parser andData: (NSString *) data;
@end
