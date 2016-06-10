//
//  UrlBase.m
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "UrlBase.h"

@implementation UrlBase
{
    NSDictionary * _base;
}

@synthesize base=_base;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        NSArray * objects = [NSArray arrayWithObjects:
                              @"11d.png", @"11d.png", @"11d.png", @"11d.png", @"11d.png",
                              @"11d.png", @"11d.png", @"11d.png", @"11d.png", @"11d.png",
                              @"09d.png", @"09d.png", @"09d.png", @"09d.png", @"09d.png",
                              @"09d.png", @"09d.png", @"09d.png", @"09d.png", @"09d.png",
                              @"10d.png", @"10d.png", @"10d.png", @"10d.png", @"10d.png",
                              @"13d.png", @"09d.png", @"09d.png", @"09d.png", @"09d.png",
                              @"13d.png", @"13d.png", @"13d.png", @"13d.png", @"13d.png",
                              @"13d.png", @"13d.png", @"13d.png", @"13d.png", @"13d.png",
                              @"50d.png", @"50d.png", @"50d.png", @"50d.png", @"50d.png",
                              @"50d.png", @"50d.png", @"50d.png", @"50d.png", @"50d.png",
                              @"01n.png", @"02n.png", @"03d.png", @"03d.png", @"04d.png", nil];
        NSArray * keys = [NSArray arrayWithObjects:
                           @"200", @"201",@"202", @"210", @"211", @"212", @"221",
                           @"230", @"231", @"232", @"300", @"301", @"302", @"310",
                           @"311", @"312", @"313", @"314", @"321", @"500", @"501",
                           @"502", @"503", @"504", @"511", @"520", @"521", @"522",
                           @"531", @"600", @"601", @"602", @"611", @"612", @"615",
                           @"616", @"620", @"621", @"622", @"701", @"711", @"721",
                           @"731", @"731", @"741", @"751", @"761", @"762", @"771",
                           @"781", @"800", @"801", @"802", @"803", @"804", nil];
        
        _base = [NSDictionary dictionaryWithObjects: objects forKeys: keys];
    }
    return self;
}

-(NSURL *) getUrlForCode:(NSString *)code
{
    NSString * part = [_base objectForKey: code];
    if (part == nil)
        return nil;
    
    NSString * urlStr = [NSString stringWithFormat: @"http://openweathermap.org/img/w/%@", part];
    return [NSURL URLWithString: urlStr ];
}
@end
