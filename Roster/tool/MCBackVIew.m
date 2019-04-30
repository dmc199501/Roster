//
//  MCBackVIew.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/9.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCBackVIew.h"

@implementation MCBackVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
