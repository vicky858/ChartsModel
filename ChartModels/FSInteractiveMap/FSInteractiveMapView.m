//
//  FSInteractiveMapView.m
//  FSInteractiveMap
//
//  Created by Arthur GUIBERT on 23/12/2014.
//  Copyright (c) 2014 Arthur GUIBERT. All rights reserved.
//

#import "FSInteractiveMapView.h"
#import "ChartSingleten.h"

@interface FSInteractiveMapView ()

@property (nonatomic, strong) NSMutableArray* scaledPaths;

@end

@implementation FSInteractiveMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        _scaledPaths = [NSMutableArray array];
        [self setDefaultParameters];
    }
    
    return self;
}

- (void)setDefaultParameters
{
    self.fillColor = [UIColor colorWithWhite:0.85 alpha:1];
    self.strokeColor = [UIColor colorWithWhite:0.6 alpha:1];
}

#pragma mark - SVG map loading

- (void)loadMap:(NSString*)mapName withColors:(NSDictionary*)colorsDict
{
    NSMutableArray *Arr_stsName=[[NSMutableArray alloc]init];
    _svg = [FSSVG svgWithFile:mapName];
    for (FSSVGPathElement* path in _svg.paths) {
        // Make the map fits inside the frame
        float scaleHorizontal = self.frame.size.width / _svg.bounds.size.width;
        float scaleVertical = self.frame.size.height / _svg.bounds.size.height;
        float scale = MIN(scaleHorizontal, scaleVertical);
        
        CGAffineTransform scaleTransform = CGAffineTransformIdentity;
        scaleTransform = CGAffineTransformMakeScale(scale, scale);
        scaleTransform = CGAffineTransformTranslate(scaleTransform,-_svg.bounds.origin.x, -_svg.bounds.origin.y);
        
        UIBezierPath* scaled = [path.path copy];
        [scaled applyTransform:scaleTransform];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = scaled.CGPath;
        
        // Setting CAShapeLayer properties
        shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 3.0;
        
        
        if(path.fill) {
            if(colorsDict && [colorsDict objectForKey:path.identifier]) {
                UIColor* color = [colorsDict objectForKey:path.identifier];
                shapeLayer.fillColor = color.CGColor;
            } else {
                shapeLayer.fillColor = self.fillColor.CGColor;
            }
            
        } else {
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        }
        //          UIColor *fiColr=[self colorFromHexString:path.fillcolor];
        shapeLayer.fillColor = [[UIColor colorWithRed:0.0/255.0 green:187.0/255.0 blue:167.0/255.0 alpha:1.0]CGColor];
        //          shapeLayer.fillColor = [fiColr CGColor];
        [Arr_stsName addObject:path.title];
        [self.layer addSublayer:shapeLayer];
        [_scaledPaths addObject:scaled];
        
        
        /*add text and Pointer Image on shape layer get text from .svg file*/
        //          CATextLayer* text = [CATextLayer new];
        //          text.string = path.title ;
        //          text.fontSize=13;
        //          text.frame = CGRectMake(path.xypoints.x, path.xypoints.y-30, 350, 20);
        //          text.alignmentMode = kCAAlignmentLeft;
        //          text.foregroundColor = [[UIColor blackColor] CGColor];
        //          [shapeLayer addSublayer:text];
        //        UIImageView *callRecImage = [[UIImageView alloc] initWithFrame:CGRectMake(path.xypoints.x-26, path.xypoints.y-45, 32, 32)];
        //        callRecImage.contentMode = UIViewContentModeCenter;
        //        [callRecImage setImage:[UIImage imageNamed:@"IconPin.png"]];
        //        callRecImage.layer.cornerRadius = callRecImage.frame.size.width /2;
        //        callRecImage.layer.borderWidth = 2.0f;
        //        callRecImage.layer.borderColor = [UIColor grayColor].CGColor;
        //        callRecImage.clipsToBounds = YES;
        //        [self addSubview: callRecImage];
        //        [shapeLayer addSublayer:callRecImage.layer];
    }
    
    ChartSingleten *Singleton=[ChartSingleten sharedinstence];
    Singleton.states=Arr_stsName;
    Singleton.Arr_ScaledPathSingleTon=_scaledPaths;
}
-(UIColor *)colorFromHexString:(NSString *)hexString {
    if (hexString.length <=1) {
        return [UIColor colorWithRed:0.0/255.0 green:187.0/255.0 blue:167.0/255.0 alpha:1.0];
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)loadMap:(NSString*)mapName withData:(NSDictionary*)data colorAxis:(NSArray*)colors
{
    [self loadMap:mapName withColors:[self getColorsForData:data colorAxis:colors]];
}

- (NSDictionary*)getColorsForData:(NSDictionary*)data colorAxis:(NSArray*)colors
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:[data count]];
    
    float min = MAXFLOAT;
    float max = -MAXFLOAT;
    
    for (id key in data) {
        NSNumber* value = [data objectForKey:key];
        
        if([value floatValue] > max)
            max = [value floatValue];
        
        if([value floatValue] < min)
            min = [value floatValue];
    }
    
    for (id key in data) {
        NSNumber* value = [data objectForKey:key];
        float s = ([value floatValue] - min) / (max - min);
        float segmentLength = 1.0 / ([colors count] - 1);
        int minColorIndex = MAX(floorf(s / segmentLength),0);
        int maxColorIndex = MIN(ceilf(s / segmentLength), [colors count] - 1);
        
        UIColor* minColor = colors[minColorIndex];
        UIColor* maxColor = colors[maxColorIndex];
        
        s -= segmentLength * minColorIndex;
        
        CGFloat maxColorRed = 0;
        CGFloat maxColorGreen = 0;
        CGFloat maxColorBlue = 0;
        CGFloat minColorRed = 0;
        CGFloat minColorGreen = 0;
        CGFloat minColorBlue = 0;
        
        [maxColor getRed:&maxColorRed green:&maxColorGreen blue:&maxColorBlue alpha:nil];
        [minColor getRed:&minColorRed green:&minColorGreen blue:&minColorBlue alpha:nil];
        
        UIColor* color = [UIColor colorWithRed:minColorRed * (1.0 - s) + maxColorRed * s
                                         green:minColorGreen * (1.0 - s) + maxColorGreen * s
                                          blue:minColorBlue * (1.0 - s) + maxColorBlue * s
                                         alpha:1];
        
        [dict setObject:color forKey:key];
    }
    
    return dict;
}

