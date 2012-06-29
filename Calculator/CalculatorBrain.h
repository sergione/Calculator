//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergiu Dumbrava on 28/06/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void) clear;

@end
