//
//  UrlBase.h
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlBase : NSObject

@property (nonatomic, retain, readonly) NSDictionary * base;

-(NSURL *) getUrlForCode: (NSString *) code;

@end
