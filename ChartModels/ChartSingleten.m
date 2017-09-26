//
//  ChartSingleten.m
//  ChartModels
//
//  Created by Manickam on 24/07/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "ChartSingleten.h"

@implementation ChartSingleten

+(id)sharedinstence
{
    static ChartSingleten *sharedSingletons = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingletons = [[self alloc] init];
    });
    return sharedSingletons;
    
}
@end
