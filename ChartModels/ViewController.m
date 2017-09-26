//
//  ViewController.m
//  ChartModels
//
//  Created by Vijayaamirtharaj on 16/02/17.
//  Copyright © 2017 Solvedge. All rights reserved.
//

#import "ViewController.h"
#import "XlsxReaderWriter-swift-bridge.h"
#import "CSVParser.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *ArrReceiveCSV;
@end

@implementation ViewController
{
    NSMutableArray *xarray;
    NSMutableArray *yarray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _ArrReceiveCSV=[[NSArray alloc]init];
    xarray=[[NSMutableArray alloc]init];
    yarray=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self xlsfilereader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)xlsfilereader
{
    NSString *documentPath = [[NSBundle mainBundle] pathForResource:@"CARD" ofType:@"xlsx"];
    BRAOfficeDocumentPackage *spreadsheet = [BRAOfficeDocumentPackage open:documentPath];
    
    //Save
    //    [spreadsheet save];
    
    //Save a copy
    //    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"workbookCopy.xlsx"];
    //    [spreadsheet saveAs:fullPath];
    
    //First worksheet in the workbook
    BRAWorksheet *firstWorksheet = spreadsheet.workbook.worksheets[0];
    
    //Worksheet named "Foo"
    //    BRAWorksheet *fooWorksheet = [spreadsheet.workbook createWorksheetNamed:@"Foo"];
    NSString *formula = [[firstWorksheet cellForCellReference:@"D4"] formulaString];
    NSString *string = [[firstWorksheet cellForCellReference:@"D3"] stringValue];
    NSAttributedString *attributedString = [[firstWorksheet cellForCellReference:@"B5"] attributedStringValue];
    NSLog(@"%@",formula);
    NSLog(@"%@",string);
    NSLog(@"%@",attributedString);
    NSMutableArray *Xxls=[[NSMutableArray alloc]init];
    NSMutableArray *Yxls=[[NSMutableArray alloc]init];
    for(int i=2; i<=32;i++) {
        NSString *valOne=[NSString stringWithFormat:@"G%d",i];
        NSString *valTwo=[NSString stringWithFormat:@"H%d",i];
        
        CGFloat XcellFloatValue = [[firstWorksheet cellForCellReference:valOne] floatValue];
        CGFloat YcellFloatValue = [[firstWorksheet cellForCellReference:valTwo] floatValue];
        [Xxls addObject:[NSString stringWithFormat:@"%f",XcellFloatValue]];
        [Yxls addObject:[NSString stringWithFormat:@"%f",YcellFloatValue]];
    }
    NSLog(@"%@",Xxls);
    NSLog(@"%@",Yxls);
    //    [self parseCsvfile];
    
}
-(void)parseCsvfile
{
    //    NSLog(@"%@", self.array);
    NSString *file = [[NSBundle mainBundle] pathForResource:@"DrawChart" ofType:@"csv"];
    [CSVParser parseCSVIntoArrayOfArraysFromFile:file
                    withSeparatedCharacterString:@","
                            quoteCharacterString:nil
                                       withBlock:^(NSArray *array, NSError *error) {
                                           self.ArrReceiveCSV = array;
                                           for (int i=1; i<_ArrReceiveCSV.count; i++) {
                                               NSArray *ArrX=[_ArrReceiveCSV objectAtIndex:i];
                                               if (ArrX.count>1) {
                                                   [xarray addObject:[ArrX objectAtIndex:0]];
                                                   [yarray addObject:[ArrX objectAtIndex:1]];
                                               }
                                           }
                                           NSLog(@"xxxx:%@",xarray);
                                           NSLog(@"yyyy:%@",yarray);
                                           [xarray removeAllObjects];
                                           [yarray removeAllObjects];
                                           
                                           
                                           // NSLog(@"%@", self.ArrReceiveCSV);
                                       }];
    
    
}


@end


































