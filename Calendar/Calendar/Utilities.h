//
//  Utilities.h
//  Calendar
//
//  Created by Peng Gao on 21/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import <CoreData/CoreData.h>

@interface Utilities : NSObject

- (NSArray *)getAllDaysOfMonth:(int) month inYear:(int)year;
+ (BOOL)addEvent: (Event *)event;
+ (NSArray *)getAllEvents; // will return an array of NSManagedObject, each item can be cast as Event
+ (BOOL)updateEvent: (NSManagedObject *)event withNewValue: (Event *)newValue;
+ (BOOL)deleteEvent: (NSManagedObject *)event;

+ (NSArray *)getEventsWithTitle:(NSString *) eventTitle description:(NSString *)desc startDate:(NSDate *) startDate andEndDate:(NSDate *)endDate; // Use this method, any value can be nil

@end
