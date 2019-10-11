//
//  MCSalaryViewController.h
//  Roster
//
//  Created by 邓梦超 on 2019/1/14.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCSalaryViewController : MCRootViewControler<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *listMutableArray;
    NSMutableArray *list;
    UITableView *listTableView;
    
    UILabel *sjMoneyLabel;
    UILabel *dateLabel;
    UIView *heardView;
    UIView *footView;
    UILabel *label1 ;
    UIButton *dataButton;
    UIButton *YesButton;
    UIButton *NoButton;
    UILabel *label3;
    
    
    
    
}


@end

NS_ASSUME_NONNULL_END
