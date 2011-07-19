//
//  AskerViewController.h
//  LabelMover
//
//  Created by CS193p Instructor on 11/11/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AskerViewControllerDelegate;

@interface AskerViewController : UIViewController <UITextFieldDelegate>
{
@private
	NSString *question;
	IBOutlet UILabel *questionLabel;
	IBOutlet UITextField *answerField;
	id <AskerViewControllerDelegate> delegate;
}

@property (copy) NSString *question;

@property (retain) IBOutlet UILabel *questionLabel;
@property (retain) IBOutlet UITextField *answerField;

@property (assign) id <AskerViewControllerDelegate> delegate;

@end

@protocol AskerViewControllerDelegate
- (void)askerViewController:(AskerViewController *)sender didAskQuestion:(NSString *)question andGotAnswer:(NSString *)answer;
@end
