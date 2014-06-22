//
//  editWorkoutViewController.m
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 5/27/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import "editWorkoutViewController.h"

@interface editWorkoutViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *workoutNameField;
@property (weak, nonatomic) IBOutlet UITextField *exerciseNameField;
@property (weak, nonatomic) IBOutlet UILabel *totalExercisesLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWorkoutTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *intensitySlider;
@property (weak, nonatomic) IBOutlet UIStepper *exerciseStepper;

@property NSString *sliderValue;

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
@synthesize sliderValue;
@synthesize totalWorkoutTime;
@synthesize workoutIntensity;
@synthesize currentExercise;
@synthesize workoutIndexRow;

@synthesize editWorkout;

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
    
    //Set defaults
    self.workoutName = editWorkout.workoutName;
    self.exercises = editWorkout.exerciseArray;
    self.intensities = editWorkout.exerciseIntensityArray;
    self.workoutTimes = editWorkout.exerciseTimeArray;
    self.totalWorkoutTime = editWorkout.workoutTime;
    self.workoutIntensity = editWorkout.workoutIntensity;
    self.exerciseStepper.maximumValue = [self.exercises count];
    
    self.currentExercise = 0;
    
    self.workoutNameField.text = self.workoutName;
    
    //default the picker
    NSString *stringValue = [[NSString alloc] init];
    
    minsArray = [[NSMutableArray alloc] init];
    secsArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<=60; i++)
    {
        stringValue = [NSString stringWithFormat:@"%d", i];
        [minsArray addObject:stringValue];
        [secsArray addObject:stringValue];
        exerciseTime = 0;
    }
    
    self.intensitySlider.minimumValue = 1;
    self.intensitySlider.maximumValue = 99;
    
    [self selectExercise];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

- (void)selectExercise
{
    self.exerciseNameField.text = self.exercises[currentExercise];
    self.totalExercisesLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[self.exercises count]];
    self.totalWorkoutTimeLabel.text = self.totalWorkoutTime;
    self.sliderValue = self.intensities[currentExercise];
    self.intensitySlider.value = [self.intensities[currentExercise] intValue];
    int currentExerciseTime = [self.workoutTimes[currentExercise] intValue];
    int seconds = currentExerciseTime % 60;
    int minutes = (currentExerciseTime - seconds) / 60;
    //set picker for minutes and seconds
    [self.pickerView selectRow:minutes inComponent:0 animated:YES];
    [self.pickerView selectRow:seconds inComponent:2 animated:YES];
    self.exerciseStepper.maximumValue = [self.exercises count] - 1;
    
    NSLog(@"maximum stepper value: %f",self.exerciseStepper.maximumValue);
    NSLog(@"number of exercises: %lu",(unsigned long)[self.exercises count]);
}

- (IBAction)stepperValueChanged:(UIStepper *)sender
{
    currentExercise = sender.value;
    
    [self selectExercise];
    
    NSLog(@"Exercise: %02d", currentExercise);
}

- (IBAction)sliderChanged:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    NSInteger val = lround(slider.value);
    sliderValue = [NSString stringWithFormat:@"%li", (long)val];
    NSLog(@"%li", (long)val);
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
    
    exerciseTime = ([selectedMinute intValue] * 60) + [selectedSecond intValue];
    NSLog(@"%li", (long)exerciseTime);
    
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
//        //save the workout
//        
//        NSInteger totalIntensity = 0;
//        NSInteger avgIntensity = 0;
//        
//        self.editWorkout = [[workout alloc] init];
//        self.editWorkout.exerciseArray = [[NSMutableArray alloc] init];
//        self.editWorkout.exerciseIntensityArray = [[NSMutableArray alloc] init];
//        self.editWorkout.exerciseTimeArray = [[NSMutableArray alloc] init];
        self.editWorkout.workoutName = self.workoutNameField.text;
//        
//        for (int i = 0; i < [exercises count]; i++)
//        {
//            [self.editWorkout.exerciseArray addObject:[exercises objectAtIndex:i]];
//            [self.editWorkout.exerciseIntensityArray addObject:[intensities objectAtIndex:i]];
//            [self.editWorkout.exerciseTimeArray addObject:[workoutTimes objectAtIndex:i]];
//            
//            totalIntensity = totalIntensity + [[intensities objectAtIndex:i] integerValue];
//        }
//        
//        if ([intensities count] == 0)
//        {
//            avgIntensity = totalIntensity;
//        }
//        else
//        {
//            avgIntensity = totalIntensity / [intensities count];
//        }
//        
//        self.editWorkout.workoutTime = totalWorkoutTime;
//        self.editWorkout.workoutIntensity = [NSString stringWithFormat:@"%li", (long)avgIntensity];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
