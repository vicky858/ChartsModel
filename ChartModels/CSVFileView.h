//
//  CSVFileView.h
//  ChartModels
//
//  Created by Manickam on 07/08/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSVFileView : UIViewController<UITableViewDataSource,UITableViewDataSource>
{
    NSMutableArray *arrForBool;
    NSArray *arrSectionTiles;
}

@property (weak, nonatomic) IBOutlet UITableView *MapPrty_Tblviw;

@end
