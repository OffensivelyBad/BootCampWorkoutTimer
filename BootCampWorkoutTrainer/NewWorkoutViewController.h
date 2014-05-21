//
//  NewWorkoutViewController.h
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 2/17/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "workout.h"

@interface NewWorkoutViewController : UIViewController <UIPickerViewDelegate>

@property workout *addWorkout;
@property (retain, nonatomic) NSMutableArray *minsArray;
@property (retain, nonatomic) NSMutableArray *secsArray;
@property NSString *workoutName;
@property NSMutableArray *exercises;
@property NSMutableArray *intensities;
@property NSMutableArray *workoutTimes;
@property NSInteger exerciseTime;
@property NSString *totalWorkoutTime;
@property NSInteger totalExercises;

@end
