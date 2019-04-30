//
//  MCUserInfoViewController.h
//  TgWallet
//
//  Created by 邓梦超 on 2018/7/5.
//  Copyright © 2018年 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"
#import "MCPickerView.h"
#import "MCPhotoBrowseViewController.h"

@protocol MCUserDelegateViewControllerDelegate <NSObject>

@optional

- (void)delegateViewControllerDidClickIconString:(NSString *)string;
@end
@interface MCUserInfoViewController : MCRootViewControler
<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate,MCPickerViewDelegate>{
    
    NSMutableArray *listMutableArray;
    UITableView *listTableView;
    UIImageView *userPhotoImageView;
    UIImageView *stateImageView;
    UILabel *userNameLabel;
    UILabel *sexLabel;
    UILabel *emilLabel;
    UILabel *nikenameLabel;
    NSMutableArray *imageMutableArray;
    UITextField * nikenameTF;
    NSArray *sexArray;
    
    
    
}
@property (nonatomic, strong)NSIndexPath *currentSelectIndexPath;
@property (nonatomic, assign) id<MCUserDelegateViewControllerDelegate> delegate;

@end
