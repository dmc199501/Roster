//
//  LeftTableViewCell.h
//  Roster
//
//  Created by 邓梦超 on 2019/3/21.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *netButton;
@property (nonatomic, strong) UIImageView *fxImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property (nonatomic, strong) id delegate;
@end
@protocol LeftTableViewCellDelegate <NSObject>
@optional

- (void)LeftTableViewCellDelegate:(LeftTableViewCell *) LeftTableViewCell next:(UIButton *)Button ;

@end
NS_ASSUME_NONNULL_END
