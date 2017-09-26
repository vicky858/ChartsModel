//
//  PieChartViewController.m
//  MBMCharts
//
//  Created by Pat Murphy on 12/13/12.
//  Copyright (c) 2012 Pat Murphy. All rights reserved.
//

#import "PieChartViewController.h"
#import "MBMChartDefines.h"
#import "UIColorCategory.h"
#import <QuartzCore/QuartzCore.h>

@implementation PieChartViewController

@synthesize pieChartRight = _pieChartRight;
@synthesize pieChartLeft = _pieChartLeft;
@synthesize selectedSliceLabel = _selectedSliceLabel;

@synthesize pieDicArray = _pieDicArray;
@synthesize pieChartDataArray = _pieChartDataArray;
@synthesize pieChartConfigArray = _pieChartConfigArray;

#pragma mark - View lifecycle

//- (void)loadView
//{
//	if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&
//		[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//	{
//		[[NSBundle mainBundle] loadNibNamed:@"PieChartViewController-iPad" owner:self options:nil];
//	}
//	else
//	{
//		[[NSBundle mainBundle] loadNibNamed:@"PieChartViewController" owner:self options:nil];
//	}
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Pie Charts";
	//rotate up arrow
   

	_pieDicArray = [[NSMutableArray alloc] init];
	_pieChartDataArray = [[NSMutableArray alloc] init];
	_pieChartConfigArray = [[NSMutableArray alloc] init];

    [_selectedSliceLabel setText:@""];

	[self setUpChart];
}

-(NSString*)getRandomColor
{
    NSInteger baseInt = arc4random() % 16777216;
    NSString *hexColor = [NSString stringWithFormat:@"%06X", baseInt];
	return hexColor;
}

-(NSNumber*)getRandomNum:(BOOL)type seed:(int)seed
{
	int seedType = 20;
	if(type)
		seedType = 40;
	
	NSNumber *randomNum = [NSNumber numberWithInt:arc4random()%seed+seedType];
	return randomNum;
}

-(NSMutableArray*)createPieChart:(NSDictionary *)dataDic
{
	int seedInt = [[dataDic objectForKey:@"SEED"] intValue];;
    int slices = [[dataDic objectForKey:@"SLICES"] intValue];
    NDLog(@"PieChartVCtrl : createPieChart : dataDic = %@", dataDic);
    
    NSMutableArray *sliceChartDataArray = [[NSMutableArray alloc] init];
    for (int row = 0; row < slices; row++)
    {
        NSString *color = [self getRandomColor];
        NSNumber *value = [self getRandomNum:NO seed:seedInt];
        NSDictionary *chartData = [NSDictionary dictionaryWithObjectsAndKeys:value,@"Value",color,@"Color",nil];
		[sliceChartDataArray addObject:chartData];
    }
    
    NDLog(@"PieChartVCtrl : createPieChart : sliceChartDataArray = %@", sliceChartDataArray);
	return sliceChartDataArray;
}

- (void) setUpChart
{
	NSDictionary *chartConfigData = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"ShowPercentage",@"ff0000",@"LabelColor",@"0000ff",@"ValueShadowColor",nil];
	[_pieChartConfigArray addObject:chartConfigData];
	
    NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:100],@"SEED",[NSNumber numberWithInt:12],@"SLICES",nil];
    [_pieChartDataArray setArray:[self createPieChart:dataDic]];

    for (NSDictionary *pieInfo in self.pieChartDataArray)
	{
		NSNumber *pieValue = [NSNumber numberWithFloat:[[pieInfo objectForKey:@"Value"] floatValue]];
		UIColor *pieColor = [UIColor colorWithHexRGB:[pieInfo objectForKey:@"Color"] AndAlpha:1.0];
		NSDictionary *pieDic = [NSDictionary dictionaryWithObjectsAndKeys:pieValue,@"PieValue",pieColor,@"PieColor",nil];
		[_pieDicArray addObject:pieDic];
	}
	
	[self.pieChartLeft setChartDelegate:self];
    [self.pieChartLeft setChartDataSource:self];
    [self.pieChartLeft setStartPieAngle:M_PI_2];
	[self.pieChartLeft setAnimationSpeed:1.0];
	[self.pieChartLeft setShowPercentage:[[[self.pieChartConfigArray objectAtIndex:0] objectForKey:@"ShowPercentage"] boolValue]];
	[self.pieChartLeft setLabelShadowColor:[UIColor colorWithHexRGB:[[self.pieChartConfigArray objectAtIndex:0] objectForKey:@"ValueShadowColor"] AndAlpha:1]];
	[self.pieChartLeft setPieCenter:CGPointMake(self.pieChartLeft.frame.size.width/2, self.pieChartLeft.frame.size.height/2)];
	
//	CGRect percentageFrame = self.percentageLabel.frame;
//	percentageFrame.origin.x = self.pieChartLeft.frame.size.width/2 - self.percentageLabel.frame.size.width/2;
//	percentageFrame.origin.y = self.pieChartLeft.frame.size.height/2 - self.percentageLabel.frame.size.height/2;
//    self.percentageLabel.frame = percentageFrame;
	
	if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&
		[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
		[self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
	}
	else
	{
		[self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:12]];
	}
	
    [self.pieChartRight setChartDelegate:self];
    [self.pieChartRight setChartDataSource:self];
	[self.pieChartRight setStartPieAngle:M_PI_2];
    [self.pieChartRight setAnimationSpeed:1.0];
	[self.pieChartRight setShowPercentage:NO];
	[self.pieChartRight setLabelColor:[UIColor colorWithHexRGB:[[self.pieChartConfigArray objectAtIndex:0] objectForKey:@"LabelColor"] AndAlpha:1]];
	[self.pieChartRight setPieCenter:CGPointMake(self.pieChartRight.frame.size.width/2, self.pieChartRight.frame.size.height/2)];
//	if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&
//		[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//	{
//		[self.percentageLabel.layer setCornerRadius:90];
//	}
//	else
//	{
//		[self.percentageLabel.layer setCornerRadius:15];
//	}

}

- (void)viewDidUnload
{
    [self setPieChartLeft:nil];
    [self setPieChartRight:nil];
//    [self setPercentageLabel:nil];
    [self setSelectedSliceLabel:nil];
   
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - MBMPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(MBMPieChart *)pieChart
{
    return self.pieDicArray.count;
}

- (CGFloat)pieChart:(MBMPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
	return [[[self.pieDicArray objectAtIndex:index] objectForKey:@"PieValue"] floatValue];
}

- (UIColor *)pieChart:(MBMPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
	return [[self.pieDicArray objectAtIndex:index] objectForKey:@"PieColor"];
}

#pragma mark - MBMPieChart Delegate
- (void)pieChart:(MBMPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
	int value = [[[self.pieDicArray objectAtIndex:index] objectForKey:@"PieValue"] intValue];
    self.selectedSliceLabel.text = [NSString stringWithFormat:@"%d",value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
