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
#import "editExerciseViewController.h"

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
    workout *item1 = [[workout alloc] init];
    item1.exerciseArray = [[NSMutableArray alloc] init];
    item1.exerciseIntensityArray = [[NSMutableArray alloc]init];
    item1.exerciseTimeArray = [[NSMutableArray alloc]init];
    item1.workoutName = @"Mudderling";
    item1.workoutTime = @"02:00:00";
    item1.workoutIntensity = @"50";
    workout *item2 = [[workout alloc] init];
    item2.exerciseArray = [[NSMutableArray alloc] init];
    item2.exerciseIntensityArray = [[NSMutableArray alloc]init];
    item2.exerciseTimeArray = [[NSMutableArray alloc]init];
    item2.workoutName = @"Tough Mudder";
    item2.workoutTime = @"15:00:00";
    item2.workoutIntensity = @"99";
    for (int i = 10; i < 60; i++)
    {
        [item1.exerciseArray addObject:[NSString stringWithFormat:@"Exercise %lu",(long unsigned) i]];
        [item1.exerciseIntensityArray addObject:[NSNumber numberWithInt:i]];
        [item1.exerciseTimeArray addObject:[NSNumber numberWithInt:i]];
        [item2.exerciseArray addObject:[NSString stringWithFormat:@"%lu",(long unsigned) i]];
        [item2.exerciseIntensityArray addObject:[NSNumber numberWithInt:i]];
        [item2.exerciseTimeArray addObject:[NSNumber numberWithInt:i]];
    }
    [self.workouts addObject:item1];
    [self.workouts addObject:item2];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.workouts = [[NSMutableArray alloc] init];
    [self loadInitialData];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
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

//test edit mode
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    workout *workoutToMove = self.workouts[sourceIndexPath.row];
    [self.workouts removeObjectAtIndex:sourceIndexPath.row];
    [self.workouts insertObject:workoutToMove atIndex:destinationIndexPath.row];
    
}

-(IBAction)enterEditMode:(id)sender
{
    if([self.tableView isEditing])
    {
        [self.tableView setEditing:NO animated:YES];
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else
    {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
    }
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
    UILabel *workoutNameLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *workoutTimeLabel = (UILabel *)[cell viewWithTag:101];
    UIImageView *workoutImage = (UIImageView *)[cell viewWithTag:102];
    workoutNameLabel.text = workoutItem.workoutName;
    workoutTimeLabel.text = workoutItem.workoutTime;
    int cellIntensity = [workoutItem.workoutIntensity intValue];
    if (cellIntensity < 100 && cellIntensity > 66){ workoutImage.image = [UIImage imageNamed:@"high_intensity.png"];}
    else if (cellIntensity < 67 && cellIntensity > 33){ workoutImage.image = [UIImage imageNamed:@"medium_intensity.png"];}
    else if (cellIntensity < 34 && cellIntensity > 0){ workoutImage.image = [UIImage imageNamed:@"light_intensity.png"];};
    
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

- (IBAction)unwindToEditList:(UIStoryboardSegue *)segue
{
    editExerciseViewController *source = [segue sourceViewController];
    workout *workoutItem = source.editWorkout;
    NSInteger workoutIndexRow = source.workoutIndexRow;
    if (workoutItem != nil){
        [self.workouts replaceObjectAtIndex:workoutIndexRow withObject:workoutItem];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *segueName = nil;
    if([cell isEditing] == YES)
    {
        segueName = @"editWorkout";
    }
    else
    {
        segueName = @"selectWorkout";
    }
    [self performSegueWithIdentifier: segueName sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"selectWorkout"])
    {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        SelectedWorkoutViewController *destViewController = segue.destinationViewController;
        workout *workoutItem = [self.workouts objectAtIndex:indexPath.row];
        destViewController.selectedWorkout = workoutItem;
    }
    else if([segue.identifier isEqualToString:@"editWorkout"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        editExerciseViewController *destViewController = segue.destinationViewController;
        workout *workoutItem = [self.workouts objectAtIndex:indexPath.row];
        NSInteger workoutIndexRow = indexPath.row;
        destViewController.editWorkout = workoutItem;
        destViewController.workoutIndexRow = workoutIndexRow;
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

