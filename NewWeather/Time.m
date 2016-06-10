//
//  Time.m
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "Time.h"

@implementation Time
{
    NSDate * _from;
    NSDate * _to;
    NSDictionary * _rain;
    NSDictionary * _temperature;
    NSDictionary * _wind;
    NSDictionary * _pressure;
    NSDictionary * _humidity;
    NSDictionary * _clouds;
    NSURL * _url;
    
    UrlBase * _urlbase;
    NSNumberFormatter * _numFmt;
    NSDateFormatter * _dateFmt;
}

@synthesize from=_from;
@synthesize to=_to;
@synthesize rain=_rain;
@synthesize temperature=_temperature;
@synthesize wind=_wind;
@synthesize pressure=_pressure;
@synthesize humidity=_humidity;
@synthesize symbol=_url;
@synthesize clouds=_clouds;
@synthesize base=_base;
@synthesize dateFmt=_dateFmt;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //Initialize baseOfSymbolUrls
        _urlbase = [[UrlBase alloc] init];
        
       //Initialize formatters
        _dateFmt = [[NSDateFormatter alloc] init];
        [_dateFmt setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        _numFmt = [[[NSNumberFormatter alloc] init] autorelease];
        [ _numFmt setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [ _numFmt setNumberStyle: NSNumberFormatterDecimalStyle];
    }
    return self;
}

-(id) initWithTime: (Time *) time
{
    self = [self init ];
    if (self != nil)
    {
        _from = [time.from copy];
        _to = [time.to copy];
        _rain = [time.rain copy];
        _wind = [time.wind copy];
        _pressure = [time.pressure copy];
        _humidity = [time.humidity copy];
        _temperature = [time.temperature copy];
        _humidity = [time.humidity copy];
        _url = [time.symbol copy];
    }
    return self;
}

-(void) dealloc
{
    [_from release];
    [_to release];
    [_rain release];
    [_wind release];
    [_temperature release];
    [_humidity release];
    [_pressure release];
    [_url release];
    [_dateFmt release];
    
    [super dealloc];
}

-(NSString *) description
{
    NSMutableString * str = [NSMutableString string];
    
    [str appendFormat: @"from: %@\n", [_dateFmt stringFromDate: _from]];
    [str appendFormat: @"to: %@\n", [_dateFmt stringFromDate: _to]];
    [str appendFormat: @"rain: %@\n", [_rain objectForKey: @"type"]];
    [str appendFormat: @"temperature: %@", [ _numFmt stringFromNumber: [_temperature objectForKey: @"value"]]];
    
    return [NSString stringWithString: str];
}

-(NSString *) present
{
    NSMutableString * str = [NSMutableString string];
    
    [str appendFormat: @"from: %@\n", [_dateFmt stringFromDate: _from]];
    [str appendFormat: @"to: %@\n", [_dateFmt stringFromDate: _to]];
    [str appendFormat: @"rain: %@\n", [_rain objectForKey: @"type"]];
    [str appendFormat: @"temperature: %@", [ _numFmt stringFromNumber: [_temperature objectForKey: @"value"]]];
    
    return [NSString stringWithString: str];
}

+(Time*) sample
{
    NSDateFormatter * dateFmt = [[[NSDateFormatter alloc] init] autorelease];
    [dateFmt setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSNumberFormatter * numFmt = [[[NSNumberFormatter alloc] init] autorelease];
    [ numFmt setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [ numFmt setNumberStyle: NSNumberFormatterDecimalStyle];
    
    UrlBase * base = [[[UrlBase alloc] init] autorelease];
    
    Time * time = [[[Time alloc] init] autorelease];
    time.from = [dateFmt dateFromString: @"2014-10-13 15:00:00"];
    time.to = [dateFmt dateFromString: @"2014-10-13 18:00:00"];
    
    time.rain = [NSDictionary dictionaryWithObjects: [ NSArray arrayWithObjects: @"broken clouds", @"04n", nil] forKeys: [NSArray arrayWithObjects: @"type", @"number", nil]];
    
    time.wind = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"West", [ numFmt numberFromString: @"275.004" ], [ numFmt numberFromString: @"2.3"], @"light breese", nil] forKeys: [NSArray arrayWithObjects: @"direction", @"deg", @"mps", @"type", nil]];

    
    time.temperature = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"celcius", [ numFmt numberFromString: @"1" ], [ numFmt numberFromString: @"1" ], [ numFmt numberFromString: @"4.887" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"min", @"max", nil]];

    time.pressure = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"hPa", [ numFmt numberFromString: @"985.9" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    
    time.humidity = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"%", [ numFmt numberFromString: @"93" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    
    time.clouds = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"broken clouds", [numFmt numberFromString: @"80"], @"%", nil] forKeys: [NSArray arrayWithObjects: @"type", @"value", @"unit", nil]];

    time.symbol = [ base getUrlForCode: @"803" ];
    
    return time;
    
}

@end
