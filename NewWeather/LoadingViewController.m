//
//  LoadingViewController.m
//  NewWeather
//
//  Created by Ольга Выростко on 20.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController
{
    UILabel * _status;
    UIActivityIndicatorView * _statusBar;
    UIImageView * _loadImage;
    UIImageView * _frameImage;
}

@synthesize status=_status;
@synthesize statusBar=_statusBar;
@synthesize loadImage=_loadImage;
@synthesize frameImage=_frameImage;

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
    [_status release];
    [_statusBar release];
    [_loadImage release];
    [_frameImage release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _status.text = @"Loading...";
    [_statusBar startAnimating ];
    NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"LoadingImage" ofType: @"gif" ];
    _loadImage.image = [UIImage imageWithContentsOfFile: path];
    
    path = [ [ NSBundle mainBundle ] pathForResource: @"Frame" ofType: @"png" ];
    _frameImage.image = [UIImage imageWithContentsOfFile: path];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    _status.text = @"Done";
    [_statusBar stopAnimating];
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
