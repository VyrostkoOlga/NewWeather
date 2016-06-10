//
//  WeatherLoader.m
//  NewWeather
//
//  Created by Ольга Выростко on 20.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "WeatherLoader.h"

@interface WeatherLoader( ) <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSURLConnection * _connection;
    NSMutableData * _gotData;
    NSString * _data;
    
    id _target;
    SEL _callback;
}

@end

@implementation WeatherLoader


-( id ) initWithURL: ( NSURL* )url thenCallTarget: ( id )target withSelector: ( SEL )selector
{
    self = [super init];
    if (self != nil)
    {
        _gotData = [ [ NSMutableData alloc ] init ];
        _target = target;
        _callback = selector;
            
        NSMutableURLRequest* req = [ [ [ NSMutableURLRequest alloc ] initWithURL: url ] autorelease ];
        [ req setHTTPMethod: @"GET" ];
        [ req setCachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData ];
        
        _connection = [ [ NSURLConnection connectionWithRequest: req delegate: self ] retain ];
    }
    return self;
}

-(void) dealloc
{
    [_connection release];
    [_gotData release];
    
    [super dealloc];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    return [_gotData setLength: 0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_gotData appendData:data];
}

-( void ) connectionDidFinishLoading: ( NSURLConnection* )connection
{
    _data = [[[NSString alloc] initWithData: _gotData encoding: NSUTF8StringEncoding] autorelease];
    WeatherParser* parser = [ [ [ WeatherParser alloc ] init ] autorelease ];
    ParsingOperation * op = [[[ParsingOperation alloc] initWithLoader: self Parser: parser andData: _data] autorelease];
    NSOperationQueue * q = [[[NSOperationQueue alloc] init] autorelease];
    [q addOperation: op];
    
    [ self autorelease ];
}

-(void) notify: (Weather *) weather
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"Weather.loaded" object: self userInfo: [NSDictionary dictionaryWithObject: weather forKey: @"weather" ] ];
}

#pragma mark - NSURLConnectionDelegate

-( void ) connection: ( NSURLConnection* )connection didFailWithError: ( NSError* )error
{
    [ _target performSelector: _callback withObject: error ];
    [ self autorelease ];
}

@end