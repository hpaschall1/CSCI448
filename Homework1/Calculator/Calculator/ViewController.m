//
//  ViewController.m
//  Calculator
//
//  Created by Heather Paschall on 1/19/15.
//  Copyright (c) 2015 Heather Paschall. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userIsEnteringDecimal;
@end

@implementation ViewController

@synthesize display;
@synthesize verboseDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userIsEnteringDecimal;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit;
    if ([[sender currentTitle] isEqualToString:@"π"]) {
        if(self.userIsEnteringDecimal == YES){
            digit = @"";
        } else
            digit = @"3.141592"; // For Heather!
    } else {
        digit = [sender currentTitle];
    }
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:digit];
}
- (IBAction)clearPressed {
    self.verboseDisplay.text = @"";
    self.display.text = @"";
    [self.brain clearOperandStack];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)backspace:(id)sender {
    if([self.display.text length] > 1){
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
        self.verboseDisplay.text = [self.verboseDisplay.text substringToIndex:[self.verboseDisplay.text length] - 1];
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
    
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@" "];
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@ ", operation]];
    //[self.verboseDisplay.text substringWithRange:NSMakeRange(self.verboseDisplay.text.length - 30, self.verboseDisplay.text.length-1)];
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

@end
