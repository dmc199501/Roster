//
//  MCAddressBookViewController.h
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCAddressBookViewController : MCRootViewControler<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
   
    NSMutableArray *contactListMutableArray;
    UITableView *contactListTableView;
    
    
    UIView *webbackView;
    
    
    
}

@end

NS_ASSUME_NONNULL_END
