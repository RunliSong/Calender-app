//
//  Utilities.m
//  Calendar
//
//  Created by Peng Gao on 21/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "Utilities.h"
#import "AppDelegate.h"

@implementation Utilities

+(BOOL)addEvent:(Event *)event {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *eventEntity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    NSManagedObject *newEvent = [[NSManagedObject alloc] initWithEntity:eventEntity insertIntoManagedObjectContext:context];
    
    [newEvent setValue:event.title forKey:@"title"];
    [newEvent setValue:event.desc forKey:@"desc"];
    [newEvent setValue:event.localID forKey:@"localID"];
    [newEvent setValue:event.localName forKey:@"localName"];
    [newEvent setValue:event.localTime forKey:@"localTime"];
    [newEvent setValue:event.localUTC forKey:@"localUTC"];
    [newEvent setValue:event.otherID forKey:@"otherID"];
    [newEvent setValue:event.otherName forKey:@"otherName"];
    [newEvent setValue:event.otherTime forKey:@"otherTime"];
    [newEvent setValue:event.otherUTC forKey:@"otherUTC"];
    
    NSError *error = nil;
    if (![newEvent.managedObjectContext save:&error]) {
        NSLog(@"%@", error.localizedDescription);
        return NO;
    }
    return YES;
}

+ (NSArray *)getEventsWithTitle:(NSString *)eventTitle andDescription:(NSString *)desc {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *eventEntity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:eventEntity];
    NSString *predicateString = [NSString stringWithFormat: @"(title LIKE[c] '*%@*') AND (desc like[c] '*%@*')", eventTitle, desc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    return results;

}

+ (BOOL)updateEvent:(NSManagedObject *)event withNewValue:(Event *)newValue {
    [event setValue:newValue.title forKey:@"title"];
    [event setValue:newValue.desc forKey:@"desc"];
    [event setValue:newValue.localTime forKey:@"localTime"];
    [event setValue:newValue.localUTC forKey:@"localUTC"];
    [event setValue:newValue.localID forKey:@"localID"];
    [event setValue:newValue.localName forKey:@"localName"];
    [event setValue:newValue.otherID forKey:@"otherID"];
    [event setValue:newValue.otherName forKey:@"otherName"];
    [event setValue:newValue.otherTime forKey:@"otherTime"];
    [event setValue:newValue.otherUTC forKey:@"otherUTC"];
    
    NSError *error = nil;
    if (![event.managedObjectContext save:&error]) {
        NSLog(@"%@", error.localizedDescription);
        return NO;
    }
    return YES;

}

+ (BOOL)deleteEvent:(NSManagedObject *)event {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:event];
    NSError *deleteError = nil;
    
    if (![event.managedObjectContext save:&deleteError]) {
        NSLog(@"Error: %@", deleteError.localizedDescription);
        return NO;
    }
    return YES;
}

+ (NSArray *)getAllEvents {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *eventEntity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:eventEntity];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    return results;
}

// format should be "2014-01-31"
-(NSDate *)getDateFromDateString :(NSString *)dateString {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

// return format is "yyyy-MM-dd"
// get the last date of month, month 1,3,5,7,8,10,12 will return "year-month-31"
// Feb will return "year-month-28" or "year-month-29" depending on leap year
// rest will return "year-month-30"
- (int)daysOfMonth:(int)month inYear: (int)year{
    int lastDate = 30;
    //NSString *lastDate;
    NSString *monthString = [NSString stringWithFormat:@"%i-%i-", year, month];
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12: {
            lastDate = 31;
            break;
        }
        case 2: {
            NSString *fullDateString = [monthString stringByAppendingString:@"01"];
            NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:[self getDateFromDateString:fullDateString]];
            if ([component isLeapMonth]) {
                lastDate = 29;
            }
            else lastDate = 28;
            break;
        }
        default: lastDate = 30;
            break;
    }
    return lastDate;
}

- (NSArray *)getAllDaysOfMonth:(int) month inYear:(int)year {
    //NSString *firstDateString = [NSString stringWithFormat:@"%i-%i-01", year, month];
    NSMutableArray *results = [NSMutableArray new];
    int days = [self daysOfMonth:month inYear:year];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    for (int i = 1; i <= days; i++) {
        NSDateComponents *component = [calendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth) fromDate:[self getDateFromDateString:[NSString stringWithFormat:@"%i-%i-%i", year, month, i]]];
        [results addObject:component];
    }
    return results;
}



@end