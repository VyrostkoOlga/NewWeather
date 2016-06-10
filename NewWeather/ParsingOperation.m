//
//  ParsingOperation.m
//  NewWeather
//
//  Created by Ольга Выростко on 28.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "ParsingOperation.h"

@implementation ParsingOperation
{
    Weather * _weather;
    WeatherParser * _parser;
    id _loader;
    NSString * _data;
}

@synthesize weather=_weather;

-(id) initWithLoader: (id) loader Parser:(WeatherParser *)parser andData:(NSString *)data
{
    self = [super init];
    if (self != nil)
    {
        _parser = [parser retain];
        _data = [data copy];
        _loader = [loader retain];
    }
    return self;
}

-(void) dealloc
{
    [_weather release];
    [_parser release];
    [_data release];
    [_loader release];
    
    [super dealloc];
}

-(void) main
{
    Weather * weather = [_parser parseWeatherFromData: [NSString stringWithString: _data]];
    NSLog(@"%@", weather);
    [_loader performSelectorOnMainThread: @selector(notify:) withObject: weather waitUntilDone: NO];
}

@end
