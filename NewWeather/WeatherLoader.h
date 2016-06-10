//
//  WeatherLoader.h
//  NewWeather
//
//  Created by Ольга Выростко on 20.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherParser.h"
#import "ParsingOperation.h"

@class Weather;

@protocol WeatherParsingProtocol

-(void) notify: (Weather *) weather;

@end

@interface WeatherLoader : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate, WeatherParsingProtocol>

-( id ) initWithURL: ( NSURL* )url thenCallTarget: ( id )target withSelector: ( SEL )selector;

@end
