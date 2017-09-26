//
//  SamplechartView.m
//  ChartModels
//
//  Created by Manickam on 18/07/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "SamplechartView.h"
#import "FSInteractiveMapView.h"
#import <MapKit/MapKit.h>
#import "AFNetworking.h"
#import "SQLiteManager.h"
#import "FMResultSet.h"
#import "PieChartViewController.h"
#import "CSVParser.h"
#import "ISColorWheel.h"
#import "ChartSingleten.h"
#import "FSSVG.h"
#import "CollectionOfDataView.h"
#import "CSVFileView.h"
#import "ChartsSchemView.h"



@interface SamplechartView () <UIScrollViewDelegate,getcurlocation,UITextFieldDelegate,UIPickerViewDelegate,ISColorWheelDelegate,UIPopoverPresentationControllerDelegate,csvvaldelegate>
{
    CGRect touchpt;
    CGRect touchCGpt;
    NSString *strLbl;
    UILabel *lblTouch;
    UIView *vewDynamic;
    FSInteractiveMapView *map3;
    FSSVG* svg;
    ISColorWheel* _colorWheel;
    UISlider* _brightnessSlider;
    UIView* _wellView;
    UIView* _TotalColorView;
    NSMutableDictionary *dictcsv;
    NSString *csvStr;
}
@property (nonatomic, weak) CAShapeLayer* oldClickedLayer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviw;
@property (weak, nonatomic) IBOutlet UIView *ColorPickViw;
@property (weak, nonatomic) IBOutlet UIButton *btn_datasrc;
@property(nonatomic,strong)NSArray *ArrReceiveCSV;


@end

@implementation SamplechartView


{
   //properties of maps
    __weak IBOutlet UIPickerView *StatePickerView;
    __weak IBOutlet UIPickerView *PopulationPicker;
    __weak IBOutlet UITextField *txtfild_State;
    __weak IBOutlet UITextField *Txtfild_Population;
    
    NSMutableArray *xarray;
    NSMutableArray *yarray;
    NSMutableArray *warray;
    NSMutableArray *zarray;
}
@synthesize detailLabel;
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.title = self.detailItem;
        self.detailLabel.text = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self ColorWheelCreate];
    //csv file data stored array
    xarray=[[NSMutableArray alloc]init];
    yarray=[[NSMutableArray alloc]init];
    warray=[[NSMutableArray alloc]init];
    zarray=[[NSMutableArray alloc]init];

    
    _ArrReceiveCSV=[[NSArray alloc]init];
    txtfild_State.delegate=self;
    
    //Tab gesture controls
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollviw addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollviw addGestureRecognizer:twoFingerTapRecognizer];
    self.scrollviw.delegate=self;
    vewDynamic = [[UIView alloc] initWithFrame:self.scrollviw.bounds];
    vewDynamic.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollviw addSubview:vewDynamic];
    
    [self configureView];
    [self initExample3];
//    svg=[[FSSVG alloc]init];
txtfild_State.textAlignment=NSTextAlignmentCenter;
    


}
- (void)viewDidAppear:(BOOL)animated
{
    
    //Get Staes name From Singlton class
    ChartSingleten *singleTon=[ChartSingleten sharedinstence];
    xarray=singleTon.states;
    NSLog(@"list of sts USA :%@",singleTon.states);
    [StatePickerView reloadAllComponents];
    self.scrollviw.contentMode = UIViewContentModeScaleAspectFit;
    self.scrollviw.contentSize = vewDynamic.frame.size;
    CGRect scrollViewFrame = self.scrollviw.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollviw.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollviw.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollviw.minimumZoomScale = 0.2;
     self.scrollviw.maximumZoomScale = 3.0f;
    self.scrollviw.zoomScale = minScale;
    
    [self centerScrollViewContents];
   
    lblTouch = [[UILabel alloc] initWithFrame:CGRectZero];
    lblTouch.backgroundColor = [UIColor lightGrayColor];
    lblTouch.textAlignment=NSTextAlignmentCenter;
    lblTouch.adjustsFontSizeToFitWidth=YES;
    [lblTouch setFont:[UIFont systemFontOfSize:16]];
    lblTouch.alpha=1.95;
    lblTouch.numberOfLines=0;
    lblTouch.textColor=[UIColor redColor];
    [[lblTouch layer] setCornerRadius:10.0f];
    [[lblTouch layer] setMasksToBounds:YES];
    //    lblTouch.hidden = YES;
    [vewDynamic addSubview:lblTouch];

    
}
- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollviw.bounds.size;
    CGRect contentsFrame = vewDynamic.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    vewDynamic.frame = contentsFrame;
}


- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:vewDynamic];
    
    // 2
    CGFloat newZoomScale = self.scrollviw.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollviw.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollviw.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollviw zoomToRect:rectToZoomTo animated:YES];
}
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollviw.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollviw.minimumZoomScale);
    [self.scrollviw setZoomScale:newZoomScale animated:YES];
}
#pragma - mark Wheel color methods


# pragma - mark Scroll View delegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return vewDynamic;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initExample3
{
    NSDictionary* data = @{@"asia" : @12,
                           @"australia" : @2,
                           @"north_america" : @5,
                           @"south_america" : @14,
                           @"africa" : @5,
                           @"europe" : @20
                           };
    
      map3 = [[FSInteractiveMapView alloc] initWithFrame:CGRectMake(250, 50, self.view.frame.size.width-130, self.view.frame.size.height-350)];
    
    [map3 loadMap:@"indiaHigh(1)" withData:data colorAxis:@[[UIColor lightGrayColor], [UIColor darkGrayColor]]];
    //    eritreaLow
    //    [map setClickHandler:^(NSString* identifier, CAShapeLayer* layer) {
    //        self.detailLabel.text = [NSString stringWithFormat:@"Continent clicked: %@", identifier];
    //    }];
    map3.delegate=self;
    
    [map3 setClickHandler:^(NSString* identifier, CAShapeLayer* layer) {
        
        detailLabel.text = [NSString stringWithFormat:@"Clicked on: %@", identifier];
        
//        SQLiteManager *sqlMng=[[SQLiteManager alloc]init];
//        //      NSString *strquery=[NSString stringWithFormat:@""];
//        FMResultSet *fmr=[sqlMng ExecuteQuery:[NSString stringWithFormat:@"SELECT * FROM StateValue where Statename='%@'",identifier]];
//        
//        while ([fmr next]) {
//            NSString *year=[NSString stringWithFormat:@"%@",[fmr stringForColumn:@"X"]];
//            NSString *population=[NSString stringWithFormat:@"%@",[fmr stringForColumn:@"Y"]];
//            NSLog(@"%@",year);
//            NSLog(@"%@",population);
//            
//            
//        }
        
        if(_oldClickedLayer) {
            //            _oldClickedLayer=nil;
            _oldClickedLayer.zPosition = 0;
            _oldClickedLayer.shadowOpacity = 0;
        }
        
        _oldClickedLayer = layer;
        
        // We set a simple effect on the layer clicked to highlight it
        layer.zPosition = 10;
        layer.shadowOpacity = 0.5;
        layer.shadowColor = [UIColor blueColor].CGColor;
        layer.shadowRadius = 5;
        layer.shadowOffset = CGSizeMake(0, 0);
        layer.shadowOffset = CGSizeMake(0, 0);
        lblTouch.frame = touchCGpt;
        
        
        lblTouch.text = strLbl;
        [vewDynamic bringSubviewToFront:lblTouch];
        
//        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        PieChartViewController *controler=[storyboard instantiateViewControllerWithIdentifier:@"piechrt"];
//        
//        controler.modalPresentationStyle = UIModalPresentationPopover;
//        [self presentViewController:controler animated:YES completion:nil];
//        
//        // Popover presentation controller was created when presenting; now  configure it.
//        UIPopoverPresentationController *presentationController =
//        [controler popoverPresentationController];
//        presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
//        controler.preferredContentSize = CGSizeMake(300.0, 300.0);
//        presentationController.sourceView = self.view;
//        // arrow points out of the rect specified here
//        presentationController.sourceRect = touchpt;
//        presentationController.backgroundColor=[UIColor clearColor];        
        
        //        CATextLayer *label = [[CATextLayer alloc] initWithLayer:_oldClickedLayer];
        //        [label setFont:@"Helvetica-Bold"];
        //        [label setFontSize:20];
        //        [label setFrame:map.frame];
        //        [label setAlignmentMode:kCAAlignmentCenter];
        //        [label setString:@"United States Of America"];
        ////        [label setAlignmentMode:kCAAlignmentCenter];
        //        [label setForegroundColor:[[UIColor whiteColor] CGColor]];
        //
        //        [layer addSublayer:label];
        
        //        [label release];
        
        //        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        ViewController *controler=[storyboard instantiateViewControllerWithIdentifier:@"popOne"];
        //        [controler setStrValue:identifier];
        //        [self presentViewController:controler animated:YES completion:nil];
    }];
    //     self.scrollviw.contentSize = self.view;
    
    
    [vewDynamic addSubview:map3];
    svg=map3.svg;
    
}
-(void)getCurTouchponit:(CGPoint)pint
{
    NSLog(@"%f%f",pint.x,pint.y);
    touchpt=CGRectMake(pint.x+150, pint.y+50.0,0.0,0.0);
}
-(void)getPostionSates:(CGPoint)value title:(NSString *)str sepStr:(NSString *)StName
{
    touchCGpt=CGRectMake(value.x+150,value.y+50.0,150 ,60);
    strLbl=str;
    txtfild_State.text=StName;
    }

