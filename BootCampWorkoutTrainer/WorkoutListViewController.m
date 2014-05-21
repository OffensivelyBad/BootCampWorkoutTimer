//
//  WorkoutListViewController.m
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 2/17/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import "WorkoutListViewController.h"
#import "workout.h"
#import "NewWorkoutViewController.h"
#import "SelectedWorkoutViewController.h"

@interface WorkoutListViewController ()

@property NSMutableArray *workouts;

@end

@implementation WorkoutListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadInitialData
{
//    workout *item1 = [[workout alloc] init];
//    item1.workoutName = @"Mudderling";
//    [self.workouts addObject:item1];
//    workout *item2 = [[workout alloc] init];
//    item2.workoutName = @"Mudder";
//    [self.workouts addObject:item2];
//    workout *item3 = [[workout alloc] init];
//    item3.workoutName = @"Tough Mudder";
//    [self.workouts addObject:item3];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.workouts = [[NSMutableArray alloc] init];
    //[self loadInitialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.workouts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    workout *workoutItem = [self.workouts objectAtIndex:indexPath.row];
    //cell.textLabel.text = workoutItem.workoutName;
    UILabel *workoutNameLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *workoutTimeLabel = (UILabel *)[cell viewWithTag:101];
    workoutNameLabel.text = workoutItem.workoutName;
    //workoutTimeLabel.text = [NSString stringWithFormat: @"%f",workoutItem.workoutTime];
    workoutTimeLabel.text = workoutItem.workoutTime;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.workouts removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [tableView endUpdates];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    NewWorkoutViewController *source = [segue sourceViewController];
    workout *workoutItem = source.addWorkout;
    if (workoutItem != nil){
        [self.workouts addObject:workoutItem];
        [self.tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"selectWorkout"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SelectedWorkoutViewController *destViewController = segue.destinationViewController;
        workout *workoutItem = [self.workouts objectAtIndex:indexPath.row];
        destViewController.selectedWorkout = workoutItem;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
