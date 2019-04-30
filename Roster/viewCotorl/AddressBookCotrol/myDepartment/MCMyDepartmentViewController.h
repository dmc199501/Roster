//
//  MCMyDepartmentViewController.h
//  Roster
//
//  Created by 邓梦超 on 2019/1/11.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCMyDepartmentViewController : MCRootViewControler<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
    
    
    
    
    
}

@property (nonatomic ,strong)UIView *customView;
@end

NS_ASSUME_NONNULL_END
