//
//  SelectedWorkoutViewController.h
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 4/22/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "workout.h"

@interface SelectedWorkoutViewController : UIViewController
{
    NSTimer *timer;
    BOOL running;
    IBOutlet UILabel *timerLabel;
}

@property workout *selectedWorkout;
@property IBOutlet UILabel *workoutNameLabel;
@property (nonatomic, retain) UILabel *timerLabel;
- (void)updateTimer:(NSTimer *)theTimer;
- (void)countdownTimer;
- (IBAction)onButton:(UIButton *)sender;

@end
