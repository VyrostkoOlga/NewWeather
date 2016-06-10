//
//  Weather.m
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "Weather.h"

@implementation Weather
{
    NSString * _country;
    NSString * _city;
    NSNumber * _longitude;
    NSNumber * _latitude;
    
    Forecast * _forecast;
}

@synthesize country=_country;
@synthesize city=_city;
@synthesize longitude=_longitude;
@synthesize latitude=_latitude;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //TODO
    }
    return self;
}

-(void) dealloc
{
    [_country release];
    [_city release];
    [_latitude release];
    [_longitude release];
    
    [super dealloc];
}

-(NSString *) description
{
    NSMutableString * str = [NSMutableString string];
    
    [str appendFormat: @"\ncity: %@\n", _city];
    [str appendFormat: @"country: %@\n", _country];
    
    [str appendFormat: @"%@", _forecast];
    
    return [NSString stringWithString: str];
}

+(Weather *) sample
{
    NSNumberFormatter * fmt = [[[NSNumberFormatter alloc] init] autorelease];
    [ fmt setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [ fmt setNumberStyle: NSNumberFormatterDecimalStyle];
    
    Weather * weather = [[[Weather alloc] init] autorelease];
    weather.city = @"Yekaterinburg";
    weather.country = @"RU";
    weather.latitude = [fmt numberFromString: @"56.857498" ];
    weather.longitude = [fmt numberFromString: @"60.612499"];
    
    weather.forecast = [Forecast sample];
    
    return weather;
}

+(void) loadWeatherFromUrl:(NSURL *)url thenCallback:(id<WeatherLoadingProtocol>)target
{
    WeatherLoader * loader = [[WeatherLoader alloc] initWithURL: url thenCallTarget: target withSelector: @selector( didLoadWeatherSucceded: )];
    NSLog(@"%@", loader);
}

@end
