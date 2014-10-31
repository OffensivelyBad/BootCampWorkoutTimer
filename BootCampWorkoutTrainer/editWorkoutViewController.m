//
//  editWorkoutViewController.m
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 10/31/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import "editWorkoutViewController.h"

@interface editWorkoutViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation editWorkoutViewController

@synthesize minsArray;
@synthesize secsArray;
@synthesize workoutName;
@synthesize exercises;
@synthesize intensities;
@synthesize workoutTimes;
@synthesize exerciseTime;
@synthesize totalExercises;
@synthesize totalWorkoutTime;
@synthesize workoutIntensity;
@synthesize currentExercise;
@synthesize workoutIndexRow;
@synthesize editWorkout;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = editWorkout.workoutName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton) return;    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
