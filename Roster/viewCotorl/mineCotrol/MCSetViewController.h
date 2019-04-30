//
//  MCSetViewController.h
//  Roster
//
//  Created by 邓梦超 on 2019/2/26.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCSetViewController : MCRootViewControler <UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
   
    
}


@end

NS_ASSUME_NONNULL_END
