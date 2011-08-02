//
//  FunctionCurveView.m
//  CalculatorWithNavigation
//
//  Created by lyf on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FunctionCurveView.h"


@implementation FunctionCurveView

+ (BOOL)scaleIsValid:(CGFloat)aScale
{
	return ((aScale > 0) && (aScale <= 1));
}

#define DEFAULT_SCALE 0.90

- (CGFloat)scale
{
	return [FunctionCurveView scaleIsValid:scale] ? scale : DEFAULT_SCALE;
}

- (void)setScale:(CGFloat)newScale
{
	if ([FunctionCurveView scaleIsValid:newScale]) {
		if (newScale != scale) {
			scale = newScale;
			[self setNeedsDisplay];
		}
	}
}

- (void)setup
{
	self.contentMode = UIViewContentModeRedraw;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		[self setup];
    }
    return self;
}

- (void)awakeFromNib
{
	[self setup];
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
	
	//scale
	int scalerNum = 6;
	
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
	if ((gesture.state == UIGestureRecognizerStateChanged) ||
		(gesture.state == UIGestureRecognizerStateEnded)) {
		//self.scale *= gesture.scale;
		gesture.scale = 1;
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
