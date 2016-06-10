//
//  Forecast.h
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface Forecast : NSObject

@property (nonatomic, retain) NSDate * from;
@property (nonatomic, retain) NSDate * to;
@property (nonatomic, retain) NSDate * sunrise;
@property (nonatomic, retain) NSDate * sunset;

@property (nonatomic, retain) NSArray * times;

-(NSString *) description;
+(Forecast *) sample;

@end
