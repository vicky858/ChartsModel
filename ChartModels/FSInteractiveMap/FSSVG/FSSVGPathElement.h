//
//  FSSVGPathElement.h
//  FSInteractiveMap
//
//  Created by Arthur GUIBERT on 22/12/2014.
//  Copyright (c) 2014 Arthur GUIBERT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FSSVGPathElement : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong) NSString* className;
@property (nonatomic, strong) NSString* tranform;
@property (nonatomic, strong) UIBezierPath* path;
@property(nonatomic,strong)NSString *Pinicon;
@property(nonatomic,strong)NSNumber *xval;
@property(nonatomic,strong)NSNumber *yval;
@property(nonatomic)CGPoint xypoints;
@property(nonatomic,strong)UIColor *dynamicColor;
@property(nonatomic,strong)NSString *fillcolor;
@property(nonatomic,strong)NSString *CustomColor;
@property (nonatomic) BOOL fill;
@property(nonatomic,strong)NSMutableDictionary *Dictcsv;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
