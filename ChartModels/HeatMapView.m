//
//  HeatMapView.m
//  ChartModels
//
//  Created by Vijayaamirtharaj on 17/02/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "HeatMapView.h"
#import "UIImage+HeatMap.h"

enum segmentedControlIndicies {
    kSegmentStandard = 0,
    kSegmentSatellite = 1,
    kSegmentHybrid = 2,
    kSegmentTerrain = 3
};

@interface HeatMapView ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *heatImageView;
@property (nonatomic) NSMutableArray *locations;
@property (nonatomic) NSMutableArray *weights;

@end

@implementation HeatMapView
{
    __weak IBOutlet UIView *viewgraph;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"quake" ofType:@"plist"];
    NSArray *quakeData = [[NSArray alloc] initWithContentsOfFile:dataFile];
    
    self.locations = [[NSMutableArray alloc] initWithCapacity:[quakeData count]];
    self.weights = [[NSMutableArray alloc] initWithCapacity:[quakeData count]];
    for (NSDictionary *reading in quakeData) {
        CLLocationDegrees latitude = [[reading objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude = [[reading objectForKey:@"longitude"] doubleValue];
        double magnitude = [[reading objectForKey:@"magnitude"] doubleValue];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [self.locations addObject:location];
        
        [self.weights addObject:[NSNumber numberWithInteger:(magnitude * 10)]];
    }
    
    
    // set map region
    self.mapView.delegate = self;
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.0, -77.0), MKCoordinateSpanMake(10.0, 13.0));

}
#pragma mark - map delegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:[self.locations count]];
    for (int i = 0; i < self.locations.count; i++) {
        CLLocation *location = [self.locations objectAtIndex:i];
        CGPoint point = [self.mapView convertCoordinate:location.coordinate toPointToView:self.mapView];
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    self.heatImageView.image = [UIImage heatMapWithRect:self.mapView.bounds boost:0.8 points:points weights:self.weights weightsAdjustmentEnabled:NO groupingEnabled:YES];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    return [[MKOverlayRenderer alloc] initWithOverlay:overlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (IBAction)mapTypeChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case kSegmentStandard:
            self.mapView.mapType = MKMapTypeStandard;
            break;
            
        case kSegmentSatellite:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
            
        case kSegmentHybrid:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        case kSegmentTerrain:
            self.mapView.mapType = 3;
            break;
    }
}
- (IBAction)btnBack_Tapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
