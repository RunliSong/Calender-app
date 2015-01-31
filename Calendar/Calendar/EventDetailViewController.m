//
//  EventDetailViewController.m
//  Calendar
//
//  Created by Peng Gao on 29/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Event.h"
#import "EditViewController.h"
#import "Utilities.h"

@interface EventDetailViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UITextView *eventDesc;

@property (weak, nonatomic) IBOutlet UILabel *eventTime;
@property (weak, nonatomic) IBOutlet UILabel *eventOtherTime;
@property (weak, nonatomic) IBOutlet UILabel *eventOtherTimeLabel;


@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _event = [[Utilities getAllEvents] firstObject];
    
    if (!_event) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Event" message:@"Please check detail" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    _eventTitle.text = ((Event *)_event).title;
    _eventDesc.text = ((Event *)_event).desc;
    _eventTime.text = [NSString stringWithFormat:@"%@", ((Event *)_event).localTime];
    
    if (!((Event *)_event).otherTime) {
        [_eventOtherTimeLabel setHidden:YES];
        [_eventOtherTime setHidden:YES];
    }
    else {
        _eventOtherTime.text = [NSString stringWithFormat:@"%@", ((Event *)_event).otherTime];
    }
    
}


- (IBAction)backToPrevious:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // back to year view
}
- (IBAction)editEvent:(UIButton *)sender {
    EditViewController *evc = [[EditViewController alloc] init];
    evc.createOrUpdate = Update;
    evc.eventNeesToUpdate = _event;
    [self presentViewController:evc animated:YES completion:nil];
    
}
- (IBAction)deleteEvent:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"You want to delete this event?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
        [Utilities deleteEvent:_event];
        // back to year view
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
