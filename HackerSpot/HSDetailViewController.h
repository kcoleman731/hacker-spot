//
//  HSDetailViewController.h
//  HackerSpot
//
//  Created by Kevin Coleman on 3/16/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
