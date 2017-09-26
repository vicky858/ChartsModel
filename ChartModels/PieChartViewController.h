//
//  PieChartViewController.h
//  MBMCharts
//
//  Created by Pat Murphy on 12/13/12.
//  Copyright (c) 2012 Pat Murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMPieChart.h"

@interface PieChartViewController : UIViewController <MBMPieChartDelegate, MBMPieChartDataSource>

@property(nonatomic, strong) IBOutlet MBMPieChart *pieChartRight;
@property(nonatomic, strong) IBOutlet MBMPieChart *pieChartLeft;
@property(nonatomic, strong) IBOutlet UILabel *selectedSliceLabel;
@property(nonatomic, strong) NSMutableArray *pieDicArray;
@property(nonatomic, strong) NSMutableArray *pieChartDataArray;
@property(nonatomic, strong) NSMutableArray *pieChartConfigArray;

- (void) setUpChart;

@end