#pragma mark - Updating the colors and/or the data

- (void)setColors:(NSDictionary*)colorsDict
{
    for(int i=0;i<[_scaledPaths count];i++) {
        FSSVGPathElement* element = _svg.paths[i];
        
        if([self.layer.sublayers[i] isKindOfClass:CAShapeLayer.class] && element.fill) {
            CAShapeLayer* l = (CAShapeLayer*)self.layer.sublayers[i];
            
            if(element.fill) {
                if(colorsDict && [colorsDict objectForKey:element.identifier]) {
                    UIColor* color = [colorsDict objectForKey:element.identifier];
                    l.fillColor = color.CGColor;
                } else {
                    l.fillColor = self.fillColor.CGColor;
                }
            } else {
                l.fillColor = [[UIColor clearColor] CGColor];
            }
            l.fillColor = [[UIColor blueColor] CGColor];
        }
    }
}

- (void)setData:(NSDictionary*)data colorAxis:(NSArray*)colors
{
    [self setColors:[self getColorsForData:data colorAxis:colors]];
}

#pragma mark - Layers enumeration

- (void)enumerateLayersUsingBlock:(void (^)(NSString *, CAShapeLayer *))block
{
    for(int i=0;i<[_scaledPaths count];i++) {
        FSSVGPathElement* element = _svg.paths[i];
        if([self.layer.sublayers[i] isKindOfClass:CAShapeLayer.class] && element.fill) {
            CAShapeLayer* l = (CAShapeLayer*)self.layer.sublayers[i];
            block(element.identifier, l);
        }
    }
}
#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for(int i=0;i<[_scaledPaths count];i++) {
        UIBezierPath* path = _scaledPaths[i];
        if ([path containsPoint:touchPoint])
        {
            FSSVGPathElement* element = _svg.paths[i];
            
            if([self.layer.sublayers[i] isKindOfClass:CAShapeLayer.class] && element.fill) {
                CAShapeLayer* l = (CAShapeLayer*)self.layer.sublayers[i];
                [self.delegate getCurTouchponit:touchPoint];
                NSString *str=@"";
                for (NSString *valstr in [element.Dictcsv allKeys]){
                    NSString *strele=[element.Dictcsv objectForKey:valstr];
                    str=[NSString stringWithFormat:@"%@%@ : %@\n",str,valstr,strele];
                }
                if (str.length<=0) {
                    str=element.title;
                }
                [self.delegate getPostionSates:touchPoint title:str sepStr:element.title];
                if(_clickHandler) {
                    _clickHandler(element.title,l);
                }
//                UIColor *fiColr=[[UIColor colorWithRed:0.0/255.0 green:187.0/255.0 blue:167.0/255.0 alpha:1.0]CGColor];
//                l.fillColor=[fiColr CGColor];
            }
        }
        else{
            FSSVGPathElement* element = _svg.paths[i];
            if([self.layer.sublayers[i] isKindOfClass:CAShapeLayer.class] && element.fill) {
                CAShapeLayer* l = (CAShapeLayer*)self.layer.sublayers[i];
                if (element.dynamicColor) {
                    l.fillColor=element.dynamicColor.CGColor;
                }
                else{
//                UIColor *fiColr=[self colorFromHexString:element.fillcolor];
//                 l.fillColor=[fiColr CGColor];
                    l.fillColor=[[UIColor colorWithRed:0.0/255.0 green:187.0/255.0 blue:167.0/255.0 alpha:1.0]CGColor];
                }
            }
            
            
        }
    }
    
}

@end
