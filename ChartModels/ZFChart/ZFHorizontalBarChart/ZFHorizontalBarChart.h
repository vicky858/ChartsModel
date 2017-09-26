//
//  ZFHorizontalBarChart.h
//  ZFChartView
//
//  Created by apple on 16/5/31.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ZFGenericChart.h"
#import "ZFConst.h"
#import "ZFHorizontalBar.h"
@class ZFHorizontalBarChart;

/*********************  ZFHorizontalBarChartDelegate(ZFHorizontalBarChart协议方法)  *********************/
@protocol ZFHorizontalBarChartDelegate <NSObject>

@optional
/**
 *  bar height (if not set, default is 25.f)
 */
- (CGFloat)barHeightInHorizontalBarChart:(ZFHorizontalBarChart *)barChart;

/**
 *  The spacing between groups and groups (if not set, defaults to 20.f)
 */
- (CGFloat)paddingForGroupsInHorizontalBarChart:(ZFHorizontalBarChart *)barChart;

/**
 *  The distance between bar and bar in each group (if not set, defaults to 5.f) (this method is invalid when there is only one set of arrays)
 */
- (CGFloat)paddingForBarInHorizontalBarChart:(ZFHorizontalBarChart *)barChart;

/**
 *  y axis value text color array (if not set, all black)
 *
 *  @return returns to UIColor or NSArray
 * eg: ①return ZFRed; if UIColor is returned, all value text colors are red, and only one set of data is allowed to return only UIColor
 * ②return @ [ZFRed, ZFOrange, ZFBlue]; If the array is returned, the value text color on different categories of bar
 * For the array corresponding to the subscript color, style look Github document
 *
 */
- (id)valueTextColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart;

/**
 * bar gradient color
 
 *(ZFGenericChart *) chart second choice. If the two methods at the same time, it will give priority to the implementation of gradient color)

 * @return NSArray must store the ZFGradientAttribute type
 */

- (NSArray<ZFGradientAttribute *> *)gradientColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart;

/**
 * For the preparation of the click bar need to follow the follow-up code
 *
 * @param groupIndex click on the bar in the first few groups
 * @param barIndex click on the bar in the group of subscripts
 */

- (void)horizontalBarChart:(ZFHorizontalBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex horizontalBar:(ZFHorizontalBar *)horizontalBar popoverLabel:(ZFPopoverLabel *)popoverLabel;

/**
 * Used to write the click on the y axis valueLabel after the need to implement the follow-up code
 *
 * @param groupIndex click on the group in the group
 * @param labelIndex Click the label in the group's subscript
 */
- (void)horizontalBarChart:(ZFHorizontalBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel;

@end


@interface ZFHorizontalBarChart : ZFGenericChart

@property (nonatomic, weak) id<ZFHorizontalBarChartDelegate> delegate;
/** Whether the shadow effect (default is YES) */
@property (nonatomic, assign) BOOL isShadow;
/** When the y-axis shows the maximum value column bar bar color (default is red) */
@property (nonatomic, strong) UIColor * overMaxValueBarColor;
/** valueLabel to bar distance (default is 5.f) */
@property (nonatomic, assign) CGFloat valueLabelToBarPadding;

#pragma mark - public method

/**
 *  Redraw (this method is required after each update of the data)
 */
- (void)strokePath;

@end
