//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Sergiu Dumbrava on 28/06/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userIsTypingAFloat;
@property (nonatomic, strong) CalculatorBrain *brain;

- (void)addToHistoryLabel: (NSString *)historyItem 
                separator: (NSString *) separatorString;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize displayHistory;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userIsTypingAFloat;
@synthesize brain = _brain;

- (CalculatorBrain *)brain{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber){        
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (void)addToHistoryLabel: (NSString *)historyItem 
                separator: (NSString *) separatorString
{
    self.displayHistory.text = [self.displayHistory.text stringByAppendingString:historyItem];
    self.displayHistory.text = [self.displayHistory.text stringByAppendingString:separatorString];
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    NSString *operation = sender.currentTitle;
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];

    [self addToHistoryLabel:operation separator:@" ="];
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    [self addToHistoryLabel:self.display.text separator:@" "];
}

- (IBAction)dotPressed 
{
    if (self.userIsInTheMiddleOfEnteringANumber){
        if (!self.userIsTypingAFloat){
            self.display.text = [self.display.text stringByAppendingString:@"."];
        }
    }else {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed 
{
    self.display.text = @"0";
    self.displayHistory.text = @"";
    self.userIsTypingAFloat = NO;
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain clear];
}

- (IBAction)backspacePressed 
{
    self.display.text = [self.display.text substringToIndex:self.display.text.length - 1];
    
    if (self.display.text.length == 0){
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
        self.userIsTypingAFloat = NO;
    }
}
@end
