//
//  FSInteractiveMapView.h
//  FSInteractiveMap
//
//  Created by Arthur GUIBERT on 23/12/2014.
//  Copyright (c) 2014 Arthur GUIBERT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSSVG.h"

@protocol getcurlocation<NSObject>
-(void)getCurTouchponit:(CGPoint)pint;
-(void)getPostionSates:(CGPoint)value title:(NSString *)str sepStr:(NSString *)StName;

@end
@interface FSInteractiveMapView : UIView
@property (nonatomic, strong) FSSVG* svg;

// Graphical properties
@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIColor* strokeColor;
@property (nonatomic, strong) UILabel* Arkansas;
@property(nonatomic,weak)id<getcurlocation> delegate;
// Click handler
@property (nonatomic, copy) void (^clickHandler)(NSString* identifier, CAShapeLayer* layer);

// Loading functions
- (void)loadMap:(NSString*)mapName withColors:(NSDictionary*)colorsDict;
- (void)loadMap:(NSString*)mapName withData:(NSDictionary*)data colorAxis:(NSArray*)colors;

// Set the colors by element, if you want to make the map dynamic or update the colors
- (void)setColors:(NSDictionary*)colorsDict;
- (void)setData:(NSDictionary*)data colorAxis:(NSArray*)colors;

// Layers enumeration
- (void)enumerateLayersUsingBlock:(void(^)(NSString* identifier, CAShapeLayer* layer))block;

@end
