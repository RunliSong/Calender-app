//
//  Event.h
//  Calendar
//
//  Created by Peng Gao on 19/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong, nonatomic) NSString *title; // of event
@property (strong, nonatomic) NSString *desc; //Description of an event

@property (strong, nonatomic) NSString *localTimeoneName; // e.g. Pacific Standard Time
@property (strong, nonatomic) NSString *localTimeoneID; // e.g. America/Los_Angeles
@property (nonatomic) int localTimeoneUTC; // Range from -12 to +12
@property (strong, nonatomic) NSDate *localTime; // Local date and time of the event occurs

@property (strong, nonatomic) NSString *otherTimeoneName; // e.g. Pacific Standard Time
@property (strong, nonatomic) NSString *otherTimeoneID; // e.g. America/Los_Angeles
@property (nonatomic) int otherTimeoneUTC; // Range from -12 to 12
@property (strong, nonatomic) NSDate *otheroneTime; // The date and time of another time one;

@end
