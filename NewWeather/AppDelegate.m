//
//  AppDelegate.m
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherParser.h"
#import "LoadingViewController.h"
#import "LoadErrorViewController.h"

@interface AppDelegate () <WeatherLoadingProtocol>

-(void) weatherLoaded: (Weather *) weather;

@end

@implementation AppDelegate
{
    UIWindow * _window;
    ForecastViewController * _ctrl;
    UINavigationController * _naviCtrl;
    
    BOOL _loaded;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    LoadingViewController * loadingCtrl = [[[LoadingViewController alloc] initWithNibName: @"LoadingViewController" bundle: [NSBundle mainBundle]] autorelease];
    self.window.rootViewController = loadingCtrl;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    _loaded = false;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(didLoadWeatherSucceded:) name: @"Weather.loaded" object: nil];
    
    [Weather loadWeatherFromUrl: [NSURL URLWithString: @"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"] thenCallback:self];
    
    //Forecast * forecast = [Forecast sample];
    //WeatherParser * parser = [[[WeatherParser alloc] init] autorelease];
    
    //Forecast * forecast = [parser parseForecastFromFile: @"/Users/OlgaVyrostko/Documents/WorkMaterials/DevelopmentIOS/NewWeather/NewWeather/Forecast.xml"];
    
    //self.ctrl.forecast = forecast;
    //self.ctrl.times = forecast.times;
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - WeatherLoadingProtocol

-(void) didLoadWeatherSucceded: (NSNotification *) ntf
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([ntf.userInfo objectForKey: @"weather"] == nil)
    {
        [self didLoadWeatherFailed: [NSError errorWithDomain: @"Not loaded" code: 0 userInfo: nil]];
        return;
    }
    
    @try
    {
        Weather * weather = [ntf.userInfo objectForKey: @"weather"];
        NSLog(@"Load succeded %@", weather);
    
        self.ctrl = [[[ForecastViewController alloc] initWithNibName: @"ForecastViewController" bundle: [NSBundle mainBundle]] autorelease];
        self.naviCtrl = [[[UINavigationController alloc] initWithRootViewController: self.ctrl] autorelease];
        self.ctrl.forecast = weather.forecast;
        self.ctrl.times = [NSArray arrayWithArray: weather.forecast.times];
        self.window.rootViewController = self.naviCtrl;
        
        _loaded = true;
    }
    @catch (NSException *e)
    {
        [self didLoadWeatherFailed: [NSError errorWithDomain: e.description code: 0 userInfo: nil]];
    }
}

-(void) didLoadWeatherFailed:(NSError *)error
{
    NSLog(@"Load failed!");
    if (!_loaded)
    {
        LoadErrorViewController * errorCtrl = [[[LoadErrorViewController alloc] initWithNibName: @"LoadErrorViewController" bundle: [NSBundle mainBundle]] autorelease];
        errorCtrl.delegate = self;
        self.window.rootViewController = errorCtrl;
    }
}

-(void) weatherLoaded:(Weather *)weather
{
    NSLog(@"Weather loaded %@", weather);
}

-(void) restartLoading
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [Weather loadWeatherFromUrl: [NSURL URLWithString: @"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"] thenCallback:self];
}

@end
