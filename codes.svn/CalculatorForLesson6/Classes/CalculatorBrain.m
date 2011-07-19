//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Yuefeng LU on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

@synthesize operand;
@synthesize storedOperand;


-(double)performOperation: (NSString *)operation
{
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	}
	else if ( [@"+/-" isEqual:operation ] )
	{
		operand = - operand;
	}
	else if([operation isEqual:@"1/X"]){
		if (operand == 0) {
			operand = 0;
		}
		else {
			operand = 1 / operand;
		}
	}
	else if ( [operation isEqual:@"sin" ] ){
		operand = sin(operand);
	}
	else if ( [operation isEqual:@"cos" ] ){
		operand = cos(operand);
	}
	else if ([@"store" isEqual: operation]) {
		self.storedOperand = operand;
	}
	else if ( [@"recall" isEqual: operation ]){
		operand = self.storedOperand;
	}
	else if ( [@"M+" isEqual: operation ]){
		self.storedOperand = operand + self.storedOperand;
	}
	else if ( [@"C" isEqual:operation]){
		operand = 0;
		waitingOperand = 0;
	}
	else if ( [@"MC" isEqual:operation]){
		storedOperand = 0;
	}
	else{	//the case of @"=" pressed
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}
	return operand;
}


-(double)performWaitingOperation
{
	if ([@"+" isEqual:waitingOperation]) {
		operand = waitingOperand + operand;
	}
	else if ([@"-" isEqual:waitingOperation]) {
		operand = waitingOperand - operand;
	}
	else if ([@"*" isEqual:waitingOperation]) {
		operand = waitingOperand * operand;
	}
	else if ([@"/" isEqual:waitingOperation]) {
		if (operand) {
			operand = waitingOperand / operand;
		}
	} 
	return operand;
}

-(void)dealloc{
	[waitingOperation release];
	[super dealloc];
}

@end
