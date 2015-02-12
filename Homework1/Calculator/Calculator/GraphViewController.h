//
//  CalculatorBrain.h
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University.
//  All rights reserved.
//
#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic, strong) NSString* program;

- (void)refreshView;
- (void)sendProgram:(NSString*) program;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
