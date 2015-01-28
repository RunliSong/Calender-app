//
//  EditViewController.m
//  Calendar
//
//  Created by zhu on 21/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "EditViewController.h"
#import "ACDViewController.h"

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
    
    // Do any additional setup after loading the view, typically from a nib.
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    
    self.textFieldEnterDate.text = _startTimeText;
    self.labelText.text = _location;
    self.timeZoneText.text = _destinationTimeText;
    self.timeZoneText.textColor = [UIColor blackColor];
    

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
