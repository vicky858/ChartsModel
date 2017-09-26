//
//  SineView.m
//  ChartModels
//
//  Created by Vijayaamirtharaj on 16/02/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "SineView.h"
#import "ZFChart.h"

@interface SineView ()<ZFGenericChartDataSource, ZFWaveChartDelegate,ZFRadarChartDataSource, ZFRadarChartDelegate,ZFCirqueChartDataSource, ZFCirqueChartDelegate>
@property (nonatomic, strong) ZFWaveChart * waveChart;
@property (nonatomic, strong) ZFRadarChart * radarChart;
@property (nonatomic, strong) ZFCirqueChart * cirqueChart;
@property (nonatomic, assign) CGFloat height;

@end

@implementation SineView
{
    __weak IBOutlet UIView *viewgraph;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wave];
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
        
        [self wave];
    }
    if (selectedSegment == 1)
    {
        [self radar];
    }
    if (selectedSegment == 2)
    {
        [self Circque];
    }
}

-(void)wave
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    
    self.waveChart = [[ZFWaveChart alloc] initWithFrame:viewgraph.bounds];
    self.waveChart.dataSource = self;
    self.waveChart.delegate = self;
    self.waveChart.topicLabel.text = @"Wave Chart";
    self.waveChart.unit = @"人";
    self.waveChart.pathLineColor = ZFLightGray;
    self.waveChart.topicLabel.textColor = ZFPurple;
    [self.waveChart strokePath];
    [self.view addSubview:self.waveChart];
    [viewgraph addSubview:self.waveChart];
    
    
}

-(void)radar
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    self.radarChart = [[ZFRadarChart alloc] initWithFrame:viewgraph.bounds];
    self.radarChart.dataSource = self;
    self.radarChart.delegate = self;
    self.radarChart.unit = @" €";
    self.radarChart.itemTextColor = ZFBlue;
    self.radarChart.itemFont = [UIFont systemFontOfSize:12.f];
    self.radarChart.valueFont = [UIFont systemFontOfSize:12.f];
    self.radarChart.polygonLineWidth = 2.f;
    self.radarChart.valueType = kValueTypeDecimal;
    self.radarChart.valueTextColor = ZFOrange;
    [self.view addSubview:self.radarChart];
    [self.radarChart strokePath];
    [viewgraph addSubview:self.radarChart];
}

-(void)Circque
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    self.cirqueChart = [[ZFCirqueChart alloc] initWithFrame:viewgraph.bounds];
    self.cirqueChart.dataSource = self;
    self.cirqueChart.delegate = self;
    self.cirqueChart.textLabel.text = @"Season";
    self.cirqueChart.textLabel.textColor = ZFRed;
    self.cirqueChart.textLabel.font = [UIFont boldSystemFontOfSize:13.f];
    self.cirqueChart.isResetMaxValue = YES;
    [self.view addSubview:self.cirqueChart];
    [self.cirqueChart strokePath];
    [viewgraph addSubview:self.cirqueChart];
}

#pragma mark - ZFCirqueChartDataSource

- (NSArray *)valueArrayInCirqueChart:(ZFCirqueChart *)cirqueChart{
    return @[@"2000", @"5000", @"6500", @"3500", @"8000",@"5000", @"6500"];
}

- (id)colorArrayInCirqueChart:(ZFCirqueChart *)cirqueChart{
    //return ZFGrassGreen;
    return @[ZFRed, ZFOrange, ZFMagenta, ZFBlue, ZFPurple,ZFCyan,ZFBrown];
}

- (CGFloat)maxValueInCirqueChart:(ZFCirqueChart *)cirqueChart{
    return 10000.f;
}

#pragma mark - ZFCirqueChartDelegate

- (CGFloat)radiusForCirqueChart:(ZFCirqueChart *)cirqueChart{
    return 30.f;
}

- (CGFloat)paddingForCirqueInCirqueChart:(ZFCirqueChart *)cirqueChart{
    return 30.f;
}
//
//- (CGFloat)lineWidthInCirqueChart:(ZFCirqueChart *)cirqueChart{
//    return 15.f;
//}





#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"123", @"256", @"300", @"283", @"490", @"236", @"401", @"356", @"270", @"369", @"463", @"399",@"369", @"463", @"399"];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"item 1", @"item 2", @"item 3", @"item 4", @"item 5", @"item 6", @"item 7", @"item 8", @"item 9", @"item 10", @"item 11", @"item 12",@"item 13",
             @"item 14",@"item 15"];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 500;
}

//- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
//    return 100;
//}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 10;
}

#pragma mark - ZFRadarChartDataSource

- (NSArray *)itemArrayInRadarChart:(ZFRadarChart *)radarChart{
    return @[@"item 1", @"item 2", @"item 3", @"item 4", @"item 5", @"item 6", @"item 7", @"item 8", @"item 9"];
}

- (NSArray *)valueArrayInRadarChart:(ZFRadarChart *)radarChart{
    return @[@"4", @"10", @"4", @"9", @"7", @"8", @"3.2", @"5", @"8.4"];
}

//- (NSArray *)colorArrayInRadarChart:(ZFRadarChart *)radarChart{
//    return @[ZFRed];
//}

- (CGFloat)maxValueInRadarChart:(ZFRadarChart *)radarChart{
    return 10.f;
}

#pragma mark - ZFRadarChartDelegate

- (CGFloat)radiusForRadarChart:(ZFRadarChart *)radarChart{
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        return (viewgraph.frame.size.height - 100) / 2;
    }else{
        return (viewgraph.frame.size.width - 100) / 2;
    }
    
    //    return 100.f;
}

#pragma mark - ZFWaveChartDelegate

//- (CGFloat)groupWidthInWaveChart:(ZFWaveChart *)waveChart{
//    return 50.f;
//}

- (CGFloat)paddingForGroupsInWaveChart:(ZFWaveChart *)waveChart
{
    return 30.f;
}

- (ZFGradientAttribute *)gradientColorInWaveChart:(ZFWaveChart *)waveChart{
    ZFGradientAttribute * gradientAttribute = [[ZFGradientAttribute alloc] init];
    gradientAttribute.colors = @[(id)ZFGold.CGColor, (id)ZFWhite.CGColor];
    gradientAttribute.locations = @[@(0.0), @(0.9)];
    
    return gradientAttribute;
}

- (void)waveChart:(ZFWaveChart *)waveChart popoverLabelAtIndex:(NSInteger)index popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"%ld",(long)index);
    
}


- (IBAction)btnBack_Tapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
