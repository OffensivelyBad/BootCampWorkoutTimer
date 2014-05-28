//
//  WorkoutListViewController.h
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 2/17/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutListViewController : UITableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
- (IBAction)enterEditMode:(id)sender;

@end
