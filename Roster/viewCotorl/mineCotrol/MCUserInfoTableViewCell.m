//
//  MCUserInfoTableViewCell.m
//  TgWallet
//
//  Created by 邓梦超 on 2018/7/5.
//  Copyright © 2018年 邓梦超. All rights reserved.
//

#import "MCUserInfoTableViewCell.h"
#import "MCMacroDefinitionHeader.h"
@implementation MCUserInfoTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
        [self addSubview:self.titleLabel];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setTextColor:COLOR_56_COLOER];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        
      
;
        
        
        
       
        
        
        
        
        
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
