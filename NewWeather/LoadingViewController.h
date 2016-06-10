//
//  LoadingViewController.h
//  NewWeather
//
//  Created by Ольга Выростко on 20.11.14.
//  Copyright (c) 2014 Ольга Выростко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel * status;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * statusBar;
@property (nonatomic, retain) IBOutlet UIButton * cancel;
@property (nonatomic, retain) IBOutlet UIImageView * loadImage;
@property (nonatomic, retain) IBOutlet UIImageView * frameImage;

@end