#pragma - Parse .CSV File methods

-(void)parseCsvfile
{
//    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"census-state-populations" ofType:@"csv"];
     NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"india-states-countries-finalv2" ofType:@"csv"];
    NSError *error;
    NSString *csvData = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    NSArray *gcRawData = [csvData componentsSeparatedByString:@"\n"];
    
    NSArray *singleGC = [NSArray array];
    dictcsv=[[NSMutableDictionary alloc]init];
    NSString *Strsection=[NSString stringWithFormat:@"%@",gcRawData[0]];
    NSArray *section=[NSArray array];
    section=[Strsection componentsSeparatedByString:@","];
    
    //dynmic Sqlite-Table create to insert CSV data....
    SQLiteManager *sqlMng=[[SQLiteManager alloc]init];
    csvStr=@"csvtable";
    NSString *strCre = [NSString stringWithFormat:@"create table if not exists %@ (", csvStr];
    BOOL isCreate = YES;
    NSString *colName=@"";
    NSString *colValue=@"";
    for (NSString *strData in section) {
        colName = [[colName stringByAppendingString:[strData substringFromIndex:0]] stringByAppendingString:@","];
        colValue = [colValue stringByAppendingString:@"?,"];
        if (isCreate) {
            strCre = [[strCre stringByAppendingString:[strData substringFromIndex:0]] stringByAppendingString:@" VARCHAR,"];
        }
    }
    if (isCreate) {
        strCre = [strCre substringToIndex:[strCre length]-1];
        strCre = [NSString stringWithFormat:@"%@)",strCre];
        [sqlMng ExecuteUpdateQuery:strCre];
        isCreate = NO;
    }
    colName = [colName substringToIndex:[colName length]-1];
    colValue = [colValue substringToIndex:[colValue length]-1];
    NSString *strInsQur = [NSString stringWithFormat:@"insert into %@ (%@) values(%@)",csvStr,colName,colValue];

    
       for (int i = 0; i < gcRawData.count; i++){
           NSString *nextGCString = [NSString stringWithFormat:@"%@", gcRawData[i]];
           singleGC = [nextGCString componentsSeparatedByString:@","];
           //insert data to DB
           if (i>=1) {
           NSMutableArray *Arr_InsertData=[[NSMutableArray alloc]init];
           [Arr_InsertData addObjectsFromArray:singleGC];
           [sqlMng ExecuteInsertQuery:strInsQur withCollectionOfValues:Arr_InsertData];//finsh
           }

           for (int i=0;i<section.count;i++) {
               NSMutableArray *arr_Section=[dictcsv objectForKey:section[i]];
               if (arr_Section) {
                   [arr_Section addObject:singleGC[i]];
               }
               else{
                   arr_Section=[[NSMutableArray alloc]init];
                   [arr_Section addObject:singleGC[i]];
               }
               [dictcsv setObject:arr_Section forKey:section[i]];
               
           }
           
    }
    NSLog(@"%@",dictcsv);
    

