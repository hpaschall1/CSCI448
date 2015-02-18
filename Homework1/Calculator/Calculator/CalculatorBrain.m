//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Heather Paschall on 1/19/15.
//  Copyright (c) 2015 Heather Paschall. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

#pragma mark - Instance Methods

- (NSMutableArray *)operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)clearOperandStack
{
    while (_operandStack.count > 0) {
        [self popOperand];
    }
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    // perform operation here, store answer in result
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"sqrt"]) {
        double l = [self popOperand];
        if (l > 0)
           result = sqrt(l);
        else result = 0;
    }
    
    [self pushOperand:result];
    
    return result;
}

#pragma mark - Class Methods

+ (NSString*)descriptionOfProgram:(id) program{
    // This ended up being unecessary
    return @"";
}

+ (NSMutableArray*)runProgram:(id) program usingVariableValues:(NSMutableArray*) arr{
    // Why the fuck does this return a float?!?!? Shouldn't it return the series of Y's for each X?
    // That's what I've decided it does. Bam. Executive decision.
    
    NSMutableArray* final = [[NSMutableArray alloc] init];
    
    for(NSNumber *n in arr){
        float n_val = [n floatValue];
        
        NSLog(@"IT's working %@!", n);
    }
    
    return final;
}

@end
