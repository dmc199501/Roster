//
//  MCersonnelTableViewCell.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/11.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCersonnelTableViewCell.h"
#import "MCMacroDefinitionHeader.h"
@implementation MCersonnelTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // self.backgroundColor = [UIColor colorWithRed:22 / 255.0 green:23 / 255.0 blue:37/ 255.0 alpha:1];
        
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, 12, 44, 44)];
        [self addSubview:self.iconImageView];
        [self.iconImageView.layer setCornerRadius:5];
        [ self.iconImageView setClipsToBounds:YES];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(73, 17, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
        [self addSubview:self.nameLabel];
        [self.nameLabel setTextColor:[UIColor colorWithRed:56 / 255.0 green:56 / 255.0 blue:56/ 255.0 alpha:1]];
        [self.nameLabel setFont:[UIFont systemFontOfSize:16]];
        
        self.jibLabel = [[UILabel alloc]initWithFrame:CGRectMake(73, 37, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
        [self addSubview:self.jibLabel];
        [self.jibLabel setTextColor:COLOR_164_COLOER];
        [self.jibLabel setFont:[UIFont systemFontOfSize:14]];
        
        
        
        self.arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width- 29, 26.5, 8, 15)];
        [self addSubview:self.arrowImageView];
        [self.arrowImageView  setImage:[UIImage imageNamed:@"更多"]];
        
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(73, 67, SCREEN_WIDTH-75, 1)];
        [self addSubview:self.lineView];
        self.lineView.backgroundColor =  COLOR_LINE_MC;
        
        
        
        
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
