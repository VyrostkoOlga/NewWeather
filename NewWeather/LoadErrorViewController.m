//
//  LoadErrorViewController.m
//  NewWeather
//
//  Created by Ольга Выростко on 23.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "LoadErrorViewController.h"

@interface LoadErrorViewController ()

@end

@implementation LoadErrorViewController
{
    UILabel * _mainTitle;
    UIButton * _restast;
    UIImageView * _image;
    
    id <WeatherLoadingProtocol> _delegate;
}

@synthesize mainTitle=_mainTitle;
@synthesize restart=_restast;
@synthesize delegate=_delegate;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self != nil)
    {
        //TODO
    }
    return self;
}

-(void) dealloc
{
    [_mainTitle release];
    [_restast release];
    [_image release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTitle.text = @"Loading failed";
    [_restast addTarget: _delegate action: @selector(restartLoading) forControlEvents:UIControlEventTouchUpInside];
    NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"LoadingImage" ofType: @"gif" ];
    _image.image = [UIImage imageWithContentsOfFile: path];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
