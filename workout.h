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
@property NSTimeInterval workoutTime;
@property NSInteger workoutIntensity;
@property NSMutableArray *exerciseArray;
@property NSMutableArray *exerciseTimeArray;

@end
