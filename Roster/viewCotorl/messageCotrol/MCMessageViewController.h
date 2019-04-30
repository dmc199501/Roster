//
//  MCMessageViewController.h
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCMessageViewController : MCRootViewControler<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>{
    
    UITableView *listTableView;
    NSMutableArray *listMutableArray;
    NSMutableArray *listOneMutableArray;
    NSMutableArray *readMutableArray;
    NSMutableArray *xccxMutableArray;
    NSMutableArray *ysspMutableArray;
    NSMutableArray *tjysMutableArray;
    NSMutableArray *listGDMutableArray;
    
}
@property (nonatomic ,strong)UIView *customView;

@end

NS_ASSUME_NONNULL_END
