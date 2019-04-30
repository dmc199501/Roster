//
//  MCMineViewController.h
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCMineViewController : MCRootViewControler<UITableViewDelegate,UITableViewDataSource>{
    
    UIImageView *iconImageView;
    UILabel *nameLabel;
    UILabel *jobLabel;
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
}

@end

NS_ASSUME_NONNULL_END
