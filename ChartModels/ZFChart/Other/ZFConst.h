//
//  ZFConst.h
//  ZFChartView
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ZFColor.h"
#import "ZFGradientAttribute.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  Angle for trigonometric function sin
 *  @param a angle
 */
#define ZFSin(a) sin(a / 180.f * M_PI)

/**
 *  Angle for trigonometric function cos
 *  @param a angle
 */
#define ZFCos(a) cos(a / 180.f * M_PI)

/**
 *  Angle for trigonometric function tan
 *  @param a angle
 */
#define ZFTan(a) tan(a / 180.f * M_PI)

/**
 *  Radian angle of rotation
 *  @param radian
 */
#define ZFAngle(radian) (radian / M_PI * 180.f)

/**
 *  Angle to arc
 *  @param angle
 */
#define ZFRadian(angle) (angle / 180.f * M_PI)


/**
 *  The starting point of the coordinate axis
 */
extern CGFloat const ZFAxisLineStartXPos;

/**
 *  Axis label tag value
 */
extern NSInteger const ZFAxisLineValueLabelTag;

/**
 *  Axis of the item
 */
extern CGFloat const ZFAxisLineItemWidth;

/**
 *  The spacing between the axis group and the group
 */
extern CGFloat const ZFAxisLinePaddingForGroupsLength;

/**
 *  Axis between bar and bar
 */
extern CGFloat const ZFAxisLinePaddingForBarLength;

/**
 *  The maximum upper limit of the axis to the distance of the arrow
 */
extern CGFloat const ZFAxisLineGapFromAxisLineMaxValueToArrow;

/**
 *  Axis length of the axis
 */
extern CGFloat const ZFAxisLineSectionLength;

/**
 *  The height of the axis
 */
extern CGFloat const ZFAxisLineSectionHeight;

/**
 *  Start factor (top)
 */
extern CGFloat const ZFAxisLineStartRatio;

/**
 *  End factor (bottom)
 */
extern CGFloat const ZFAxisLineVerticalEndRatio;

/**
 *  Horizontal axis end factor (bottom)
 */
extern CGFloat const ZFAxisLineHorizontalEndRatio;

/**
 *  The radius of the line circle
 */
extern CGFloat const ZFLineChartCircleRadius;

/**
 *  Radar map radius extension length
 */
extern CGFloat const ZFRadarChartRadiusExtendLength;

/**
 *  Pie chart percentage label Tag value
 */
extern NSInteger const ZFPieChartPercentLabelTag;

/**
 *  Navigation bar height
 */
extern CGFloat const NAVIGATIONBAR_HEIGHT;

/**
 *  tabBar height
 */
extern CGFloat const TABBAR_HEIGHT;

/**
 *  topic height
 */
extern CGFloat const TOPIC_HEIGHT;

/**
 *  Round corner
 */
extern CGFloat const ZFPerigon;

/**
 *  Wave pattern path x point mark
 */
extern NSString * const ZFWaveChartXPos;

/**
 *  Wave map path y mark
 */
extern NSString * const ZFWaveChartYPos;

/**
 *  Whether the wave map points is equal to 0
 */
extern NSString * const ZFWaveChartIsHeightEqualZero;


/**
 *  The position of the value on the line graph
 */
typedef enum{
    kChartValuePositionDefalut = 0,   //Up and down distribution
    kChartValuePositionOnTop = 1,     //Above
    kChartValuePositionOnBelow = 2    //Below
}kChartValuePosition;

/**
 *  Horizontal or vertical axis
 */
typedef enum{
    kAxisDirectionVertical = 0,    //Vertical direction
    kAxisDirectionHorizontal = 1   //horizontal direction
}kAxisDirection;

/**
 *  Axis y axis value or radar pattern segmentation type display type
 */
typedef enum{
    kValueTypeInteger = 0,   //Take the form of an integer (rounded) (default)
    kValueTypeDecimal = 1,   //Take the decimal form (the default display of 1 decimal places, if you want to display the remaining number of bits set ZFGenericChart.h file numberOfDecimal attributes)
}kValueType;

@interface ZFConst : NSObject

@end
