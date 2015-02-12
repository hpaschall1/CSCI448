//
//  InputIphoneViewController.m
//  Calculator
//
//  Created by Trevor Westphal on 2/8/15.
//  Copyright (c) 2015 Heather Paschall. All rights reserved.
//

#import "InputIphoneViewController.h"
#import "GraphViewController.h"
#import "CalculatorBrain.h"

@interface InputIphoneViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userIsEnteringDecimal;
@property (nonatomic) BOOL userHasEnteredASpecialDigit;
@property (nonatomic) BOOL userHasEnteredTheVariable;
@end

@implementation InputIphoneViewController

@synthesize display;
@synthesize verboseDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userIsEnteringDecimal;
@synthesize userHasEnteredASpecialDigit;
@synthesize userHasEnteredTheVariable;

@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit;
    if ([[sender currentTitle] isEqualToString:@"π"]) {
        if(self.userIsInTheMiddleOfEnteringANumber == YES){
            digit = @"";
        } else {
            digit = @"3.141592654"; // For Heather!
        }
        self.userHasEnteredASpecialDigit = YES;
    } else if([[sender currentTitle] isEqualToString:@"x"]){
        if(self.userIsInTheMiddleOfEnteringANumber == YES){
            digit = @"";
        } else {
            self.userHasEnteredTheVariable = YES;
            digit = @"x";
        }
        self.userHasEnteredASpecialDigit = YES;
    } else {
        if(self.userHasEnteredASpecialDigit){
            digit = @"";
        } else {
            digit = [sender currentTitle];
        }
    }
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed {
    self.verboseDisplay.text = @"";
    self.display.text = @"";
    [self.brain clearOperandStack];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasEnteredASpecialDigit = NO;
    self.userHasEnteredTheVariable = NO;
}

- (IBAction)backspace:(id)sender {
    if([self.display.text length] > 1){
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    } else {
        self.display.text = @"0";
    }
}


- (IBAction)changeSign:(id)sender {
    if ([self.display.text rangeOfString:@"-"].location != NSNotFound) {
        self.display.text = [self.display.text substringFromIndex:1];
    } else {
        self.display.text = [NSString stringWithFormat:@"-%@", self.display.text];
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userIsEnteringDecimal = NO;
    self.userHasEnteredASpecialDigit = NO;
    
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:[NSString stringWithFormat:@"%@ ", self.display.text]];
    self.display.text = @"";
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    if(self.userHasEnteredTheVariable == NO){
        
        double result = [self.brain performOperation:operation];
        self.display.text = [NSString stringWithFormat:@"%g", result];
        
        self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:[NSString stringWithFormat:@"%@ = %g", operation, result]];
        
    } else {
        self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:operation];
    }
    
    self.userHasEnteredTheVariable = NO;
}

- (IBAction)decimalPressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if(self.userIsEnteringDecimal == NO){
            self.userIsEnteringDecimal = YES;
            self.display.text = [self.display.text stringByAppendingString:@"."];
            self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@"."];
        }
    } else {
        self.display.text = @"0.";
        self.userIsEnteringDecimal = YES;
        self.userIsInTheMiddleOfEnteringANumber = YES;
        self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@" 0."];
    }
}

- (IBAction)graphPushed {
    
    UIStoryboard *graphSB = [UIStoryboard storyboardWithName:@"GraphIphoneView" bundle:nil];
    GraphViewController *graphVC = [graphSB instantiateViewControllerWithIdentifier:@"GraphIphoneViewController"];
    
    [graphVC sendProgram:self.verboseDisplay.text];
    
    [self presentViewController:graphVC animated:YES completion:nil];
    
    
}




@end
