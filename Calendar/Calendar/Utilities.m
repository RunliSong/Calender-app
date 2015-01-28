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

@end
