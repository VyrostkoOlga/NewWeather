//
//  WeatherParser.m
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "WeatherParser.h"
#import "UrlBase.h"

@implementation WeatherParser
{
    NSDateFormatter * _dateFmt;
    NSNumberFormatter * _numFmt;
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        _dateFmt = [[[NSDateFormatter alloc] init] retain];
        [_dateFmt setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        _numFmt = [[[NSNumberFormatter alloc] init] retain];
        [ _numFmt setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [ _numFmt setNumberStyle: NSNumberFormatterDecimalStyle];
    }
    return self;
}

-(void) dealloc
{
    [_numFmt release];
    [_dateFmt release];
    
    [super dealloc];
}

-(void) didLoadFromFileSuccess
{
    NSLog(@"Load from file successed");
}

-(void) didLoadFromFileFailed: (NSError *) error
{
    NSLog(@"Load from file failed");
    NSLog(@"Errors: %@", error);
}

-(NSString *) readFromFile: (NSString *) filename
{
    if ( ! [ [ NSFileManager defaultManager ] fileExistsAtPath: filename ] )
        return [NSString string];
    
    NSString* data = [ NSString stringWithContentsOfFile: filename encoding: NSUTF8StringEncoding error: nil ];
    
    if ( nil == filename )
        return [NSString string];
    
    return data;
}

-(NSDate *) dateFromString: (NSString *) text
{
    NSArray * dateComps = [text componentsSeparatedByString: @"T"];
    if ([dateComps count] < 2)
        return [NSDate date];
    
    NSString * newText = [NSString stringWithFormat: @"%@ %@", [dateComps objectAtIndex: 0], [dateComps objectAtIndex: 1]];
    
    NSDate * date = [_dateFmt dateFromString: newText];
    
    return date;
}

-(NSString *) workWithPattern: (NSString *) pattern inText: (NSString *) text
{
    NSTextCheckingResult * match = [ [NSRegularExpression regularExpressionWithPattern: pattern options: 0 error: nil] firstMatchInString: text options: 0 range: NSMakeRange(0, [text length])];
    if ( match == nil)
    {
        NSLog(@"%@", text);
        [self didLoadFromFileFailed: [NSError errorWithDomain: @"Parse error" code: 0 userInfo: nil]];
        return @"nil";
    }
    NSRange matchRange = [match rangeAtIndex:1];
    NSString * matchString = [text substringWithRange:matchRange];
    return matchString;
}

-(NSString *) parseTag: (NSString *) tag inText: (NSString *) text
{
    NSString * pattern = [NSString stringWithFormat: @"<%@>(.+?)</%@>", tag, tag];
    return [self workWithPattern: pattern inText: text];
}

-(NSString *) parseOpenTag: (NSString *) tag inText: (NSString *) text
{
    NSString * pattern = [NSString stringWithFormat: @"<%@(.+?)/>", tag];
    return [self workWithPattern: pattern inText: text];
}

-(NSString *) parseTitle: (NSString *) title inText: (NSString *) text
{
    NSString * pattern = [NSString stringWithFormat: @"%@=\"(.+?)\"", title];
    return [self workWithPattern: pattern inText: text];
}

-(Time *) parseTimeFromFile:(NSString *)filename
{
    NSString * data = [self readFromFile: filename];
    Time * time = [self parseTimeFromData: data];
    
    return time;
}

-(Time *) parseTimeFromData: (NSString *) data
{
    Time * time = [[[Time alloc] init] autorelease];
    UrlBase * base = [[[UrlBase alloc] init] autorelease];
    
    time.from = [self dateFromString: [self parseTitle: @"from" inText: data ]];
    time.to = [self dateFromString: [self parseTitle: @"to" inText: data ]];
    
    NSString * curTag;
    
    curTag = [NSString stringWithString: [self parseOpenTag: @"symbol" inText: data]];
    NSString * name = [NSString stringWithString: [self parseTitle: @"name" inText: curTag]];
    NSString * number = [ NSString stringWithString: [self parseTitle: @"var" inText: curTag]];
    time.rain = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: name, number, nil] forKeys: [NSArray arrayWithObjects: @"type", @"number", nil]];
    time.symbol = [base getUrlForCode: [self parseTitle: @"number" inText: curTag]];

    curTag = [NSString stringWithString: [self parseOpenTag: @"windDirection" inText: data]];
    name = [NSString stringWithString: [self parseTitle: @"name" inText: curTag]];
    number = [ NSString stringWithString: [self parseTitle: @"deg" inText: curTag]];
    curTag = [NSString stringWithString: [self parseOpenTag: @"windSpeed" inText: data]];
    NSNumber * mps = [_numFmt numberFromString: [NSString stringWithString: [self parseTitle: @"mps" inText: curTag]]];
    NSString * typeSpeed = [NSString stringWithString: [self parseTitle: @"name" inText: curTag]];
    time.wind = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: name, number, mps, typeSpeed, nil] forKeys: [NSArray arrayWithObjects: @"direction", @"deg", @"mps", @"type", nil]];
    
    curTag = [NSString stringWithString: [self parseOpenTag: @"temperature" inText: data]];
    NSString * unit = [NSString stringWithString: [self parseTitle: @"unit" inText: curTag]];
    NSNumber * value = [_numFmt numberFromString: [NSString stringWithString: [self parseTitle: @"value" inText: curTag]]];
    NSNumber * max = [_numFmt numberFromString: [NSString stringWithString: [self parseTitle: @"max" inText: curTag]]];
    NSNumber * min = [_numFmt numberFromString: [NSString stringWithString: [self parseTitle: @"min" inText: curTag]]];
    time.temperature = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: unit, value, min, max, nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"min", @"max", nil]];
    
    curTag = [NSString stringWithString: [self parseOpenTag: @"pressure" inText: data]];
    unit = [NSString stringWithString: [self parseTitle: @"unit" inText: curTag]];
    value =  [_numFmt numberFromString: [ NSString stringWithString: [self parseTitle: @"value" inText: curTag]]];
    time.pressure = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: unit, value, nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    
    curTag = [NSString stringWithString: [self parseOpenTag: @"humidity" inText: data]];
    unit = [NSString stringWithString: [self parseTitle: @"unit" inText: curTag]];
    value =  [_numFmt numberFromString: [ NSString stringWithString: [self parseTitle: @"value" inText: curTag]]];
    time.humidity = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: unit, value, nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", nil]];
    
    curTag = [NSString stringWithString: [self parseOpenTag: @"clouds" inText: data]];
    unit = [NSString stringWithString: [self parseTitle: @"unit" inText: curTag]];
    value =  [_numFmt numberFromString: [ NSString stringWithString: [self parseTitle: @"all" inText: curTag]]];
    name = [NSString stringWithString: [self parseTitle: @"value" inText: curTag]];
    time.clouds = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: unit, value, name, nil] forKeys: [NSArray arrayWithObjects: @"unit", @"value", @"type", nil]];
    
    return time;
}

