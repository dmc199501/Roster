//
//  XTImaginaryLine.h
//  ImaginaryLine
//
//  Created by 薛涛 on 2018/6/15.
//  Copyright © 2018年 XT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTImaginaryLine : UIView

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawImaginaryLineByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

@end
