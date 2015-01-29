//
//  EventSearchResultViewController.h
//  Calendar
//
//  Created by Peng Gao on 29/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventSearchResultViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *localTime;
@property (weak, nonatomic) IBOutlet UILabel *otherTime;

@property (nonatomic, strong) NSArray *events;
@end
