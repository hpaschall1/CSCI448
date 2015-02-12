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

-(void)viewDidLoad {
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"InputIphoneViewController"]){
        NSLog(@"We need to go to the graph");
    } else {
        NSLog(@"We need to go to the input");
    }
}

@end
