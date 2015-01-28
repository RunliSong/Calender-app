//
//  EditViewController.h
//  Calendar
//
//  Created by zhu on 21/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

typedef NS_ENUM(NSInteger, CreateOrUpdate) {
    Create,
    Update
};

@property (nonatomic) CreateOrUpdate createOrUpdate;

@property (strong, nonatomic) IBOutlet UITextField *textFieldEnterDate;

@property (strong, nonatomic) IBOutlet UIButton *toolbarCancelDone;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *pickerViewBackground;
@property (strong, nonatomic) IBOutlet UITextField *timeZoneText;
@property (strong, nonatomic) NSString *locationText;
@property (strong, nonatomic) IBOutlet UILabel *labelText;
@property (strong, nonatomic) NSString *destinationTimeText;
@property (strong, nonatomic) NSString *startTimeText;
@property (strong, nonatomic) NSString *location;

- (NSString *)getTheSame;
@end


