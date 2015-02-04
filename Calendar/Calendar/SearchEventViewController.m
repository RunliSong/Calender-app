//
//  SearchEventViewController.m
//  Calendar
//
//  Created by Peng Gao on 31/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "SearchEventViewController.h"
#import "SearchResultViewController.h"
#import "Utilities.h"

@interface SearchEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *eventKeyword;
@property (weak, nonatomic) IBOutlet UIDatePicker *fromDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backToPrevious:(id)sender;

@end

@implementation SearchEventViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_fromDate setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    [_toDate setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add gesture for recognizer for the text field
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

// dismiss keyboard when touches outside
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}

-(void)dismissKeyboard {
    [_eventTitle resignFirstResponder];
    [_eventKeyword resignFirstResponder];
}

- (IBAction)search:(id)sender {
    NSArray *result = [Utilities getEventsWithTitle:_eventTitle.text description:_eventKeyword.text startDate:_fromDate.date andEndDate:_toDate.date];
    if ([result count]) {
        UIStoryboard *krisStory = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
        SearchResultViewController *svc = [krisStory instantiateViewControllerWithIdentifier:@"searchR"];
        svc.events = result;
        [self presentViewController:svc animated:YES completion:nil];

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No result" message:@"Can't find any relate event, please check conditions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
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

- (IBAction)backToPrevious:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
