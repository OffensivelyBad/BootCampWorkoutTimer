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
@property int currentRound;
@property IBOutlet UILabel *workoutNameLabel;
@property IBOutlet UILabel *exerciseNameLabel;
@property IBOutlet UILabel *roundNumberLabel;
@property (nonatomic, retain) UILabel *timerLabel;
- (void)updateTimer:(NSTimer *)theTimer;
- (void)countdownTimer;
- (void)updateRound;
- (void)setTime;
- (IBAction)onButton:(UIButton *)sender;

@end
