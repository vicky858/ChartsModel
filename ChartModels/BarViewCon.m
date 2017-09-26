//
//  BarView.m
//  ChartModels
//
//  Created by Vijayaamirtharaj on 16/02/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "BarViewCon.h"
#import "DSBarChart.h"
#import "ZFChart.h"
#import "ZFColor.h"
@interface BarViewCon ()<ZFGenericChartDataSource, ZFBarChartDelegate,ZFHorizontalBarChartDelegate>

@property (nonatomic, strong) ZFBarChart * barChart;
@property (nonatomic, strong) ZFHorizontalBarChart * hbarChart;

@property (nonatomic, assign) CGFloat height;
@end

@implementation BarViewCon
{
    __weak IBOutlet UIView *viewgraph;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self MakeLineChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)segmentTypes:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    
    if (selectedSegment == 0)
    {
        
        [self MakeLineChart];
    }
    if (selectedSegment == 1)
    {
        [self MakeLineChartTwo];
    }
    if (selectedSegment == 2)
    {
        [self MakeLineChartThree];
    }
}

-(void)MakeLineChart
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    NSArray *vals = [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:30],
                     [NSNumber numberWithInt:40],
                     [NSNumber numberWithInt:20],
                     [NSNumber numberWithInt:56],
                     [NSNumber numberWithInt:70],
                     [NSNumber numberWithInt:34],
                     [NSNumber numberWithInt:43],
                     nil];
    NSArray *refs = [NSArray arrayWithObjects:@"M", @"Tu", @"W", @"Th", @"F", @"Sa", @"Su", nil];
    DSBarChart *chrt = [[DSBarChart alloc] initWithFrame:viewgraph.bounds
                                                   color:[UIColor greenColor]
                                              references:refs
                                               andValues:vals];
    chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    chrt.bounds = viewgraph.bounds;
    [viewgraph addSubview:chrt];
    
}

-(void)MakeLineChartTwo
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    self.hbarChart = [[ZFHorizontalBarChart alloc] initWithFrame:viewgraph.bounds];
    self.hbarChart.dataSource = self;
    self.hbarChart.delegate = self;
    self.hbarChart.topicLabel.text = @"BAR CHART";
    self.hbarChart.unit = @"人";
    self.hbarChart.topicLabel.textColor = ZFPurple;
    self.hbarChart.isShadow = YES;
    self.hbarChart.valueLabelPattern = kPopoverLabelPatternBlank;
    // self.barChart.isResetAxisLineMinValue = YES;
    self.hbarChart.isShowXLineSeparate = YES;
    self.hbarChart.isShowYLineSeparate = YES;
    self.hbarChart.backgroundColor = ZFPurple;
    self.barChart.unitColor = ZFWhite;
    self.hbarChart.xAxisColor = ZFWhite;
    self.hbarChart.yAxisColor = ZFWhite;
    self.hbarChart.axisLineNameColor = ZFOrange;
    self.hbarChart.axisLineValueColor = ZFOrange;
    self.hbarChart.isShowAxisLineValue = NO;
    
    self.hbarChart.isAnimated = NO;
    
    [self.hbarChart strokePath];
    [viewgraph addSubview:self.hbarChart];
}

#pragma mark - ZFHorizontalBarChartDelegate

//- (CGFloat)barHeightInHorizontalBarChart:(ZFHorizontalBarChart *)barChart
//{
//    return 60.f;
//}
//
//- (CGFloat)paddingForGroupsInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 20.f;
//}
//
//- (CGFloat)paddingForBarInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 5.f;
//}

- (id)valueTextColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
    //    return ZFBlue;
    return @[ZFBlue, ZFGold, ZFOrange];
}

-(void)MakeLineChartThree
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    self.barChart = [[ZFBarChart alloc] initWithFrame:viewgraph.bounds];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    self.barChart.topicLabel.text = @"Chart";
    self.barChart.unit = @"人";
    self.barChart.isShowYLineSeparate = YES;
    self.barChart.isShowXLineSeparate = YES;
    
    self.barChart.valueType = kValueTypeDecimal;
    self.barChart.numberOfDecimal = 2;
    
    [self.barChart strokePath];
    [viewgraph addSubview:self.barChart];
    
    
}
#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@[@"123", @"300", @"490", @"380", @"167", @"235"],
             @[@"256", @"283", @"236", @"240", @"183", @"200"],
             @[@"256", @"256", @"256", @"256", @"256", @"256"]];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"JAN", @"FEB", @"MAR", @"APR", @"MAY", @"JULY",@"AUG",@"Sep"];
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFColor(71, 204, 255, 1), ZFGold, ZFColor(16, 140, 39, 1)];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 500;
}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 10;
}
#pragma mark - ZFBarChartDelegate

- (id)valueTextColorArrayInBarChart:(ZFBarChart *)barChart
{
    return ZFBlue;
    
}

- (NSArray<ZFGradientAttribute *> *)gradientColorArrayInBarChart:(ZFBarChart *)barChart{
    
    ZFGradientAttribute * gradientAttribute1 = [[ZFGradientAttribute alloc] init];
    gradientAttribute1.colors = @[(id)ZFColor(71, 204, 255, 1).CGColor, (id)ZFWhite.CGColor];
    gradientAttribute1.locations = @[@(0.5), @(0.99)];
    gradientAttribute1.startPoint = CGPointMake(0, 0.5);
    gradientAttribute1.endPoint = CGPointMake(1, 0.5);
    
    
    ZFGradientAttribute * gradientAttribute2 = [[ZFGradientAttribute alloc] init];
    gradientAttribute2.colors = @[(id)ZFGold.CGColor, (id)ZFWhite.CGColor];
    gradientAttribute2.locations = @[@(0.5), @(0.99)];
    gradientAttribute2.startPoint = CGPointMake(0, 0.5);
    gradientAttribute2.endPoint = CGPointMake(1, 0.5);
    
    
    ZFGradientAttribute * gradientAttribute3 = [[ZFGradientAttribute alloc] init];
    gradientAttribute3.colors = @[(id)ZFColor(16, 140, 39, 1).CGColor, (id)ZFWhite.CGColor];
    gradientAttribute3.locations = @[@(0.5), @(0.99)];
    gradientAttribute3.startPoint = CGPointMake(0, 0.5);
    gradientAttribute3.endPoint = CGPointMake(1, 0.5);
    
    ZFGradientAttribute * gradientAttribute4 = [[ZFGradientAttribute alloc] init];
    gradientAttribute4.colors = @[(id)ZFColor(16, 140, 39, 1).CGColor, (id)ZFWhite.CGColor];
    gradientAttribute4.locations = @[@(0.5), @(0.99)];
    gradientAttribute4.startPoint = CGPointMake(0, 0.5);
    gradientAttribute4.endPoint = CGPointMake(1, 0.5);
    
    return [NSArray arrayWithObjects:gradientAttribute1, gradientAttribute2, gradientAttribute3,gradientAttribute4, nil];
}

- (void)barChart:(ZFBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex bar:(ZFBar *)bar popoverLabel:(ZFPopoverLabel *)popoverLabel
{
    
    NSLog(@"第%ld个颜色中的第%ld个",(long)groupIndex,(long)barIndex);
    
}

- (void)barChart:(ZFBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel
{
    
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)labelIndex);
    
    
}


- (IBAction)btnBack_Tapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
