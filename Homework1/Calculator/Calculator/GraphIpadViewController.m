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

    UIStoryboard *inputSB = [UIStoryboard storyboardWithName:@"InputIphoneView" bundle:nil];
    UIViewController *inputVC = [inputSB instantiateViewControllerWithIdentifier:@"InputIphoneViewController"];
    
    UIStoryboard *graphSB = [UIStoryboard storyboardWithName:@"GraphIphoneView" bundle:nil];
    UIViewController *graphVC = [graphSB instantiateViewControllerWithIdentifier:@"GraphIphoneViewController"];
    
    NSArray *newVCs = [NSArray arrayWithObjects:inputVC, graphVC, nil];
    
    self.viewControllers = newVCs;
}

@end
