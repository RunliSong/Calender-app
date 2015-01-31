//
//  YearViewController.m
//  Calendar
//
//  Created by RunliSong on 15/1/28.
//  Copyright (c) 2015年 Deakin University. All rights reserved.
//

#import "YearViewController.h"
#import "MonthInYearCollectionViewCell.h"
#import "Utilities.h"

@interface YearViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *yearCollection;
@end

@implementation YearViewController{
    NSArray *inforInAyear;
    NSArray *inforInAmonth;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Utilities *uti = [Utilities new];
//    NSArray *arr = [uti getAllDaysOfMonth:1 inYear:2015];
//    NSDateComponents *components = arr[0];
//    NSLog(@"%@", arr);
//    NSLog(@"%@", components.description);
    
    [[self yearCollection]setDataSource:self];
    [[self yearCollection]setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)getMonthsInAyear {
    
    int year = 2015;
    int month = 1;
    NSString *stringToDisplay;
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:month inYear:year];
    NSString *planceHolder = @"    ";
    for (int i = 0; i < arr.count; i++) {
        NSDateComponents *component = [arr objectAtIndex:i];
        if (i == 0) {
            int day = (int)component.day;
            
            NSString *holder;
            for (int j = 0; j < day; j++) {
                holder = [planceHolder stringByAppendingString:planceHolder];
            }
            stringToDisplay = [stringToDisplay stringByAppendingString:holder];
            stringToDisplay = [stringToDisplay stringByAppendingString:[NSString stringWithFormat:@"%i", day]];
            continue;
        }
        if (component.weekday != 7) {
            stringToDisplay = [stringToDisplay stringByAppendingString:planceHolder];
            stringToDisplay = [stringToDisplay stringByAppendingString:[NSString stringWithFormat:@"%i", (int)component.day]];
        }
        else {
            stringToDisplay = [stringToDisplay stringByAppendingString:planceHolder];
            stringToDisplay = [stringToDisplay stringByAppendingString:[NSString stringWithFormat:@"%i\n", (int)component.day]];
        }
        inforInAmonth = [[NSArray alloc]initWithObjects:stringToDisplay, nil];
        
    }
    return inforInAmonth;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark collection view methods
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifer = @"Month";
    MonthInYearCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:Cellidentifer forIndexPath:indexPath];
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Month" forIndexPath:indexPath];
    [[cell myWeekDays]setText:@"S M T W T F S"];
    //[[cell myDaysInMouth]setText:stringToDisplay];
    //UITextView *daysInMonth = (UITextView *)[cell viewWithTag:100];
    //daysInMonth.text = _stringToDisplay;
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    
    return cell;
}

@end
