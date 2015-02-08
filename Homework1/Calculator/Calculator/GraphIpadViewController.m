//
//  GraphIpadViewController.m
//  Calculator
//
//  Created by Trevor Westphal on 2/8/15.
//  Copyright (c) 2015 Heather Paschall. All rights reserved.
//

#import "GraphIpadViewController.h"

@interface GraphIpadViewController ()

@end

@implementation GraphIpadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"InputIphoneView" bundle:nil];
    UIViewController *newviewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"InputIphoneViewController"];
    
    NSArray *newVCs = [NSArray arrayWithObjects:[self.viewControllers objectAtIndex:0], newviewcontroller, nil];
    
    self.viewControllers = newVCs;
}

@end
