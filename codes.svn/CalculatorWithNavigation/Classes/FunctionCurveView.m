//
//  FunctionCurveView.m
//  CalculatorWithNavigation
//
//  Created by lyf on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FunctionCurveView.h"


@implementation FunctionCurveView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawLineFrom:(CGPoint)startPoint to:(CGPoint)endPoint withContext:(CGContextRef)context {
	UIGraphicsPushContext(context);
	CGContextBeginPath(context);
	
	CGContextMoveToPoint (context, startPoint.x, startPoint.y);
	CGContextAddLineToPoint (context, endPoint.x, endPoint.y);
	
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 5.0);
	[[UIColor blueColor] setStroke];
    
	//vertical
	CGPoint startPoint, endPoint;
	startPoint.x = endPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	startPoint.y = self.bounds.origin.y;
	endPoint.y = self.bounds.origin.y + self.bounds.size.height;
	[self drawLineFrom: startPoint to:endPoint withContext: context];
	
	//horizontal
	startPoint.x = self.bounds.origin.x;
	endPoint.x = self.bounds.origin.x + self.bounds.size.width;
	startPoint.y = endPoint.y = self.bounds.origin.y + self.bounds.size.height / 2;
	[self drawLineFrom: startPoint to:endPoint withContext: context];
	
}


- (void)dealloc {
    [super dealloc];
}


@end
