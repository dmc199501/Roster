//
//  MCersonnelTableViewCell.h
//  Roster
//
//  Created by 邓梦超 on 2019/1/11.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCersonnelTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *jibLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
