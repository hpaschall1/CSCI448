//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Heather Paschall on 1/19/15.
//  Copyright (c) 2015 Heather Paschall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)clearOperandStack;
- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

+ (NSString*)descriptionOfProgram:(id) program;
+ (NSMutableArray*)runProgram:(id) program usingVariableValues:(NSMutableArray*) arr;

@end
