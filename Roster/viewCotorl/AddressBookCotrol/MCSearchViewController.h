//
//  MCSearchViewController.h
//  Roster
//
//  Created by 邓梦超 on 2019/3/12.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCSearchViewController : MCRootViewControler<UITableViewDelegate,UITableViewDataSource>{
    
    UISearchBar *searchBar;
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
}
@property (nonatomic,strong) NSMutableArray *peopleArray;//缓存人员信息数
@property (nonatomic,strong) NSMutableArray *organizatinArray;//缓存组织信息数组
@property (nonatomic ,strong)UIView *customView;
@property (nonatomic ,strong)NSString *pushType;
@end

NS_ASSUME_NONNULL_END
