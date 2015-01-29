//
//  EventSearchResultTableViewCell.h
//  Calendar
//
//  Created by Peng Gao on 29/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventSearchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *localTime;
@property (weak, nonatomic) IBOutlet UILabel *otherTime;


@end
