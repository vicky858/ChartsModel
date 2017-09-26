//
//  HistogramView.m
//  ChartModels
//
//  Created by Vijayaamirtharaj on 20/02/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "HistogramView.h"
#import "WHChartView.h"
#import "UIColor+WHColor.h"

@interface HistogramView ()
{
    WHChartView *chart;
}

@end

@implementation HistogramView
{
    __weak IBOutlet UIView *viewgraph;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self one];
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
        
        [self one];
    }
    if (selectedSegment == 1)
    {
       [self Two];
    }
    if (selectedSegment == 2)
    {
      [self Three];
    }
    if (selectedSegment == 3)
    {
        [self Four];
    }
    if (selectedSegment == 4)
    {
        [self Five];
    }
}

-(void)one
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    [viewgraph addSubview:[self chart1]];
}
-(void)Two
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    [viewgraph addSubview:[self chart2]];
}
-(void)Three
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    [viewgraph addSubview:[self chart3]];
}
-(void)Four
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    [viewgraph addSubview:[self chart4]];
}
-(void)Five
{
    for (UIView *subview in viewgraph.subviews)
    {
        [subview removeFromSuperview];
    }
    [viewgraph addSubview:[self chart5]];
}
- (WHChartView *)chart1
{
    chart = [[WHChartView alloc]initWithFrame:viewgraph.bounds];
    
    NSArray *dataValue = @[@123.5,@122,@87,@101.1,@16,@60.6,@51,@44,@20,@18,@98,@110,@19,@77];
    NSArray *xLabelString = @[@"6-10",@"6-11",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17"];
    
    /***  Coordinate ***/
    chart.title = @"Bar and Line";
    chart.colorOfTitle = [UIColor whCarrot];
    chart.colorOfXYLabel = [UIColor redColor];
    chart.colorOfAxis = [UIColor redColor];
    chart.colorOfGridding = [UIColor whGreen];
    chart.showsGridding = YES;
    chart.showsXLabel = YES;
    chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = YES;
    chart.colorOfBar = [UIColor whAsbestos];
    chart.colorOfUnusedPartOfBar = [UIColor clearColor];
    chart.showsShadowOfBar = NO;
    //chart.colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];
    //chart.angleOfShadow = 30.0;
    //chart.animationDurationOfBar = 1.5;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = YES;
    chart.lineWidth = 3.0;
    //chart.colorOfLine = [UIColor blackColor];
    //chart.animationDurationOfLine = 1.5;
    
    chart.smoothesLine = YES;
    //chart.kOfBezierPath = 0.25;
    chart.showsGradientColor = YES;
    chart.gradientColors = [NSArray arrayWithObjects:(id)[UIColor whGreen].CGColor ,(id)[UIColor whOrange].CGColor,(id)[UIColor whAlizarin].CGColor, nil];
    chart.gradientLocations = @[@0.2,@0.5,@0.9 ];
    chart.gradientStartPoint = CGPointMake(0.5, 0);
    chart.gradientEndPoint = CGPointMake(0.5, 1);
    
    
    [chart setChartData:dataValue];
    [chart strokeChart];
    
    return chart;
}


- (WHChartView *)chart2
{
    chart = [[WHChartView alloc]initWithFrame:viewgraph.bounds];
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:140];
    for(int i=0;i<140;i++) {
        float r = rand()%100 /100.0  + 7.0 - i/20.0;
        [data addObject:[NSNumber numberWithFloat:r]];
    }
    
    
    /***  Coordinate ***/
    chart.title = @"Line Only";
    chart.colorOfTitle = [UIColor whCarrot];
    chart.colorOfXYLabel = [UIColor brownColor];
    chart.colorOfAxis = [UIColor brownColor];
    chart.colorOfGridding = [UIColor whGreen];
    chart.showsGridding = YES;
    chart.showsXLabel = NO;
    
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = NO;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = YES;
    chart.lineWidth = 3.0;
    chart.smoothesLine = YES;
    //chart.kOfBezierPath = 0.25;
    chart.showsGradientColor = YES;
    chart.gradientColors = [NSArray arrayWithObjects:(id)[UIColor whAlizarin].CGColor ,(id)[UIColor whCarrot].CGColor,(id)[UIColor whLightBlue].CGColor, nil];
    //chart.gradientLocations = @[@0.2,@0.5,@0.9 ];         //Using default value;
    //chart.gradientStartPoint = CGPointMake(0.5, 0);       //Using default value;
    //chart.gradientEndPoint = CGPointMake(0.5, 1);         //Using default value;
    
    [chart setChartData:data];
    [chart strokeChart];
    
    return chart;
}
- (WHChartView *)chart3
{
    chart = [[WHChartView alloc]initWithFrame:viewgraph.bounds];
    
    NSArray *dataValue = @[@123.5,@122,@87,@101.1,@16,@60.6,@51,@44,@20,@18,@98,@110,@19,@77];
    NSArray *xLabelString = @[@"6-10",@"6-11",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17"];
    
    /***  Coordinate ***/
    chart.title = @"Bar only";
    chart.colorOfTitle = [UIColor whCarrot];
    chart.colorOfXYLabel = [UIColor brownColor];
    chart.colorOfAxis = [UIColor brownColor];
    chart.colorOfGridding = [UIColor whGreen];
    chart.showsGridding = YES;
    chart.showsXLabel = YES;
    chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = YES;
    chart.colorOfBar = [UIColor whLightBlue];
    chart.colorOfUnusedPartOfBar = [UIColor clearColor];
    chart.showsShadowOfBar = YES;
    //chart.colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];         //Using default value;
    //chart.angleOfShadow = 30.0;                           //Using default value;
    //chart.animationDurationOfBar = 1.5;                   //Using default value;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = NO;

    
    chart.smoothesLine = YES;
    //chart.kOfBezierPath = 0.25;                           //Using default value;
    chart.showsGradientColor = YES;
    
    
    
    [chart setChartData:dataValue];
    [chart strokeChart];
    
    return chart;
}

- (WHChartView *)chart4
{
    chart = [[WHChartView alloc]initWithFrame:viewgraph.bounds];
    
    NSArray *dataValue = @[@123.5,@122,@87,@101.1,@16,@60.6,@51,@44,@20,@18,@98,@110,@19,@77];
    NSArray *xLabelString = @[@"6-10",@"6-11",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17"];
    
    /***  Coordinate ***/
    chart.title = @"Unused part of bar";
    chart.colorOfTitle = [UIColor whLightGreen];
    chart.colorOfXYLabel = [UIColor brownColor];
    chart.colorOfAxis = [UIColor whOrange];
    chart.colorOfGridding = [UIColor whGreen];
    chart.showsGridding = YES;
    chart.showsXLabel = YES;
    chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = YES;
    chart.colorOfBar = [UIColor whCarrot];
    chart.colorOfUnusedPartOfBar = [UIColor whSilverWithAlpha:0.8];
    chart.showsShadowOfBar = NO;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = NO;
    
    chart.smoothesLine = YES;
    //chart.kOfBezierPath = 0.25;
    chart.showsGradientColor = YES;
    
    
    [chart setChartData:dataValue];
    [chart strokeChart];
    
    return chart;
}

- (WHChartView *)chart5
{
    chart = [[WHChartView alloc]initWithFrame:viewgraph.bounds];
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:140];
    for(int i=0;i<50;i++) {
        float r = rand()%100 /100.0  + 2.5 - i/20.0;
        [data addObject:[NSNumber numberWithFloat:r]];
    }
    
    /***  Coordinate ***/
    chart.title = @"Broken line graph";
    chart.colorOfTitle = [UIColor whAlizarin];
    chart.colorOfXYLabel = [UIColor blueColor];
    chart.colorOfAxis = [UIColor redColor];
    chart.colorOfGridding = [UIColor whCarrot];
    chart.showsGridding = YES;
    chart.showsXLabel = NO;
    //chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = NO;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = YES;
    chart.lineWidth = 4.0;
    chart.colorOfLine = [UIColor whAsbestos];
    chart.animationDurationOfLine = 1.5;
    
    chart.smoothesLine = NO;
    chart.kOfBezierPath = 0.55;
    chart.showsGradientColor = NO;
    
    
    [chart setChartData:data];
    [chart strokeChart];
    
    return chart;
}



- (IBAction)btnBack_Tapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
