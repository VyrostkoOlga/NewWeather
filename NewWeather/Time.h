//
//  Time.h
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlBase.h"

@interface Time : NSObject

@property (nonatomic, retain) NSDate * from;
@property (nonatomic, retain) NSDate * to;
@property (nonatomic, retain) NSDictionary * rain;
@property (nonatomic, retain) NSDictionary * humidity;
@property (nonatomic, retain) NSDictionary * temperature;
@property (nonatomic, retain) NSDictionary * wind;
@property (nonatomic, retain) NSDictionary * pressure;
@property (nonatomic, retain) NSDictionary * clouds;
@property (nonatomic, retain) NSURL * symbol;
@property (nonatomic, retain, readonly) UrlBase * base;
@property (nonatomic, retain, readonly) NSDateFormatter * dateFmt;

+(Time *) sample;
-(NSString *) description;
-(NSString *) present;
-(id) initWithTime: (Time *) time;

@end
