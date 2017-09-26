//
//  CollectionOfDataView.h
//  ChartModels
//
//  Created by Manickam on 31/07/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionViewLayout.h"

@protocol csvvaldelegate <NSObject>

-(void)sendCSVdict:(NSMutableDictionary *)dictcsvfile;
@end

@interface CollectionOfDataView : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic)NSMutableDictionary *datacolltionDict;
@property(strong,nonatomic)NSString *str_TablName;
@property(nonatomic,weak)id<csvvaldelegate> delegate;

@end
