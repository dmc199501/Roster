//
//  LeftTableViewCell.m
//  Roster
//
//  Created by 邓梦超 on 2019/3/21.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "MCMacroDefinitionHeader.h"
@implementation LeftTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
        [self addSubview:self.nameLabel];
        [self.nameLabel setBackgroundColor:[UIColor clearColor]];
        [self.nameLabel setTextColor:COLOR_56_COLOER];
        [self.nameLabel setFont:[UIFont systemFontOfSize:16]];
        
       
        
        
        _netButton = [[UIButton alloc]init];
        self.netButton.frame = CGRectMake(SCREEN_WIDTH*0.7-100, 0, 100, 68);
        [self addSubview:_netButton];
        [_netButton setBackgroundColor:[UIColor clearColor]];
        [_netButton addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
        
        _fxImageView = [[UIImageView alloc]init];
        self.fxImageView.frame = CGRectMake(SCREEN_WIDTH*0.7 -70, 26.5, 8, 15);
        [_fxImageView setImage:[UIImage imageNamed:@"更多"]];
        [_fxImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_fxImageView];
        
       
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.7-99, 14, 1, 40)];
        [self addSubview:line];
        line.backgroundColor = COLOR_LINE_MC;
        
       UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH*0.7, 1)];
        [self addSubview:line2];
        line2.backgroundColor =  COLOR_LINE_MC;
        
       
        
        
    }
    return self;
}
- (void)nextView:(UIButton *)button{
    
    if ([_delegate respondsToSelector:@selector(LeftTableViewCellDelegate:next:)])
    {
        [_delegate LeftTableViewCellDelegate:self next:button];
    }
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
