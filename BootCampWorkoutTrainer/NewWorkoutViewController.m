//
//  NewWorkoutViewController.m
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 2/17/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import "NewWorkoutViewController.h"

@interface NewWorkoutViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *workoutNameField;
@property (weak, nonatomic) IBOutlet UIButton *addExerciseButton;
@property (weak, nonatomic) IBOutlet UITextField *exerciseNameField;
@property (weak, nonatomic) IBOutlet UILabel *totalExercisesLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWorkoutTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *intensitySlider;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNumberLabel;

@end

@implementation NewWorkoutViewController

@synthesize minsArray;
@synthesize secsArray;
@synthesize workoutName;
@synthesize exercises;
@synthesize intensities;
@synthesize workoutTimes;
@synthesize totalWorkoutTime;
@synthesize totalExercises;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    workoutName = [[NSString alloc] init];
    exercises = [[NSMutableArray alloc] init];
    intensities = [[NSMutableArray alloc] init];
    workoutTimes = [[NSMutableArray alloc] init];
    
    minsArray = [[NSMutableArray alloc] init];
    secsArray = [[NSMutableArray alloc] init];
    NSString *stringValue = [[NSString alloc] init];
    
    for (int i=0; i<=60; i++)
    {
        stringValue = [NSString stringWithFormat:@"%d", i];
        [minsArray addObject:stringValue];
        [secsArray addObject:stringValue];
        totalWorkoutTime = 0;
    }
    
    self.intensitySlider.minimumValue = 1;
    self.intensitySlider.maximumValue = 99;
    
}

- (IBAction)sliderChanged:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    NSInteger val = lround(slider.value);
    NSLog(@"%i", val);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [minsArray count];
    }
    else if (component == 1) {
        return 1;
    }
    else if (component == 2){
        return [secsArray count];
    }
    else {
        return 1;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component){
        case 0:
            return [minsArray objectAtIndex:row];
        case 1:
            return @"min";
        case 2:
            return [secsArray objectAtIndex:row];
        case 3:
            return @"sec";
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger minRow, secRow;
    NSString *selectedMinute;
    NSString *selectedSecond;
    
    minRow = [pickerView selectedRowInComponent:0];
    secRow = [pickerView selectedRowInComponent:2];
    
    selectedMinute = [minsArray objectAtIndex:minRow];
    selectedSecond = [secsArray objectAtIndex:secRow];
    
    totalWorkoutTime = ([selectedMinute intValue] * 60) + [selectedSecond intValue];
    NSLog(@"%i", totalWorkoutTime);
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return (component == 0 || component == 2) ? 35.0f : 60.0f;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton) return;
    if (self.workoutNameField.text.length > 0)
    {
        self.addWorkout = [[workout alloc] init];
        self.addWorkout.workoutName = self.workoutNameField.text;
    }
    
}

@end
