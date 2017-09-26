//
//  CSVFileView.m
//  ChartModels
//
//  Created by Manickam on 07/08/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "CSVFileView.h"

@interface CSVFileView ()
@end

@implementation CSVFileView
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializMapdata];
    // Do any additional setup after loading the view.
}
-(void)initializMapdata{
    arrForBool=[[NSMutableArray alloc]init];
    arrSectionTiles=[[NSArray alloc]initWithObjects:@"iOS",@"Blackberry",@"Androide", nil];
    
    for (int i=0; i<[arrSectionTiles count]; i++) {
        [arrForBool addObject:[NSNumber numberWithBool:NO]];
    }
    [_MapPrty_Tblviw reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView DataSource and Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrSectionTiles count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[arrForBool objectAtIndex:section]boolValue]) {
        return section+5;
    }
    else
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"DataCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    //many cells check    *suppose section to be closed*
    BOOL manycells=[[arrForBool objectAtIndex:indexPath.section] boolValue];
    if(!manycells){
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.text=@"";
    }
    //Display hold rows set values *Section opened *
    else{
        cell.textLabel.text=[NSString stringWithFormat:@"%@ %ld",[arrSectionTiles objectAtIndex:indexPath.section],indexPath.row+1];
        cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
        cell.backgroundColor=[UIColor whiteColor];
        cell.imageView.image=[UIImage imageNamed:@"if_plus_1282963.png"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
    }
 
    cell.textLabel.textColor=[UIColor redColor];
    
    //******Add custom sepreate with cells******//
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _MapPrty_Tblviw.frame.size.width-15, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:separatorLineView];
    return cell;
  }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Close the section once the data selected
    [arrForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
    
    [_MapPrty_Tblviw reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if ([[arrForBool objectAtIndex:indexPath.section]boolValue]) {
        return 40;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma - mark Creating View for Table View Section 
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0,0 ,280 ,40 )];
    sectionView.tag=section;
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, _MapPrty_Tblviw.frame.size.width-10,40)];
    viewLabel.backgroundColor=[UIColor clearColor];
    viewLabel.textColor=[UIColor redColor];
    viewLabel.font=[UIFont systemFontOfSize:15];
    viewLabel.text=[NSString stringWithFormat:@"Mobile %@",[arrSectionTiles objectAtIndex:section]];
    [sectionView addSubview:viewLabel];
    
//      *Add a custom Separator with Section view *
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _MapPrty_Tblviw.frame.size.width-15, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor];
    [sectionView addSubview:separatorLineView];

//      *Add UITapGestureRecognizer to SectionView*
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    
    return sectionView;
}

#pragma mark - Table header gesture tapped
-(void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row==0) {
        BOOL collapsed=[[arrForBool objectAtIndex:indexPath.section]boolValue];
        for (int i=0;i<[arrSectionTiles count];i++ ) {
            if (indexPath.section==i) {
                [arrForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        [_MapPrty_Tblviw reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}


@end
