//
//  AskerViewController.m
//  LabelMover
//
//  Created by CS193p Instructor on 11/11/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "AskerViewController.h"

@implementation AskerViewController

@synthesize question;
@synthesize questionLabel, answerField;
@synthesize delegate;

- (void)viewDidLoad
{
	self.answerField.delegate = self;
	self.answerField.autocapitalizationType = UITextAutocapitalizationTypeWords;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.questionLabel.text = self.question;
	self.answerField.text = nil;
	[self.answerField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField.text.length) {
		[textField resignFirstResponder];
		return YES;
	} else {
		return NO;
	}
}

// - (void)textFieldDidEndEditing:(UITextField *)textField
- (IBAction)done
{
	if (self.answerField.text.length > 0) {
		[self.delegate askerViewController:self
							didAskQuestion:self.questionLabel.text
							  andGotAnswer:self.answerField.text
								 withAudio:player];
	}
}

- (IBAction)record
{
	NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
	NSURL *recordURL = [NSURL URLWithString:[cacheDirectory stringByAppendingPathComponent:@"AnswerRecording.aif"]];
	
	if (recorder.recording) {
		[recorder stop];
		[player release];
		player = [[AVAudioPlayer alloc] initWithContentsOfURL:recordURL error:NULL];
		[player play];
	} else {
		if (!recorder) recorder = [[AVAudioRecorder alloc] initWithURL:recordURL settings:nil error:NULL];
		[recorder record];
	}
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.questionLabel = nil;
	self.answerField = nil;
}

- (void)dealloc {
	[question release];
	[questionLabel release];
	[answerField release];
	[player release];
	[recorder release];
    [super dealloc];
}

@end
