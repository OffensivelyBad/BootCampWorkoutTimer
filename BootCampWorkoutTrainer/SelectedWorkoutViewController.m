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
@synthesize workoutNameLabel;
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
    // Do any additional setup after loading the view.
    //workout *selectedWorkout = [[workout alloc]init];
    workoutNameLabel.text = selectedWorkout.workoutName;
    //secondsLeft = [selectedWorkout.workoutTime intValue];
    secondsLeft = 60;
    running = false;
    NSLog(@"%i",secondsLeft);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer:(NSTimer *)theTimer
{
    if (secondsLeft > 0)
    {
        secondsLeft --;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft % 3600) % 60;
        timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    }
}

- (void)countdownTimer
{
    if (running == true)
    {
        //secondsLeft = hours = minutes = seconds = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:true];
        NSLog(@"%i",secondsLeft);
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
