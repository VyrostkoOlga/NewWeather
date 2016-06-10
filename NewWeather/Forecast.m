//
//  Forecast.m
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast
{
    NSDate * _from;
    NSDate * _to;
    NSDate * _sunrise;
    NSDate * _sunset;
    
    NSDateFormatter * _dateFmt;
    NSArray * _times;
}

@synthesize from=_from;
@synthesize to=_to;
@synthesize sunrise=_sunrise;
@synthesize sunset=_sunset;
@synthesize times=_times;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        _dateFmt = [[[NSDateFormatter alloc] init] autorelease];
        [_dateFmt setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

-(NSString *) description
{
    NSMutableString * str = [NSMutableString string];
    
    [str appendFormat: @"\nfrom: %@\n", [_dateFmt stringFromDate: _from]];
    [str appendFormat: @"to: %@\n", [_dateFmt stringFromDate: _to]];

    for (Time * time in _times)
    {
        [str appendFormat: @"%@: %@\n", time.from, [time.rain objectForKey: @"type"]];
    }
    
    return [NSString stringWithString: str];
}

+(Forecast *) sample
{
    Forecast * forecast = [[[Forecast alloc] init] autorelease];
    NSDateFormatter * dateFmt = [[[NSDateFormatter alloc] init] autorelease];
    [dateFmt setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSNumberFormatter * numFmt = [[[NSNumberFormatter alloc] init] autorelease];
    [ numFmt setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [ numFmt setNumberStyle: NSNumberFormatterDecimalStyle];
    
    forecast.from = [dateFmt dateFromString: @"2014-10-13 02:26:51"];
    forecast.to = [dateFmt dateFromString: @"2014-10-14 00:00:00"];
    forecast.sunrise = [dateFmt dateFromString: @"2014-10-13 02:26:51"];
    forecast.sunset = [dateFmt dateFromString: @"2014-10-13 13:00:36"];
    UrlBase * base = [[[UrlBase alloc] init] autorelease];
    
    NSMutableArray * array = [NSMutableArray array];
    [array addObject: [Time sample]];
    
    Time * second = [[[Time alloc] init] autorelease];
    second.from = [dateFmt dateFromString: @"2014-10-13 18:00:00" ];
    second.to = [ dateFmt dateFromString: @"2014-10-13 21:00:00"];
    second.rain = [NSDictionary dictionaryWithObjects: [ NSArray arrayWithObjects: @"light rain", @"10n", nil] forKeys: [NSArray arrayWithObjects: @"type", @"number", nil]];
    second.wind = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"West-southwest", [ numFmt numberFromString: @"237.5" ], [ numFmt numberFromString: @"1.31"], @"calm", nil] forKeys: [NSArray arrayWithObjects: @"direction", @"deg", @"mps", @"type", nil]];
    second.temperature = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"celcius", [ numFmt numberFromString: @"-0.54999999999995" ], [ numFmt numberFromString: @"-0.54999999999995" ], [ numFmt numberFromString: @"3.134" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"min", @"max", nil]];
    second.pressure = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"hPa", [ numFmt numberFromString: @"984.43" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    second.humidity = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"%", [ numFmt numberFromString: @"94" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    second.clouds = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"overcast clouds", [numFmt numberFromString: @"92"], @"%", nil] forKeys: [NSArray arrayWithObjects: @"type", @"value", @"unit", nil]];
    second.symbol = [ base getUrlForCode: @"500" ];
    [array addObject: second];
    
    Time * third = [[[Time alloc] init] autorelease];
    third.from = [dateFmt dateFromString: @"2014-10-13 21:00:00" ];
    third.to = [ dateFmt dateFromString: @"2014-10-14 00:00:00"];
    third.rain = [NSDictionary dictionaryWithObjects: [ NSArray arrayWithObjects: @"light rain", @"10n", nil] forKeys: [NSArray arrayWithObjects: @"type", @"number", nil]];
    third.wind = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"South-southwest", [ numFmt numberFromString: @"155.5" ], [ numFmt numberFromString: @"1.46"], @"calm", nil] forKeys: [NSArray arrayWithObjects: @"direction", @"deg", @"mps", @"type", nil]];
    third.temperature = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"celcius", [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"2.654" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"min", @"max", nil]];
    third.pressure = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"hPa", [ numFmt numberFromString: @"981.63" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.humidity = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"%", [ numFmt numberFromString: @"95" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.clouds = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"overcast clouds", [numFmt numberFromString: @"92"], @"%", nil] forKeys: [NSArray arrayWithObjects: @"type", @"value", @"unit", nil]];
    third.symbol = [ base getUrlForCode: @"500" ];
    [array addObject: third];
    
    third = [[[Time alloc] init] autorelease];
    third.from = [dateFmt dateFromString: @"2014-10-13 21:00:00" ];
    third.to = [ dateFmt dateFromString: @"2014-10-14 00:00:00"];
    third.rain = [NSDictionary dictionaryWithObjects: [ NSArray arrayWithObjects: @"light rain", @"10n", nil] forKeys: [NSArray arrayWithObjects: @"type", @"number", nil]];
    third.wind = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"South-southwest", [ numFmt numberFromString: @"155.5" ], [ numFmt numberFromString: @"1.46"], @"calm", nil] forKeys: [NSArray arrayWithObjects: @"direction", @"deg", @"mps", @"type", nil]];
    third.temperature = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"celcius", [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"2.654" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"min", @"max", nil]];
    third.pressure = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"hPa", [ numFmt numberFromString: @"981.63" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.humidity = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"%", [ numFmt numberFromString: @"95" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.clouds = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"overcast clouds", [numFmt numberFromString: @"92"], @"%", nil] forKeys: [NSArray arrayWithObjects: @"type", @"value", @"unit", nil]];
    third.symbol = [ base getUrlForCode: @"500" ];
    [array addObject: third];
    
    third = [[[Time alloc] init] autorelease];
    third.from = [dateFmt dateFromString: @"2014-10-13 21:00:00" ];
    third.to = [ dateFmt dateFromString: @"2014-10-14 00:00:00"];
    third.rain = [NSDictionary dictionaryWithObjects: [ NSArray arrayWithObjects: @"light rain", @"10n", nil] forKeys: [NSArray arrayWithObjects: @"type", @"number", nil]];
    third.wind = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"South-southwest", [ numFmt numberFromString: @"155.5" ], [ numFmt numberFromString: @"1.46"], @"calm", nil] forKeys: [NSArray arrayWithObjects: @"direction", @"deg", @"mps", @"type", nil]];
    third.temperature = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"celcius", [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"2.654" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"min", @"max", nil]];
    third.pressure = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"hPa", [ numFmt numberFromString: @"981.63" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.humidity = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"%", [ numFmt numberFromString: @"95" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.clouds = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"overcast clouds", [numFmt numberFromString: @"92"], @"%", nil] forKeys: [NSArray arrayWithObjects: @"type", @"value", @"unit", nil]];
    third.symbol = [ base getUrlForCode: @"500" ];
    [array addObject: third];
    
    third = [[[Time alloc] init] autorelease];
    third.from = [dateFmt dateFromString: @"2014-10-13 21:00:00" ];
    third.to = [ dateFmt dateFromString: @"2014-10-14 00:00:00"];
    third.rain = [NSDictionary dictionaryWithObjects: [ NSArray arrayWithObjects: @"light rain", @"10n", nil] forKeys: [NSArray arrayWithObjects: @"type", @"number", nil]];
    third.wind = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"South-southwest", [ numFmt numberFromString: @"155.5" ], [ numFmt numberFromString: @"1.46"], @"calm", nil] forKeys: [NSArray arrayWithObjects: @"direction", @"deg", @"mps", @"type", nil]];
    third.temperature = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"celcius", [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"-0.83999999999997" ], [ numFmt numberFromString: @"2.654" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"min", @"max", nil]];
    third.pressure = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"hPa", [ numFmt numberFromString: @"981.63" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.humidity = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"%", [ numFmt numberFromString: @"95" ], nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    third.clouds = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"overcast clouds", [numFmt numberFromString: @"92"], @"%", nil] forKeys: [NSArray arrayWithObjects: @"type", @"value", @"unit", nil]];
    third.symbol = [ base getUrlForCode: @"500" ];
    [array addObject: third];
    
    forecast.times = [NSArray arrayWithArray: array];
    return forecast;
}

@end
