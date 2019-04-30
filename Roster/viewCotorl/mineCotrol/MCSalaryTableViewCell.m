//
//  MCSalaryTableViewCell.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/14.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCSalaryTableViewCell.h"
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
@implementation MCSalaryTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // self.backgroundColor = [UIColor colorWithRed:22 / 255.0 green:23 / 255.0 blue:37/ 255.0 alpha:1];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(26, 10, 200, 20)];
        [self addSubview:self.titleLabel];
        [self.titleLabel setTextColor:[UIColor colorWithRed:164 / 255.0 green:165 / 255.0 blue:169/ 255.0 alpha:1]];
         [self.moneyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
      
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-220, 10, 200, 20)];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel setTextAlignment:NSTextAlignmentRight];
        [self.moneyLabel setTextColor:[UIColor colorWithRed:56 / 255.0 green:56 / 255.0 blue:56/ 255.0 alpha:1]];
        [self.moneyLabel setFont:[UIFont systemFontOfSize:14]];
        
        
        
        
        
    }
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
