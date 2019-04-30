//
//  MCHomePageTableViewCell.m
//  EmployeesEnd
//
//  Created by 邓梦超 on 16/11/9.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCHomePageTableViewCell.h"
#import "MCMacroDefinitionHeader.h"
@implementation MCHomePageTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 9, 50, 50)];
        [self addSubview:_iconImageView];
        [_iconImageView setImage:[UIImage imageNamed:@""]];
        [_iconImageView.layer setCornerRadius:5];
        
        
        _noReadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-36, 37, 16, 16)];
        [self addSubview:_noReadImageView];
        [_noReadImageView setBackgroundColor:[UIColor redColor]];
        [_noReadImageView.layer setCornerRadius:8];
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [_noReadImageView addSubview:_numberLabel];
        [_numberLabel setBackgroundColor:[UIColor clearColor]];
        [_numberLabel setTextColor:[UIColor whiteColor]];
        [_numberLabel setFont:[UIFont systemFontOfSize:11]];
        [_numberLabel setText:@"8"];
       
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, self.frame.size.width- 60, 20)];
        [self addSubview:_titleLabel];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor colorWithRed:56 / 255.0 green:56 / 255.0 blue:56 / 255.0 alpha:1] ];
        [_titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_titleLabel setText:@"员工报修"];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 35, SCREEN_WIDTH/2, 20)];
        [self addSubview:_contentLabel];
        [_contentLabel setBackgroundColor:[UIColor clearColor]];
        [_contentLabel setTextColor:COLOR_164_COLOER];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]];
        [_contentLabel setText:@"哈哈哈哈哈哈哈哈哈哈哈"];

        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 10, 150, 20)];
        [self addSubview:_dateLabel];
        [_dateLabel setBackgroundColor:[UIColor clearColor]];
        [_dateLabel setTextAlignment:NSTextAlignmentRight];
        [_dateLabel setTextColor:[UIColor grayColor]];
        [_dateLabel setFont:[UIFont systemFontOfSize:13]];
        [_dateLabel setText:@"2015-12-23"];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(75, 67, SCREEN_WIDTH-75, 1)];
        [self addSubview:line];
        line.backgroundColor =  COLOR_LINE_MC;
        
        
    }
    return self;
}

- (void)setIsRead:(BOOL)isRead
{
    _isRead = isRead;
    [_noReadImageView setHidden:_isRead];
    
}

@end
