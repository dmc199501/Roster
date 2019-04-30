//
//  MCMyViewController.h
//  TgVideo
//
//  Created by 邓梦超 on 2018/10/13.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCMyViewController : MCRootViewControler<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *iconImageView;
    UILabel *nameLabel;
    UILabel *vipLabel;
     UILabel *bdLabel;
     UILabel *fxLabel;
     UILabel *dhLabel;
     UILabel *srLabel;
     UILabel *emaillabel;
    UIButton *vipButton;
     UIButton *qhButton;
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
    
    
}

@end

NS_ASSUME_NONNULL_END
