//
//  ViewController.h
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    UIView *backView;
    UIButton *pushButton;
}

@property (nonatomic,assign) BOOL isHomePage;

@property (nonatomic,strong) NSMutableArray *allDataArray;//缓存所有数据数组

@property (nonatomic,strong) NSMutableArray *peopleArray;//缓存人员信息数组

@property (nonatomic,strong) NSMutableArray *organizatinArray;//缓存组织信息数组

@property (nonatomic,strong) NSString *organizatinUUID;//组织架构UUID


@property (nonatomic ,strong)UIView *customView;
@property(nonatomic,strong)NSString *pushOrgid;
@end

