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
@property NSString *sliderValue;

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
@synthesize sliderValue;

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
    
    //default the slider value
    sliderValue = @"1";
    
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

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

- (IBAction)sliderChanged:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    NSInteger val = lround(slider.value);
    sliderValue = [NSString stringWithFormat:@"%i", val];
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

- (IBAction)addExercise:(id)sender
{
    if (self.workoutNameField.text.length > 0)
    {
        if (self.exerciseNameField.text.length > 0)
        {
            [exercises addObject:self.exerciseNameField.text];
            [intensities addObject:self.sliderValue];
            [workoutTimes addObject:[NSNumber numberWithInt:totalWorkoutTime]];
            NSLog(@"Exercises: %@, intensities: %@, workoutTimes: %@",exercises, intensities, workoutTimes);
    
            [self.exerciseNameField setText:@""];
        }
        
        else
        {
            [self emptyExerciseFieldAlert];
        }
    }
    else
    {
        [self emptyWorkoutFieldAlert];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton) return;
    if (self.workoutNameField.text.length > 0)
    {
        //save the workout
        
        NSInteger times = 0;
        NSInteger totalIntensity = 0;
        NSInteger avgIntensity = 0;
        
//        times = 0;
//        totalIntensity = 0;
//        avgIntensity = 0;
        
        self.addWorkout = [[workout alloc] init];
        self.addWorkout.workoutName = self.workoutNameField.text;
        for (int i = 0; i < [exercises count]; i++)
        {
            [self.addWorkout.exerciseArray addObject:[exercises objectAtIndex:i]];
            [self.addWorkout.exerciseIntensityArray addObject:[intensities objectAtIndex:i]];
            [self.addWorkout.exerciseTimeArray addObject:[workoutTimes objectAtIndex:i]];
            
            times = times + [[workoutTimes objectAtIndex:i] integerValue];
            totalIntensity = totalIntensity + [[intensities objectAtIndex:i] integerValue];
            
            NSLog(@"times %i intensity %i", times, totalIntensity);
        }
        avgIntensity = totalIntensity / [intensities count];
        
        self.addWorkout.workoutTime = [NSString stringWithFormat:@"%i", times];
        self.addWorkout.workoutIntensity = [NSString stringWithFormat:@"%i", avgIntensity];
    }
    
}

- (void)emptyExerciseFieldAlert
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"What's the exercise?", nil)
                                                    message:NSLocalizedString(@"Enter the exercise name", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Got it!", nil)
                                          otherButtonTitles:nil];
	[alert show];
}

- (void)emptyWorkoutFieldAlert
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"What do you want to call the workout?", nil)
                                                    message:NSLocalizedString(@"Enter the workout name", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Got it!", nil)
                                          otherButtonTitles:nil];
	[alert show];
}

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    if ([identifier isEqualToString:@"navigationSegue"]) {
//        NSLog(@"Segue Blocked");
//        //Put your validation code here and return YES or NO as needed
//        if (self.workoutNameField.text.length > 0 && sender == self.saveButton)
//        {
//            return YES;
//        }
//        else {
//            [self emptyWorkoutFieldAlert];
//            return NO;
//        }
//    }
//    return YES;
//}

@end