//dictcsv Dic send to collection view via prepare for segue

[self performSegueWithIdentifier:@"csvdataHouse" sender:self];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"csvdataHouse"]) {
        CollectionOfDataView *DatawareHous=[segue destinationViewController];
        DatawareHous.datacolltionDict=dictcsv;
        DatawareHous.str_TablName=csvStr;
        DatawareHous.delegate=self;
//        DatawareHous.strPatid=_strPatientId;
    }
}

#pragma - mark Color Picker delegate

- (void)changeBrightness:(UISlider*)sender
{
   
    [_colorWheel setBrightness:_brightnessSlider.value];
    [_wellView setBackgroundColor:_colorWheel.currentColor];
}

- (void)colorWheelDidChangeColor:(ISColorWheel *)colorWheel
{
    if ([txtfild_State.text length ] >0) {
    [_wellView setBackgroundColor:_colorWheel.currentColor];
    ChartSingleten *singleton=[ChartSingleten sharedinstence];
    NSMutableArray *scaledPaths=[[NSMutableArray alloc]init];
    scaledPaths=singleton.Arr_ScaledPathSingleTon;
    for(int i=0;i<[scaledPaths count];i++) {
        FSSVGPathElement* element = svg.paths[i];
        if([map3.layer.sublayers[i] isKindOfClass:CAShapeLayer.class]) {
            CAShapeLayer* l = (CAShapeLayer*)map3.layer.sublayers[i];
            NSString *str=[NSString stringWithFormat:@"%@",element.title];
            if ([txtfild_State.text isEqualToString:str]) {
                l.fillColor=[_colorWheel.currentColor CGColor];
                element.dynamicColor=_colorWheel.currentColor ;
            }
        }
    }
    }
}

