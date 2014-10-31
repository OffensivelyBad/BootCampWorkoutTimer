//
//  editWorkoutViewController.h
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 5/27/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "workout.h"

@interface editExerciseViewController : UIViewController <UIPickerViewDelegate>

@property workout *editWorkout;
@property (retain, nonatomic) NSMutableArray *minsArray;
@property (retain, nonatomic) NSMutableArray *secsArray;
@property NSString *workoutName;
@property NSMutableArray *exercises;
@property NSMutableArray *intensities;
@property NSMutableArray *workoutTimes;
@property NSInteger exerciseTime;
@property NSString *totalWorkoutTime;
@property NSInteger totalExercises;
@property NSString *workoutIntensity;
@property int currentExercise;
@property NSInteger workoutIndexRow;
- (void)selectExercise;
- (void)saveExercise;
- (IBAction)stepperValueChanged:(id)sender;

@end
