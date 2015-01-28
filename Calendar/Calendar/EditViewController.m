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

#define currentMonth [currentMonthString integerValue]


@interface EditViewController ()
{
    NSDateFormatter *formatter;
    NSArray *arrayData;
    NSDateFormatter *dateFormatters;
}


#pragma mark - IBActions



@end

@implementation EditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDel = [AppDelegate new];
    NSLog(@"%@", [appDel applicationDocumentsDirectory]);
    // Do any additional setup after loading the view, typically from a nib.

    if (_createOrUpdate == Update) {
        
        //add previous elements
        Event *tempEvent = (Event *)_eventNeesToUpdate;
        _titleText.text = tempEvent.title;
        _eventText.text = tempEvent.desc;
        _textFieldEnterDate.text =  [NSString stringWithFormat:@"%@",tempEvent.localTime];
        if (tempEvent.otherName) {
            _labelText.text = tempEvent.otherName;
        }
        _timeZoneText.text =  [NSString stringWithFormat:@"%@",tempEvent.otherTime];
        

        [_updateButton setTitle:@"Update" forState:UIControlStateNormal];
    }
    else [_updateButton setTitle:@"Add" forState:UIControlStateNormal];
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    
    self.textFieldEnterDate.text = _startTimeText;
    self.labelText.text = _location;
    self.timeZoneText.text = _destinationTimeText;
    self.timeZoneText.textColor = [UIColor blackColor];
    
   
    

}

- (void)clearAll
{
    _timeZoneText.text = nil;
    _titleText.text = nil;
    _eventText.text = nil;
    _textFieldEnterDate.text = nil;
    _labelText.text = nil;
    
}

- (BOOL)createEvent {
    BOOL result = YES;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-yyyy hh:mm a"];
    //[self clearAll];
    //add elements
    Event *newEvent = [[Event alloc] initWithTitle:_titleText.text description:_eventText.text localZoneName:nil localZoneID:nil localZoneUTC:nil localTime:[format dateFromString:_textFieldEnterDate.text] otherZoneName:_labelText.text otherZoneID:nil otherZoneUTC:nil otherZoneTime:[format dateFromString:_timeZoneText.text]];
    
    [Utilities addEvent:newEvent];
    return result;
}

- (BOOL)updateEvent:(NSManagedObject *)oldEvent {
    BOOL result = YES;
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm a"];
        Event *newEvent = [[Event alloc] initWithTitle:_titleText.text description:_eventText.text localZoneName:nil localZoneID:nil localZoneUTC:nil localTime:[format1 dateFromString:_textFieldEnterDate.text] otherZoneName:nil otherZoneID:nil otherZoneUTC:nil otherZoneTime:[format1 dateFromString:_timeZoneText.text]];
    [Utilities updateEvent:oldEvent withNewValue:newEvent];
    return result;
}

- (IBAction)addOrUpdate:(UIButton *)sender {
    //Do the function of modifying the events
    switch (_createOrUpdate) {
        case Create:
            [self createEvent];
            break;
            
        case Update:
            [self updateEvent:_eventNeesToUpdate];
            break;
            
        default:
            break;
    }
}

- (IBAction)cancelAndReturn:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{ 
    ACDViewController* scv = [segue destinationViewController];
    scv.startTime = self.textFieldEnterDate.text;
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
    
    return true;
}
- (void) dateUpdated:(UIDatePicker *)datePicker {
    
    self.textFieldEnterDate.text = [formatter stringFromDate:self.datePicker.date];
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
