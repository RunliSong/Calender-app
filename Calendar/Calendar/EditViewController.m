//
//  EditViewController.m
//  Calendar
//
//  Created by zhu on 21/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "EditViewController.h"
#import "ACDViewController.h"
#import "Utilities.h"
#import "AppDelegate.h"
#import "DayViewController.h"

#define currentMonth [currentMonthString integerValue]


@interface EditViewController ()


@end

@implementation EditViewController
{
    NSDateFormatter *formatter;
    NSArray *arrayData;
    NSDateFormatter *dateFormatters;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _timeZoneText.userInteractionEnabled = NO;
    


    AppDelegate *appDel = [AppDelegate new];
    NSLog(@"%@", [appDel applicationDocumentsDirectory]);
    if (_titleStr) {
        self.titleText.text = _titleStr;
    }
    else {
        self.titleText.placeholder = @"Title";
    }
    self.eventText.text = _eventStr;
    

    if (self.eventText.text == Nil) {
        self.eventText.text = @"dfdssd";
    }
    // Do any additional setup after loading the view, typically from a nib.

    if (_createOrUpdate == Update) {
        
        //add previous elements
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
        Event *tempEvent = (Event *)_eventNeesToUpdate;
        _titleText.text = tempEvent.title;
        _eventText.text = tempEvent.desc;

        _textFieldEnterDate.text =  [formatter stringFromDate:tempEvent.localTime];
       
        if (tempEvent.otherName) {
            _labelText.text = tempEvent.otherName;
        }
        _timeZoneText.text =  [formatter stringFromDate:tempEvent.otherTime];
        

        [_updateButton setTitle:@"Update" forState:UIControlStateNormal];
    }
    else{
        
    [_updateButton setTitle:@"Add" forState:UIControlStateNormal];
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    
    self.textFieldEnterDate.text = _startTimeText;
    self.labelText.text = _location;
    self.timeZoneText.text = _destinationTimeText;
    self.timeZoneText.text = [formatter stringFromDate:_destinationTime];
    self.timeZoneText.textColor = [UIColor blackColor];
    
    }
    

}



#pragma mark - function for users to add a new event item

- (BOOL)createEvent {
    BOOL result = YES;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-yyyy hh:mm a"];
    //add elements
    Event *newEvent = [[Event alloc] initWithTitle:_titleText.text description:_eventText.text localZoneName:nil localZoneID:nil localZoneUTC:nil localTime:[format dateFromString:_textFieldEnterDate.text] otherZoneName:_labelText.text otherZoneID:nil otherZoneUTC:nil otherZoneTime:[format dateFromString:_timeZoneText.text]];
    
    
    // validate date
    if ([self validateDateValue:_textFieldEnterDate.text]) {
        [Utilities addEvent:newEvent];
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Date format error!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: @"Cancel", nil];
        [alertView show];
    }
    return result;
}

- (BOOL)validateDateValue: (NSString *)dateString {
    NSDateFormatter *aformatter = [NSDateFormatter new];
    [aformatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSDate *date = [aformatter dateFromString:dateString];
    if (date == nil) {
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark - update event when the specific event select to modify

- (BOOL)updateEvent:(NSManagedObject *)oldEvent {
    BOOL result = YES;
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"dd-MM-yyyy hh:mm a"];
    Event *newEvent = [[Event alloc] initWithTitle:_titleText.text description:_eventText.text localZoneName:nil localZoneID:nil localZoneUTC:nil localTime:[format1 dateFromString:_textFieldEnterDate.text] otherZoneName:_labelText.text otherZoneID:nil otherZoneUTC:nil otherZoneTime: [format1 dateFromString:_timeZoneText.text]];
    [Utilities updateEvent:oldEvent withNewValue:newEvent];
    return result;
}

#pragma mark - triger to tell the action

- (IBAction)addOrUpdate:(UIButton *)sender {
    //Do the function of modifying the events
    switch (_createOrUpdate) {
        case Create: {
            [self createEvent];
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
            DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd-MM-yyyy hh:mm a"];
            dvc.pickedDate = [format dateFromString:_textFieldEnterDate.text] ;
            NSLog(@"sadadasd %@", [format dateFromString:_textFieldEnterDate.text]);
            [self presentViewController:dvc animated: YES completion:nil];
        }
            break;
            
        case Update:
            [self updateEvent:_eventNeesToUpdate];
            [self dismissViewControllerAnimated:YES completion:Nil];
            break;
            
        default:
            break;
    }
}

#pragma mark - reture to the previous view

- (IBAction)cancelAndReturn:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{ 
    ACDViewController* scv = [segue destinationViewController];
    scv.startTime = self.textFieldEnterDate.text;
    scv.titleText = self.titleText.text;
    scv.detailText = self.eventText.text;
}

-(void)viewWillAppear:(BOOL)animated{
    [self initialieTextFieldInputView];
    
}
- (void) initialieTextFieldInputView {
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.pickerViewBackground.backgroundColor =[UIColor whiteColor];
    [self.datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    self.textFieldEnterDate.inputView = self.pickerViewBackground;
    [self.pickerViewBackground removeFromSuperview];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Textfield Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.textFieldEnterDate) {
        self.datePicker.hidden = false;
    }
    
    return TRUE;
}

- (NSString *)getTheSame {
    NSString *input, *result;
    NSArray *all = [NSTimeZone knownTimeZoneNames];
    input = self.labelText.text;
    
    
    for (NSString *s in all) {
        if ([s containsString:input]) {
            result = s;
            break;
        }
    }
    
    return result;
}

- (void) dateUpdated:(UIDatePicker *)datePicker {
    
    self.textFieldEnterDate.text = [formatter stringFromDate:self.datePicker.date];
    
    if(self.labelText.text != nil) {
        
        //recall the method getTheSame
        NSString* timezone = [self getTheSame];

        //set date format
        _dateStart = self.textFieldEnterDate.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
        NSDate *adate = [dateFormatter dateFromString:_dateStart];
        //get time zones
        NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
        NSTimeZone *TimeZone = [NSTimeZone timeZoneWithName:timezone];
        
        NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:adate];
        NSInteger Offset = [TimeZone secondsFromGMTForDate:adate];
        NSTimeInterval Interval = Offset - currentGMTOffset;
        
        _destinationTime = [[NSDate alloc] initWithTimeInterval:Interval sinceDate:adate];
        
        self.timeZoneText.text = [formatter stringFromDate:_destinationTime];


    }


}


- (IBAction)buttonDone:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 10;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arrayData count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return arrayData[row];
}




@end