-(Forecast *) parseForecastFromFile: (NSString *) filename
{
    NSString * data = [self readFromFile: filename];
    Forecast* forecast = [self parseForecastFromData: data];
    
    return forecast;
}

-(Forecast *) parseForecastFromData: (NSString *) data
{
    Forecast * forecast = [[[Forecast alloc] init] autorelease];
    NSArray * temp = [NSArray arrayWithArray: [data componentsSeparatedByString: @"<forecast>"]];
    NSString * baseInfo = [NSString stringWithString: [temp objectAtIndex: 0]];
    forecast.sunrise = [self dateFromString: [self parseTitle: @"rise" inText: baseInfo]];
    forecast.sunset = [self dateFromString: [self parseTitle: @"set" inText: baseInfo]];
    
    NSString * newData = [NSString stringWithString: [temp objectAtIndex: 1]];
    NSArray * times = [NSArray arrayWithArray: [newData componentsSeparatedByString: @"<time"]];
    
    NSMutableArray * timeArray = [NSMutableArray array];
    
    NSLog(@"%lu", (unsigned long)[times count]);
    
    for (int i=1; i<[times count] - 1; i++)
    {
        NSString * time = [NSString stringWithString: [times objectAtIndex: i]];
        Time * tempTime = [[[Time alloc] initWithTime: [self parseTimeFromData: time]] autorelease];
        if (tempTime != nil)
            [timeArray addObject: tempTime];
    }
    
    forecast.times = [NSArray arrayWithArray: timeArray];
    forecast.from = [[forecast.times objectAtIndex: 0] from];
    forecast.to = [[forecast.times objectAtIndex: [forecast.times count] - 1] to];
    return forecast;
}

-(Weather *) parseWeatherFromFile:(NSString *)filename
{
    NSString * data = [NSString stringWithString: [self readFromFile: filename]];
    Weather * weather = [self parseWeatherFromData: data];
    
    return weather;
}

-(Weather *) parseWeatherFromData:(NSString *) data
{
    Weather * weather = [[[Weather alloc] init] autorelease];
    
    weather.city = [NSString stringWithString: [self parseTag: @"name" inText: data]];
    weather.country = [NSString stringWithString: [self parseTag: @"country" inText: data]];
    
    NSString * koord = [NSString stringWithString: [self parseOpenTag: @"location"  inText: data]];
    NSLog(@"%@", koord);
    weather.longitude = [_numFmt numberFromString: [self parseTitle: @"longitude" inText: koord]];
    weather.latitude = [_numFmt numberFromString: [self parseTitle: @"latitude" inText: koord]];
    
    Forecast * forecast = [self parseForecastFromData: data];
    weather.forecast = forecast;
    
    return weather;
}

@end


