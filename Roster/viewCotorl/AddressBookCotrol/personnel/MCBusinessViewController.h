//
//  MCBusinessViewController.h
//  Roster
//
//  Created by 邓梦超 on 2019/1/15.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MCMCBusinessViewControllerDelegate <NSObject>

@optional

- (void)delegateViewControllerDidClickiscollection:(NSString *)string;
@end
@interface MCBusinessViewController : MCRootViewControler <UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
    UIImageView *iconImgeView;
    UILabel *nameLabel;
    UILabel *jobLabel;
    UILabel *stateLabel;
    UIView *maskView;
    
}
@property(nonatomic,strong)NSDictionary *dataDic;
@property (nonatomic, assign) id<MCMCBusinessViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
