//
//  CollectionOfDataView.m
//  ChartModels
//
//  Created by Manickam on 31/07/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "CollectionOfDataView.h"
#import "dateCollectViewCell.h"
#import "contentCollectvewCell.h"
#import "SQLiteManager.h"
#import "ChartSingleten.h"
#import "FMResultSet.h"
#import "FSSVGPathElement.h"


@interface CollectionOfDataView ()
{
    NSArray *allkeys;
    SQLiteManager *sqmng;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property(strong,nonatomic)NSArray *theData;


@end

@implementation CollectionOfDataView


- (void)viewDidLoad {
    [super viewDidLoad];
  sqmng=[[SQLiteManager alloc]init];
}
-(void)viewDidAppear:(BOOL)animated
{
    [_collectionview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark UIcollection view Delegates
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return [_datacolltionDict allKeys].count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:section]];
    return arrItems.count;
    
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0) {
        if ([indexPath row]==0) {
            dateCollectViewCell *datecell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dateCellIdentifier" forIndexPath:indexPath];
            datecell.backgroundColor=[UIColor whiteColor];
            datecell.lblDate.font =[UIFont fontWithName:@"Sansation-Light" size:14.0];
            datecell.lblDate.textColor =[UIColor blackColor];
            NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:indexPath.section]];
            datecell.lblDate.text= [arrItems objectAtIndex:indexPath.row];
            datecell.backgroundColor=[UIColor darkGrayColor];
            return datecell;
    }
        else{
            
            contentCollectvewCell *contentCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCellIdentifier" forIndexPath:indexPath];
        
            contentCell.lblContent.font=[UIFont fontWithName:@"Sansation-Light" size:14.0];
            NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:indexPath.section]];
            contentCell.lblContent.text= [arrItems objectAtIndex:indexPath.row];
            contentCell.lblContent.textColor=[UIColor blackColor];
            
            if ([indexPath section]%2 !=0) {
                contentCell.backgroundColor=[UIColor colorWithWhite:242/255.0 alpha:1.0];
            }else{
                contentCell.backgroundColor=[UIColor whiteColor];
            }
            return contentCell;
            
         }
    }
    else{
        if ([indexPath row]==0) {
            dateCollectViewCell *datecell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dateCellIdentifier" forIndexPath:indexPath];
            datecell.backgroundColor=[UIColor whiteColor];
            datecell.lblDate.font =[UIFont fontWithName:@"Sansation-Light" size:14.0];
            datecell.lblDate.textColor =[UIColor blackColor];
//            datecell.lblDate.text = [NSString stringWithFormat:@"%ld",(long)[indexPath section]];
            if ([indexPath section]%2 !=0) {
                datecell.backgroundColor=[UIColor colorWithWhite:242/255.0 alpha:1.0];
            }else{
                datecell.backgroundColor=[UIColor whiteColor];
            }
            datecell.backgroundColor=[UIColor darkGrayColor];
            NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:indexPath.section]];
            datecell.lblDate.text = [arrItems objectAtIndex:indexPath.row];
            return datecell;
        }
        else{
            
            contentCollectvewCell *contentCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCellIdentifier" forIndexPath:indexPath];
            
            NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:indexPath.section]];            
            contentCell.lblContent.font=[UIFont fontWithName:@"Sansation-Light" size:14.0];
            contentCell.lblContent.text = [arrItems objectAtIndex:indexPath.row];
            contentCell.lblContent.textColor=[UIColor blackColor];
            
            if ([indexPath section]%2 !=0) {
                contentCell.backgroundColor=[UIColor colorWithWhite:242/255.0 alpha:1.0];
            }else{
                contentCell.backgroundColor=[UIColor whiteColor];
            }
            return contentCell;
            
        }
    }
    
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:indexPath.section]];
    
    NSString *sec=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
    NSString *row=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"section:%@ /n Row:%@",sec,row);
    NSMutableArray *Arr_data=[[NSMutableArray alloc]init];
    for (NSString *St in [_datacolltionDict allKeys] ) {
        NSArray *arr=[_datacolltionDict objectForKey:St];
        [Arr_data addObject:[arr objectAtIndex:indexPath.row]];
        
    }
    NSLog(@"%@",Arr_data);
    
      FMResultSet *fmr=[sqmng ExecuteQuery:[NSString stringWithFormat:@"select * from %@ where %@",_str_TablName,Arr_data[0]]];
     ChartSingleten *Singleton=[ChartSingleten sharedinstence];
    while ([fmr next]) {
        Singleton.str_csvdata=[fmr stringForColumn:@"state"];
        Singleton.str_population=[fmr stringForColumn:@"pop_est_2014"];
    }
    
   
    
    
    
//    for (int i=0; i<arrItems.count;i++ ) {
//        
//        
//    }
// 
//    NSLog(@"should");
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
   
//    cell.contentView.backgroundColor = [UIColor greenColor];
  }
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
////     NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:indexPath.section]];
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor greenColor];
//
//}
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSArray *arrItems = [_datacolltionDict objectForKey:[[_datacolltionDict allKeys] objectAtIndex:indexPath.section]];
//   ≈}
//

- (IBAction)Btn_actApplydata:(id)sender {
    
    [self.delegate sendCSVdict:_datacolltionDict];
    
    NSString *strqury=[NSString stringWithFormat:@"delete from %@",_str_TablName];
    [sqmng ExecuteUpdateQuery:strqury];
    
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
