//
//  workout.h
//  BootCampWorkoutTrainer
//
//  Created by Shawn Roller on 2/17/14.
//  Copyright (c) 2014 Shawn Roller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface workout : NSObject

@property NSString *workoutName;
@property NSString *workoutTime;
//@property NSTimeInterval workoutTime;
@property NSString *workoutIntensity;
@property NSMutableArray *exerciseArray;
@property NSMutableArray *exerciseIntensityArray;
@property NSMutableArray *exerciseTimeArray;

@end
