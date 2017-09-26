//
//  LineChartView.m
//  ChartModels
//
//  Created by Vijayaamirtharaj on 16/02/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "LineChartView.h"
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"
#import "ZFChart.h"

@interface LineChartView ()<ZFGenericChartDataSource, ZFLineChartDelegate>

@property (nonatomic, strong) FSLineChart *chartWithDates;
@property (nonatomic, strong) ZFLineChart * lineChart;

@property (nonatomic, assign) CGFloat height;
@end

@implementation LineChartView
{
    NSMutableArray* chartDat;
    __weak IBOutlet UIView *viewgraph;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self MakeLineChart];

}

- (void)didReceiveMemoryWarning
{
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
    
    
    chartDat = [NSMutableArray arrayWithCapacity:7];
    for(int i=0;i<7;i++) {
        chartDat[i] = [NSNumber numberWithFloat: (float)i / 30.0f + (float)(rand() % 100) / 500.0f];
    }
    
    NSArray* months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July"];
    
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(18, 18, 840, 510)];
    lineChart.valueLabelTextColor= [UIColor blackColor];
    lineChart.indexLabelFont= [UIFont fontWithName:@"HelveticaNeue" size:16];
    lineChart.indexLabelTextColor= [UIColor blackColor];
    lineChart.dataPointColor=[UIColor orangeColor];
    lineChart.dataPointBackgroundColor=[UIColor redColor];
    
    lineChart.labelForIndex = ^(NSUInteger item) {
        return months[item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.08f €", powf(10,value)];
    };
    
    [lineChart setChartData:chartDat];
    [viewgraph addSubview:lineChart];
}

-(void)MakeLineChartTwo
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:7];
    for(int i=0;i<7;i++) {
        chartData[i] = [NSNumber numberWithFloat: (float)i / 30.0f + (float)(rand() % 100) / 500.0f];
    }
    
    NSArray* months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July"];
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(18, 18, 840, 510)];
    
    // Setting up the line chart
    lineChart.verticalGridStep = 6;
    lineChart.horizontalGridStep = 3;
    lineChart.fillColor = nil;
    lineChart.valueLabelTextColor= [UIColor blackColor];
    lineChart.indexLabelTextColor= [UIColor blackColor];
    lineChart.indexLabelFont= [UIFont fontWithName:@"HelveticaNeue" size:15];
    lineChart.displayDataPoint = YES;
    lineChart.dataPointColor = [UIColor fsOrange];
    lineChart.dataPointBackgroundColor = [UIColor fsOrange];
    lineChart.dataPointRadius = 2;
    lineChart.color = [_chartWithDates.dataPointColor colorWithAlphaComponent:0.3];
    lineChart.valueLabelPosition = ValueLabelLeftMirrored;
    
    lineChart.labelForIndex = ^(NSUInteger item) {
        return months[item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.02f €", value];
    };
    
    [lineChart setChartData:chartData];
    [viewgraph addSubview:lineChart];
}

-(void)MakeLineChartThree
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    
    self.lineChart = [[ZFLineChart alloc] initWithFrame:viewgraph.bounds];
    self.lineChart.dataSource = self;
    self.lineChart.delegate = self;
    self.lineChart.topicLabel.text = @"LINE CHART";
    self.lineChart.unit = @"人";
    self.lineChart.topicLabel.textColor = ZFWhite;
    self.lineChart.isShowYLineSeparate = YES;
    self.lineChart.isResetAxisLineMinValue = YES;
    self.lineChart.isShadow = NO;
    self.lineChart.unitColor = ZFWhite;
    self.lineChart.backgroundColor = ZFPurple;
    self.lineChart.xAxisColor = ZFWhite;
    self.lineChart.yAxisColor = ZFWhite;
    self.lineChart.axisLineNameColor = ZFWhite;
    self.lineChart.axisLineValueColor = ZFWhite;
    self.lineChart.xLineNameLabelToXAxisLinePadding = 50;
    [self.lineChart strokePath];
    [viewgraph addSubview:self.lineChart];
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@[@"-52", @"300", @"490", @"380", @"167", @"720"],
             @[@"380", @"200", @"326", @"240", @"-258", @"680"],
             @[@"256", @"300", @"-89", @"430", @"256", @"700"]
             ];
    
    
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"January", @"February", @"March", @"April", @"May", @"June", @"July",@"August",@"September",@"October",@"November"];
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFSkyBlue, ZFOrange, ZFMagenta];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 800;
}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 8;
}

#pragma mark - ZFLineChartDelegate

- (CGFloat)groupWidthInLineChart:(ZFLineChart *)lineChart{
    return 30.f;
}

- (CGFloat)paddingForGroupsInLineChart:(ZFLineChart *)lineChart{
    return 50.f;
}

- (CGFloat)circleRadiusInLineChart:(ZFLineChart *)lineChart{
    return 7.f;
}

- (CGFloat)lineWidthInLineChart:(ZFLineChart *)lineChart{
    return 2.f;
}

- (NSArray *)valuePositionInLineChart:(ZFLineChart *)lineChart{
    return @[@(kChartValuePositionOnTop), @(kChartValuePositionDefalut), @(kChartValuePositionOnBelow)];
}

#pragma mark - ZFLineChartDelegate

- (void)lineChart:(ZFLineChart *)lineChart didSelectCircleAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex circle:(ZFCircle *)circle popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"%ld====%ld",(long)lineIndex,(long)circleIndex);
    circle.isAnimated = YES;
    [circle strokePath];
   
}

- (void)lineChart:(ZFLineChart *)lineChart didSelectPopoverLabelAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex popoverLabel:(ZFPopoverLabel *)popoverLabel
{
    NSLog(@"%ld====%ld",(long)lineIndex,(long)circleIndex);
    
}

- (IBAction)btnBack_Tapped:(id)sender
{
 [self dismissViewControllerAnimated:YES completion:nil];
}

@end
