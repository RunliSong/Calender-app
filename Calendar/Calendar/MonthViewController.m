//
//  MonthViewController.m
//  Calendar
//
//  Created by RunliSong on 15/1/31.
//  Copyright (c) 2015年 Deakin University. All rights reserved.
//

#import "MonthViewController.h"
#import "DayInMonthCollectionViewCell.h"
#import "MonthHeaderView.h"
#import "YearViewController.h"
#import "Utilities.h"


@interface MonthViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *monthCollection;
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
    [self getDaysInMonth];
    [[self monthCollection]setDataSource:self];
    [[self monthCollection]setDelegate:self];
    [self.monthCollection registerClass:[MonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderTitle"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)getDaysInMonth {
    int year = (int)datesInfor.currentYear;
    int month = (int)datesInfor.selectedMonth;

    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:1 inYear:2015];
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
    return 42;
    
}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *identifer = @"MonthTitle";
//    MonthHeaderView *Header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifer forIndexPath:indexPath];
//    [self updateHeader:Header forIndexPath:indexPath];
//    
//    return Header;
//                                    
//}
//- (void)updateHeader:(UICollectionReusableView *)header forIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifer = @"Days";
    DayInMonthCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:Cellidentifer forIndexPath:indexPath];
    
    [[cell dayS]setText:[daysarray objectAtIndex:indexPath.item]];
    
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
@end
