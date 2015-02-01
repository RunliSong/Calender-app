//
//  MonthViewController.m
//  Calendar
//
//  Created by RunliSong on 15/2/1.
//  Copyright (c) 2015年 Deakin University. All rights reserved.
//

#import "MonthViewController.h"
#import "DayViewController.h"
#import "DaysInMonthCollectionViewCell.h"
#import "YearViewController.h"
#import "Utilities.h"

@interface MonthViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *monthCollection;
- (IBAction)backToYear:(id)sender;

@end

@implementation MonthViewController
{
    NSMutableArray *daysarray;
    YearViewController *datesInfor;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    daysarray = [[NSMutableArray alloc] init];
    [daysarray addObject:@"S"];
    [daysarray addObject:@"M"];
    [daysarray addObject:@"T"];
    [daysarray addObject:@"W"];
    [daysarray addObject:@"T"];
    [daysarray addObject:@"F"];
    [daysarray addObject:@"S"];
    NSLog(@"month: %li, year: %li", (long)_month, (long)_year);
    [self getDaysInMonth];
    [[self monthCollection]setDataSource:self];
    [[self monthCollection]setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)getDaysInMonth {
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSString *placeHolder = @" ";
    for (int i = 0; i < arr.count; i++) {
        
        NSDateComponents *component = [arr objectAtIndex:i];
        if ((int)component.day == 1) {
            int day = (int)component.weekday;
            
            for (int j = 1; j < day; j++) {
                [daysarray addObject:placeHolder];
            }
            [daysarray addObject:[NSString stringWithFormat:@"%i", (int)component.day]];
        }
        else
            [daysarray addObject:[NSString stringWithFormat:@"%i", (int)component.day]];
        
    }
    
    return daysarray;
}
#pragma mark collection view methods
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSInteger totalDays = 0;
    NSLog(@"%lu", (unsigned long)[arr count]);
    NSLog(@"%ld", (long)((NSDateComponents *)[arr objectAtIndex:0]).weekday);
    totalDays += 7;
    totalDays += [arr count];
    totalDays += ((NSDateComponents *)[arr objectAtIndex:0]).weekday - 1;
    return totalDays;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSInteger selected = indexPath.item - 7 - ((NSDateComponents *)[arr objectAtIndex:0]).weekday +2;
    
    dvc.weekdaytitle = ((NSDateComponents *)[arr objectAtIndex:indexPath.item]).weekday -1;
    dvc.datenum = selected;
    
    if(selected >0)
        [self presentViewController:dvc animated:YES completion:nil];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifer = @"day";
    DaysInMonthCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:Cellidentifer forIndexPath:indexPath];
    
    [[cell dayName]setText:[daysarray objectAtIndex:indexPath.item]];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backToYear:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
