//
//  LibrayHomeView.m
//  ChartModels
//
//  Created by Manickam on 10/08/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "LibrayHomeView.h"
#import "ChartGroups.h"
#import "SamplechartView.h"
#import "ChartsSchemView.h"

@interface LibrayHomeView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *viwDetail;
    UITableView *Tbl_datasrc;
    UICollectionView *ColViw_charts;
    UICollectionView *Col_chrtShm;
}
@end

@implementation LibrayHomeView
{
    __weak IBOutlet UIButton *btn_hom;
    __weak IBOutlet UIButton *btn_datasrc;
    __weak IBOutlet UIButton *btn_chrtshm;
    __weak IBOutlet UIButton *btn_dashbrd;
    __weak IBOutlet UIImageView *img_hom;
    __weak IBOutlet UIImageView *img_datasrc;
    __weak IBOutlet UIImageView *img_chrtshm;
    __weak IBOutlet UIImageView *img_dashbrd;
    __weak IBOutlet UIButton *btn_demo;
    __weak IBOutlet UIImageView *img_demo;
    NSMutableArray *Arrcsvfiledata;
    NSArray *csvFiles;
    NSMutableArray *arrchrtlist;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [viwDetail removeFromSuperview];
    [Tbl_datasrc removeFromSuperview];
    btn_hom.layer.cornerRadius=25.0f;
    btn_datasrc.layer.cornerRadius=25.0f;
    btn_chrtshm.layer.cornerRadius=25.0f;
    btn_dashbrd.layer.cornerRadius=25.0f;
    btn_demo.layer.cornerRadius=25.0f;
    arrchrtlist=[[NSMutableArray alloc]init];
    for (int i=0;i<4;i++ ) {
        ChartGroups *cg=[[ChartGroups alloc]init];
        if (i==0) {
            cg.chrttype=@"map chart";
        }
        else if (i==1) {
            cg.chrttype=@"pie chart";
        }
        else if (i==2) {
            cg.chrttype=@"bar chart";
        }
        else if (i==3){
            cg.chrttype=@"3D chart";
        }
        
        [arrchrtlist addObject:cg];
    }
    
    
    
    //Get .CSV file from local bundle
    Arrcsvfiledata=[[NSMutableArray alloc]init];
    NSArray *dirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSBundle mainBundle] bundlePath] error:nil];
    csvFiles = [dirFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.csv'"]];
    for (NSString *fileName in csvFiles) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        [Arrcsvfiledata addObject:url];
    }
    NSLog(@"csv file ::%@",Arrcsvfiledata);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)btn_tailergrp:(id)sender {
    UIButton *btnSender = (UIButton*)sender;
    if (btnSender.tag ==0) {
        [Col_chrtShm removeFromSuperview];
        [ColViw_charts removeFromSuperview];
        [viwDetail removeFromSuperview];
        [Tbl_datasrc removeFromSuperview];
        [self addsubviw];
        btn_hom.backgroundColor=[UIColor whiteColor];
        viwDetail.backgroundColor=[UIColor whiteColor];
        btn_datasrc.backgroundColor=[UIColor clearColor];
        btn_chrtshm.backgroundColor=[UIColor clearColor];
        btn_dashbrd.backgroundColor=[UIColor clearColor];
        btn_demo.backgroundColor=[UIColor clearColor];
    }
    else if (btnSender.tag==1){
        [Col_chrtShm removeFromSuperview];
        [ColViw_charts removeFromSuperview];
        [viwDetail removeFromSuperview];
        [Tbl_datasrc removeFromSuperview];
        [self addTblviw];
        btn_hom.backgroundColor=[UIColor clearColor];
        
        viwDetail.backgroundColor=[UIColor grayColor];
        btn_datasrc.backgroundColor=[UIColor whiteColor];
        btn_chrtshm.backgroundColor=[UIColor clearColor];
        btn_dashbrd.backgroundColor=[UIColor clearColor];
        btn_demo.backgroundColor=[UIColor clearColor];
    }
    else if (btnSender.tag==2){
        [Col_chrtShm removeFromSuperview];
        [ColViw_charts removeFromSuperview];
        [Tbl_datasrc removeFromSuperview];
        
        [viwDetail removeFromSuperview];
        [self addColectionViewTwo];
        btn_hom.backgroundColor=[UIColor clearColor];
        
        viwDetail.backgroundColor=[UIColor blueColor];
        btn_datasrc.backgroundColor=[UIColor clearColor];
        btn_chrtshm.backgroundColor=[UIColor whiteColor];
        btn_dashbrd.backgroundColor=[UIColor clearColor];
        btn_demo.backgroundColor=[UIColor clearColor];
    }
    
    else if (btnSender.tag==3){
        [Col_chrtShm removeFromSuperview];
        [ColViw_charts removeFromSuperview];
        [Tbl_datasrc removeFromSuperview];
        [viwDetail removeFromSuperview];
        [self addsubviw];
        viwDetail.backgroundColor=[UIColor yellowColor];
        btn_hom.backgroundColor=[UIColor clearColor];
        btn_datasrc.backgroundColor=[UIColor clearColor];
        btn_chrtshm.backgroundColor=[UIColor clearColor];
        btn_dashbrd.backgroundColor=[UIColor whiteColor];
        btn_demo.backgroundColor=[UIColor clearColor];
    }
    else if (btnSender.tag==4){
        [Col_chrtShm removeFromSuperview];
        [ColViw_charts removeFromSuperview];
        [Tbl_datasrc removeFromSuperview];
        btn_demo.backgroundColor=[UIColor whiteColor];
        btn_hom.backgroundColor=[UIColor clearColor];
        btn_datasrc.backgroundColor=[UIColor clearColor];
        btn_chrtshm.backgroundColor=[UIColor clearColor];
        btn_dashbrd.backgroundColor=[UIColor clearColor];
        [viwDetail removeFromSuperview];
        //        [viwDetail removeFromSuperview];
        //        for (UIView *viw in self.view.subviews) {
        //            if ([viw isKindOfClass:[UIView class]]) {
        //                [viw removeFromSuperview];
        //            }
        //        }
    }
    
}
#pragma - mark add view methods
-(void)addTblviw{
    Tbl_datasrc = [[UITableView alloc] initWithFrame:CGRectMake(226, 0, 400, 768)];
    Tbl_datasrc.contentMode = UIViewContentModeScaleAspectFit;
    Tbl_datasrc.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    Tbl_datasrc.delegate=self;
    Tbl_datasrc.dataSource=self;
    Tbl_datasrc.backgroundColor=[UIColor clearColor];
    [self.view addSubview:Tbl_datasrc];
}
-(void)addsubviw{
    viwDetail = [[UIView alloc] initWithFrame:CGRectMake(226, 0, 798, 768)];
    viwDetail.contentMode = UIViewContentModeScaleAspectFit;
    viwDetail.alpha=0.5;
    [self.view addSubview:viwDetail];
}
-(void)addColectionView{
    [Col_chrtShm removeFromSuperview];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    ColViw_charts=[[UICollectionView alloc]initWithFrame:CGRectMake(626, 0, 398, 768) collectionViewLayout:layout];
    ColViw_charts.delegate=self;
    ColViw_charts.dataSource=self;
    [ColViw_charts registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellcoll"];
    ColViw_charts.backgroundColor=[UIColor clearColor];
    ColViw_charts.tag=1;
    [self.view addSubview:ColViw_charts];
}
-(void)addColectionViewTwo{
    [ColViw_charts removeFromSuperview];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    Col_chrtShm=[[UICollectionView alloc]initWithFrame:CGRectMake(226, 0, 798, 768) collectionViewLayout:layout];
    Col_chrtShm.delegate=self;
    Col_chrtShm.dataSource=self;
    Col_chrtShm.tag=2;
    [Col_chrtShm registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    Col_chrtShm.backgroundColor=[UIColor clearColor];
    Col_chrtShm.tag=2;
    [self.view addSubview:Col_chrtShm];
}
#pragma mark - TableView DataSource Implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == Tbl_datasrc) { // your tableView you had before
        return [csvFiles count]; // or other number, that you want
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.backgroundView = [[UIView alloc] init];
    [cell.backgroundView setBackgroundColor:[UIColor clearColor]];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.layoutMargins=UIEdgeInsetsZero;
    cell.separatorInset=UIEdgeInsetsZero;
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[csvFiles objectAtIndex:indexPath.row]];
    //    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row + 1];
    cell.imageView.image=[UIImage imageNamed:@"csvFile.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Testing..........@");
    [ColViw_charts removeFromSuperview];
    [self addColectionView];
    
}
#pragma mark - CollectionView DataSource Implementation
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag ==1) {
        return [arrchrtlist count];
    }
    else if (collectionView.tag == 2){
        return [arrchrtlist count];
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==1) {
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellcoll" forIndexPath:indexPath];
        UIImageView *ImgChrts=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 370, 200)];
        UIImage *image=[UIImage imageNamed:@"mapchrt.PNG"];
        ImgChrts.image=(image);
        UIImageView *infoimg=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-35, cell.frame.size.height-35, 30, 30)];
        UIImage *info=[UIImage imageNamed:@"info.png"];
        infoimg.image=(info);
        [ImgChrts addSubview:infoimg];
        [cell.contentView addSubview:ImgChrts];
        
        cell.backgroundColor=[UIColor lightGrayColor];
        return cell;
    }
    else if (collectionView.tag==2){
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
        UIImageView *ImgChrts=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 250)];
        UIImage *image=[UIImage imageNamed:@"mapchrt.PNG"];
        ImgChrts.image=(image);
        UIImageView *infoimg=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-35, cell.frame.size.height-35, 30, 30)];
        UIImage *info=[UIImage imageNamed:@"info.png"];
        infoimg.image=(info);
        [ImgChrts addSubview:infoimg];
        
        [cell.contentView addSubview:ImgChrts];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==1) {
        return CGSizeMake(370, 200);
    }
    else
        return CGSizeMake(390, 250);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ChartGroups *cg=[arrchrtlist objectAtIndex:indexPath.row];
    NSLog(@"%@",cg.chrttype);
    if ([cg.chrttype isEqualToString:@"map chart"]){
        //forward to Custom Chart View  [ChartsSchemView]
        [self callchartschemview:cg.chrttype];
    }else if ([cg.chrttype isEqualToString:@"pie chart"]){
        //forward to Custom Chart View [ChartsSchemView]
        [self callchartschemview:cg.chrttype];
    }
}
#pragma - mark call story via identifier
-(void)callchartschemview:(NSString *)Cname{
    UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChartsSchemView *chartschem=(ChartsSchemView *)[mainstoryboard instantiateViewControllerWithIdentifier:@"allchrtview"];
    chartschem.strChartName=Cname;
    [self presentViewController:chartschem animated:YES completion:nil];
}

@end
