//
//  ChartsSchemvc.m
//  ChartModels
//
//  Created by Manickam on 23/08/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "ChartsSchemView.h"
#import "SamplechartView.h"


@interface ChartsSchemView () <removeviewdelegate>
{
    ChartGroups *chartgroup;
    UIView *HoleChartView;
}
@end

@implementation ChartsSchemView


- (void)viewDidLoad {
    [super viewDidLoad];
    chartgroup=[[ChartGroups alloc]init];
    if ([self.strChartName isEqualToString:@"map chart"]) {
        [self CustomMapChart:nil];
    }else if ([self.strChartName isEqualToString:@"pie chart"]){
        [self CustomPieChart:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)DismisTouch:(id)sender {
    [HoleChartView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
     NSLog(@"diss btn Fired.....@");
}
//Methods for Selected Charts Will be User Customozed.

-(void)CustomMapChart:(NSString *)value{
    UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SamplechartView *chartschem=(SamplechartView *)[mainstoryboard instantiateViewControllerWithIdentifier:@"mapchrt"];
//    chartschem.strChartName=Cname;
//    [self.view addSubview:chartschem.view];
     chartschem.delegate=self;
    HoleChartView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    HoleChartView.backgroundColor=[UIColor whiteColor];
    
    [HoleChartView addSubview:chartschem.view];
    [self.view addSubview:HoleChartView];
}
-(void)CustomPieChart:(NSString *)value{
    HoleChartView=[[UIView alloc]initWithFrame:CGRectMake(200, 100, 600, 400)];
    HoleChartView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:HoleChartView];
}
-(void)removeMapView{
    [HoleChartView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
