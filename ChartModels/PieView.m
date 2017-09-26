//
//  PieView.m
//  ChartModels
//
//  Created by Vijayaamirtharaj on 17/02/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "PieView.h"
#import "ZFChart.h"
@interface PieView ()<ZFPieChartDataSource, ZFPieChartDelegate>

@property (nonatomic, strong) ZFPieChart * pieChart;

@property (nonatomic, assign) CGFloat height;
@end

@implementation PieView
{
    __weak IBOutlet UIView *viewgraph;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pieChartOne];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentTypes:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    
    if (selectedSegment == 0)
    {
        
        [self pieChartOne];
    }
    if (selectedSegment == 1)
    {
        [self pieChartTwo];
    }
    if (selectedSegment == 2)
    {
        [self pieChartThree];
    }
}
-(void)pieChartOne
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    self.pieChart = [[ZFPieChart alloc] initWithFrame:viewgraph.bounds];
    self.pieChart.dataSource = self;
    self.pieChart.delegate = self;
    self.pieChart.piePatternType = kPieChartPatternTypeForCircle;
    self.pieChart.percentType = kPercentTypeDecimal;
    self.pieChart.isShadow = NO;
    self.pieChart.isAnimated = NO;
    [self.pieChart strokePath];
    [viewgraph addSubview:self.pieChart];
    
    
    
}

-(void)pieChartTwo
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    self.pieChart = [[ZFPieChart alloc] initWithFrame:viewgraph.bounds];
    self.pieChart.dataSource = self;
    self.pieChart.delegate = self;
    self.pieChart.piePatternType = kPieChartPatternTypeForCircle;
    self.pieChart.percentType = kPercentTypeInteger;
    self.pieChart.isShadow = YES;
    self.pieChart.isAnimated = YES;
    [self.pieChart strokePath];
    [viewgraph addSubview:self.pieChart];
    
    
    
}

-(void)pieChartThree
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    self.pieChart = [[ZFPieChart alloc] initWithFrame:viewgraph.bounds];
    self.pieChart.dataSource = self;
    self.pieChart.delegate = self;
    self.pieChart.piePatternType = kPieChartPatternTypeForCirque;
    self.pieChart.percentType = kPercentTypeInteger;
    self.pieChart.isShadow = YES;
    self.pieChart.isAnimated = YES;
    [self.pieChart strokePath];
    [viewgraph addSubview:self.pieChart];
    
    
    
}

#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart
{
    return @[@"50", @"256", @"300", @"283", @"490", @"236", @"256", @"300", @"283"];
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart{
    return @[ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(214, 205, 153, 1), ZFColor(78, 250, 188, 1), ZFColor(16, 140, 39, 1), ZFColor(45, 92, 34, 1),ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(214, 205, 153, 1)];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

- (CGFloat)allowToShowMinLimitPercent:(ZFPieChart *)pieChart{
    return 5.f;
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return 120.f;
}

/** This method only for ring types(kPieChartPatternTypeForCirque)effective */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 3.f;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)btnBack_Tapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end



























