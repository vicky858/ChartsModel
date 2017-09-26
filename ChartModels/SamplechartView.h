//
//  SamplechartView.h
//  ChartModels
//
//  Created by Manickam on 18/07/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol removeviewdelegate <NSObject>
-(void)removeMapView;
@end

@interface SamplechartView : UIViewController

@property(strong,nonatomic)id <removeviewdelegate>  delegate;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
