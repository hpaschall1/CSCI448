//
//  ViewController.m
//  Calculator
//
//  Created by Heather Paschall on 1/19/15.
//  Copyright (c) 2015 Heather Paschall. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated {
    // Buffer view to create and switch to other views depending on device
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        // Get the storyboard by name
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"InputIphoneView" bundle:nil];
        
        // Link it to the viewcontroller called "InputIphoneViewController"
        UIViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"InputIphoneViewController"];
        
        // If you've got it, flaunt it
        [self presentViewController:viewcontroller animated:NO completion:NULL];
    } else {
        NSLog(@"We're using an iPad!");
    }
}

@end
