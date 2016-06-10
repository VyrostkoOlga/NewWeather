//
//  DetailViewController.m
//  NewWeather
//
//  Created by Ольга Выростко on 14.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, retain) IBOutlet UILabel * from;
@property (nonatomic, retain) IBOutlet UILabel * to;
@property (nonatomic, retain) IBOutlet UIImageView * symbol;
@property (nonatomic, retain) IBOutlet UITextView * desc;
@property (nonatomic, retain) IBOutlet UIImageView * image;

@end

@implementation DetailViewController
{
    UILabel * _from;
    UILabel * _to;
    UIImageView * _symbol;
    UITextView * _desc;
    UIImageView * _image;
    
    Time * _time;
    
    NSDateFormatter * _dateFmt;
    NSNumberFormatter * _numFmt;
}

@synthesize from=_from;
@synthesize to=_to;
@synthesize symbol=_symbol;
@synthesize desc=_desc;
@synthesize time=_time;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self != nil)
    {
        _dateFmt = [[NSDateFormatter alloc] init];
        [_dateFmt setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        
        _numFmt = [[NSNumberFormatter alloc] init];
        [ _numFmt setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [ _numFmt setNumberStyle: NSNumberFormatterDecimalStyle];
    }
    return self;
}

-(void) dealloc
{
    [_from release];
    [_to release];
    
    [_time release];
    [_numFmt release];
    [_dateFmt release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _from.text = [_dateFmt stringFromDate: _time.from];
    _to.text = [_dateFmt stringFromDate: _time.to];
    _desc.text = [_time present];
    NSCalendar *cal = [[NSCalendar alloc] init];
    NSDateComponents *components = [cal components:0 fromDate: _time.from];
    long month = [components month];
    //long month = 5;
    //long month = 7;
    //long month = 9;
    
    NSLog(@"%ld", month);
    
    if ((month == 11) || (month == 0) || (month == 1))
    {
        NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"Winter" ofType: @"png" ];
        _image.image = [UIImage imageWithContentsOfFile: path];
    }
    else if ((month == 2) || (month == 3) || (month == 4))
    {
        NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"Spring" ofType: @"png" ];
        _image.image = [UIImage imageWithContentsOfFile: path];
    }
    else if ((month == 5) || (month == 6) || (month == 7))
    {
        NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"Summer" ofType: @"png" ];
        _image.image = [UIImage imageWithContentsOfFile: path];
    }
    if ((month == 8) || (month == 9) || (month == 10))
    {
        NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"Autumn" ofType: @"png" ];
        _image.image = [UIImage imageWithContentsOfFile: path];
    }
    
    NSData * data = [NSData dataWithContentsOfURL: _time.symbol];
    if (data != nil)
    {
        _symbol.image = [UIImage imageWithData: data];
    }
    
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
