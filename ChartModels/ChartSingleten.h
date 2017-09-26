//
//  ChartSingleten.h
//  ChartModels
//
//  Created by Manickam on 24/07/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartSingleten : NSObject
@property(nonatomic,retain)NSMutableArray *states;
@property(nonatomic,retain)NSMutableArray *Arr_ScaledPathSingleTon;
@property(nonatomic,retain)NSString *str_csvdata;
@property(nonatomic,retain)NSString *str_population;


+(id)sharedinstence;
@end
