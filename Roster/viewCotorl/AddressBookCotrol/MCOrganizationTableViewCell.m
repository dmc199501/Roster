//
//  MCOrganizationTableViewCell.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/11.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCOrganizationTableViewCell.h"
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
@implementation MCOrganizationTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // self.backgroundColor = [UIColor colorWithRed:22 / 255.0 green:23 / 255.0 blue:37/ 255.0 alpha:1];
        
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, 12, 44, 44)];
        [self addSubview:self.iconImageView];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(73, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
        [self addSubview:self.titleLabel];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor colorWithRed:56 / 255.0 green:56 / 255.0 blue:56/ 255.0 alpha:1]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        
        self.arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width- 29, 26.5, 8, 15)];
        [self addSubview:self.arrowImageView];
        [self.arrowImageView  setImage:[UIImage imageNamed:@"更多"]];
        
        
        
        
        
        
        
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
