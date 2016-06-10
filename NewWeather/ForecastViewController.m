//
//  ForecastViewController.m
//  NewWeather
//
//  Created by Ольга Выростко on 15.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import "ForecastViewController.h"

@interface ForecastViewController ()

@end

@implementation ForecastViewController
{
    Forecast * _forecast;
    NSArray * _times;
    UITableView * _tbl;
    NSDate * _updateTime;
    NSDateFormatter * _dateFmt;
}

@synthesize forecast=_forecast;
@synthesize tbl=_tbl;
@synthesize times=_times;
@synthesize updateTime=_updateTime;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self != nil)
    {
        _dateFmt = [[NSDateFormatter alloc] init];
        [_dateFmt setDateFormat: @"HH:mm:ss"];
    }
    return self;
}

-(void) dealloc
{
    [_forecast release];
    [_tbl release];
    [_updateTime release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tbl registerNib: [UINib nibWithNibName: @"TimeCellTableViewCell" bundle: [NSBundle mainBundle]] forCellReuseIdentifier: @"TimeCell"];
    _updateTime = [NSDate date];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(TimeCellTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"TimeCell";
    
    TimeCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    /*
    if (cell == nil)
    {
        cell = [[[TimeCellTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellId] autorelease];
    }
     */
    
    NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"port_turq_border" ofType: @"png" ];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile: path]] autorelease];
    cell.from.text = [[[_times objectAtIndex: indexPath.row] dateFmt] stringFromDate: [[_times objectAtIndex: indexPath.row] from]];
    cell.to.text = [[[_times objectAtIndex: indexPath.row] dateFmt] stringFromDate: [[_times objectAtIndex: indexPath.row] to]];
    
    NSData * imData = [NSData dataWithContentsOfURL: [[_times objectAtIndex: indexPath.row] symbol]];
    
    if (imData != nil)
        cell.symbol.image = [UIImage imageWithData: imData];
    else
        cell.symbol.image = nil;
    
    cell.desc.text = [[[_times objectAtIndex: indexPath.row] rain] objectForKey: @"type"];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tbl deselectRowAtIndexPath: indexPath animated: YES];
    DetailViewController * ctrl = [[[DetailViewController alloc] initWithNibName: @"DetailViewController" bundle: [NSBundle mainBundle]] autorelease];
    
    ctrl.time = [[[Time alloc] initWithTime: [_times objectAtIndex: indexPath.row]] autorelease];
    
    [self.navigationController pushViewController: ctrl animated:YES];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_times count];
}

-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [NSString stringWithFormat: @"Updated at %@", [_dateFmt stringFromDate: _updateTime]];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    _updateTime = [NSDate date];
    return [NSString stringWithFormat: @"Updated at %@", [_dateFmt stringFromDate: _updateTime]];
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
