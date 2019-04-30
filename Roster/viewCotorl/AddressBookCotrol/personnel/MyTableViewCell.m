//
//  MyTableViewCell.m
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MCMacroDefinitionHeader.h"

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // self.backgroundColor = [UIColor colorWithRed:22 / 255.0 green:23 / 255.0 blue:37/ 255.0 alpha:1];
        
        
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 17, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
        [self addSubview:self.titleLabel];
        [self.titleLabel setTextColor:[UIColor colorWithRed:56 / 255.0 green:56 / 255.0 blue:56/ 255.0 alpha:1]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 37, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
        [self addSubview:self.contentLabel];
        [self.contentLabel setTextColor:COLOR_164_COLOER];
        [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
        
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
