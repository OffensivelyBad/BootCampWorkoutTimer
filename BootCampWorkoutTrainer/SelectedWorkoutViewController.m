//
//  SelectedWorkoutViewController.m
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 4/22/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import "SelectedWorkoutViewController.h"

@interface SelectedWorkoutViewController ()

@end

@implementation SelectedWorkoutViewController

@synthesize selectedWorkout;
@synthesize currentRound;
@synthesize workoutNameLabel;
@synthesize exerciseNameLabel;
@synthesize roundNumberLabel;
@synthesize timerLabel;

int hours, minutes, seconds;
int secondsLeft;

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
    
    currentRound = 0;
    
    workoutNameLabel.text = selectedWorkout.workoutName;
    secondsLeft = [selectedWorkout.exerciseTimeArray[currentRound] intValue];
    
    running = false;
    
    [self setTime];
    
    exerciseNameLabel.text = [NSString stringWithFormat:@"%@",[selectedWorkout.exerciseArray objectAtIndex:currentRound]];
    roundNumberLabel.text = [NSString stringWithFormat:@"%i", currentRound + 1];
    
    NSLog(@"%i",secondsLeft);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer:(NSTimer *)theTimer
{
    if (secondsLeft > 0 && running ==true)
    {
        secondsLeft --;
        [self setTime];
    }
    else
    {
        [self updateRound];
    }
}

- (void)countdownTimer
{
    if (running == true)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:true];
        NSLog(@"%i",secondsLeft);
    }
    else
    {
        [timer invalidate];
        timer = nil;
    }
}

- (void)setTime
{
    hours = secondsLeft / 3600;
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft % 3600) % 60;
    timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
}

- (void)updateRound
{
    if (currentRound +1 < [selectedWorkout.exerciseArray count])
    {
        currentRound ++;
        [timer invalidate];
        timer = nil;
        secondsLeft = [selectedWorkout.exerciseTimeArray[currentRound] intValue];
        [self setTime];
        exerciseNameLabel.text = [NSString stringWithFormat:@"%@",[selectedWorkout.exerciseArray objectAtIndex:currentRound]];
        roundNumberLabel.text = [NSString stringWithFormat:@"%i", currentRound + 1];
        [self countdownTimer];
    }
}

- (IBAction)onButton:(UIButton *)sender
{
    if (running == false)
    {
        running = true;
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        [self countdownTimer];
    }
    else
    {
        running = false;
        [sender setTitle:@"START" forState:UIControlStateNormal];
        [self countdownTimer];
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