-(void)ColorWheelCreate
{
        _TotalColorView=[[UIView alloc]initWithFrame:CGRectMake(234, 608, 294.0, 152.0)];
        [self.view bringSubviewToFront:_TotalColorView];
        _TotalColorView.backgroundColor = [UIColor lightGrayColor];
        _colorWheel = [[ISColorWheel alloc] initWithFrame:CGRectMake(15.0,10.0,140.0,140.0)];
        _colorWheel.delegate = self;
        _colorWheel.continuous = YES;
        [self.view addSubview:_TotalColorView];
        [_TotalColorView addSubview:_colorWheel];
        [_TotalColorView bringSubviewToFront:_colorWheel];
        _brightnessSlider = [[UISlider alloc] initWithFrame:CGRectMake(180,80,105.0,15.0)];
        _brightnessSlider.minimumValue = 0.0;
        _brightnessSlider.maximumValue = 1.0;
        _brightnessSlider.value = 1.0;
        _brightnessSlider.continuous = YES;
        [_brightnessSlider addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
        [_TotalColorView addSubview:_brightnessSlider];
        [_TotalColorView bringSubviewToFront:_brightnessSlider];
        
        _wellView = [[UIView alloc] initWithFrame:CGRectMake(230.0,10.0,57.0,40.0)];
        
        _wellView.layer.borderColor = [UIColor blackColor].CGColor;
        _wellView.layer.borderWidth = 2.0;
        [_TotalColorView addSubview:_wellView];
        [_TotalColorView bringSubviewToFront:_wellView];
}

#pragma - IBAction Methods
- (IBAction)CSV:(id)sender {

      [self parseCsvfile];
    
}
- (IBAction)Btn_DataSrc:(id)sender {
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CSVFileView *vewPopover = (CSVFileView*)[mainStoryboard instantiateViewControllerWithIdentifier: @"csvpop"];
    vewPopover.modalPresentationStyle = UIModalPresentationPopover;
    vewPopover.popoverPresentationController.sourceView = self.view;
    vewPopover.popoverPresentationController.sourceRect = [sender frame];
    [vewPopover.popoverPresentationController setPermittedArrowDirections:1];
    
    vewPopover.preferredContentSize = CGSizeMake(200, 500);
     //    }
    [self presentViewController:vewPopover animated:YES completion:nil];
    
}
- (IBAction)Btn_SetRmvclr:(id)sender {
    ChartSingleten *singleton=[ChartSingleten sharedinstence];
    NSMutableArray *scaledPaths=[[NSMutableArray alloc]init];
    scaledPaths=singleton.Arr_ScaledPathSingleTon;
    if ([sender tag]==1) {
     for(int i=0;i<[scaledPaths count];i++) {
         FSSVGPathElement* element = svg.paths[i];
           if([map3.layer.sublayers[i] isKindOfClass:CAShapeLayer.class]) {
            CAShapeLayer* l = (CAShapeLayer*)map3.layer.sublayers[i];
               NSString *str=[NSString stringWithFormat:@"%@",element.title];
            if ([txtfild_State.text isEqualToString:str]) {
                if (element.dynamicColor) {
                    l.fillColor=element.dynamicColor.CGColor;
                }
                else{
                l.fillColor=[[UIColor blueColor] CGColor];
                    l.fillColor=[_colorWheel.currentColor CGColor];
                    element.dynamicColor=_colorWheel.currentColor ;
                }
            }
        }
    }
  }
    else if ([sender tag]==2){
    for(int i=0;i<[scaledPaths count];i++) {
        FSSVGPathElement* element = svg.paths[i];
        if([map3.layer.sublayers[i] isKindOfClass:CAShapeLayer.class] && element.fill) {
            CAShapeLayer* l = (CAShapeLayer*)map3.layer.sublayers[i];
            NSString *str=[NSString stringWithFormat:@"%@",element.title];
            if ([txtfild_State.text isEqualToString:str]) {
                l.fillColor=[[UIColor colorWithRed:0.0/255.0 green:187.0/255.0 blue:167.0/255.0 alpha:1.0]CGColor];
                element.dynamicColor=nil;
            }
        }
    }
  }
    
}


- (IBAction)btnBack_Tapped:(id)sender
{
    [self.delegate removeMapView];
     NSLog(@"back button fired");
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma - mark TextFiled Delegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textView
{
    if ([txtfild_State tag]==1) {
   
        StatePickerView.hidden=NO;
    }
    return nil;
    
}
#pragma Picker View Delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==StatePickerView)
    {
          return [xarray count];
    }
    return 0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    txtfild_State.text=[xarray objectAtIndex:row];
  }
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [xarray objectAtIndex:row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 100;
    return sectionWidth;
}

#pragma - CollectionOfDataView delegate
-(void)sendCSVdict:(NSMutableDictionary *)dictcsvfile
{
    ChartSingleten *singleton=[ChartSingleten sharedinstence];
    NSMutableArray *scaledPaths=[[NSMutableArray alloc]init];
    scaledPaths=singleton.Arr_ScaledPathSingleTon;
    for(int i=0;i<[scaledPaths count];i++) {
        FSSVGPathElement* element = svg.paths[i];
            NSString *str=[NSString stringWithFormat:@"%@",element.title];
//        [[dictcsvfile allKeys] objectAtIndex:0]
        
         int inxPath=0;
        for (int i=0; i<[dictcsvfile allKeys].count;i++) {
               NSArray *arrcsvone=[dictcsvfile objectForKey:[[dictcsvfile allKeys] objectAtIndex:i]];
           
            for (NSString *valstr in arrcsvone ) {
                if([str isEqualToString:valstr]){
                    inxPath=(int)[arrcsvone indexOfObject:valstr];
                    element.Dictcsv=[[NSMutableDictionary alloc]init];
                    for (NSString *strindexpath in [dictcsvfile allKeys]) {
                        NSArray *arrpath=[dictcsvfile objectForKey:strindexpath];
                        NSString *strvs=[arrpath objectAtIndex:inxPath];
                        [element.Dictcsv setObject:strvs forKey:strindexpath];
                    }
                    NSLog(@"selected values:%@ ",element.Dictcsv);
                    break;
                }
            }
        }
//        NSArray *arrcsvone=[dictcsvfile objectForKey:[[dictcsvfile allKeys] objectAtIndex:0]];
    }
}

@end
