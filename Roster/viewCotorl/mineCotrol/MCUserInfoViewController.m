//
//  MCUserInfoViewController.m
//  TgWallet
//
//  Created by 邓梦超 on 2018/7/5.
//  Copyright © 2018年 邓梦超. All rights reserved.
//

#import "MCUserInfoViewController.h"
#import "MCUserInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MCPublicDataSingleton.h"

@interface MCUserInfoViewController ()
@property (nonatomic ,strong)NSString *image;
@property (nonatomic ,assign)NSInteger isChange;

@end

@implementation MCUserInfoViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        listMutableArray = [NSMutableArray array];
        [listMutableArray addObject:@[@{@"icon": @"", @"title":@"头像"},@{@"icon": @"", @"title":@"用户名"},@{@"icon": @"", @"title":@"姓名"},@{@"icon": @"", @"title":@"性别"}]];
       sexArray = @[@"男", @"女"];
    imageMutableArray = [NSMutableArray array];
        
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人档案";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    
    
    
    userPhotoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -75, 11.5, 45, 45)];
    [userPhotoImageView.layer setCornerRadius:5];
    [userPhotoImageView setImage:[UIImage imageNamed:@"默认头像"]];
    [userPhotoImageView setClipsToBounds:YES];
    
    userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, self.view.frame.size.width - 30, 20)];
    [userNameLabel setTextAlignment:NSTextAlignmentRight];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setTextColor:[UIColor colorWithRed:136/ 255.0 green:136 / 255.0 blue:136/ 255.0 alpha:1]];
    [userNameLabel setFont:[UIFont systemFontOfSize:15]];
    [userNameLabel setText:@""];
    
    sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, self.view.frame.size.width - 30, 20)];
    [sexLabel setTextAlignment:NSTextAlignmentRight];
    [sexLabel setBackgroundColor:[UIColor clearColor]];
    [sexLabel setTextColor:[UIColor colorWithRed:136/ 255.0 green:136 / 255.0 blue:136/ 255.0 alpha:1]];
    [sexLabel setFont:[UIFont systemFontOfSize:15]];
    [sexLabel setText:@"男"];
    
    
    emilLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, self.view.frame.size.width - 30, 20)];
    [emilLabel setTextAlignment:NSTextAlignmentRight];
    [emilLabel setBackgroundColor:[UIColor clearColor]];
    [emilLabel setTextColor:[UIColor colorWithRed:136/ 255.0 green:136 / 255.0 blue:136/ 255.0 alpha:1]];
    [emilLabel setFont:[UIFont systemFontOfSize:15]];
    [emilLabel setText:@""];
    
    
    nikenameTF = [[UITextField alloc]initWithFrame:CGRectMake(0,24,self.view.frame.size.width - 30,20)];
    nikenameTF.placeholder = @"";
    nikenameTF.userInteractionEnabled = NO;
    [nikenameTF setTextAlignment:NSTextAlignmentRight];
     [nikenameTF setFont:[UIFont systemFontOfSize:15]];
    nikenameTF.textColor = [UIColor colorWithRed:136/ 255.0 green:136 / 255.0 blue:136/ 255.0 alpha:1];
    UIColor *color =[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1];
    nikenameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    [self setUserIcon];
    [self getUserInformation];
    
    // Do any additional setup after loading the view.
}


#pragma -mark设置用户头像等信息
-(void)setUserIcon{
    
    NSDictionary *userDic = [Defaults objectForKey:@"info"];
    
    NSString *iconString = [NSString stringWithFormat:@"%@",userDic[@"icon"]];
        if (!kStringIsEmpty(iconString)) {
    
            [userPhotoImageView setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        }else{
    
            [userPhotoImageView setImage:[UIImage imageNamed:@"默认头像"]];
        }
    
    [userNameLabel  setText:[NSString stringWithFormat:@"%@",userDic[@"name"]]];
    [nikenameTF  setText:[NSString stringWithFormat:@"%@",userDic[@"realname"]]];
    
    NSString *sexString = [NSString stringWithFormat:@"%@",userDic[@"sex"]];
    if ([sexString isEqualToString:@"1"]) {
        
        sexLabel.text = @"男";
    }else{
        
        sexLabel.text = @"女";
    }
    
    
    
}

#pragma -mark获取个人信息
- (void)getUserInformation
{
    
    
  

    
    
}
- (NSMutableArray *)removeNullFromArray:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSValue *value = arr[i];
        // 删除NSDictionary中的NSNull，再添加进数组
        if ([value isKindOfClass:NSDictionary.class]) {
            [marr addObject:[self removeNullFromDictionary:(NSDictionary *)value]];
        }
        // 删除NSArray中的NSNull，再添加进数组
        else if ([value isKindOfClass:NSArray.class]) {
            [marr addObject:[self removeNullFromArray:(NSArray *)value]];
        }
        // 剩余的非NSNull类型的数据添加进数组
        else if (![value isKindOfClass:NSNull.class]) {
            [marr addObject:value];
        }
    }
    return marr;
}
- (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in dic.allKeys) {
        NSValue *value = dic[strKey];
        // 删除NSDictionary中的NSNull，再保存进字典
        if ([value isKindOfClass:NSDictionary.class]) {
            mdic[strKey] = [self removeNullFromDictionary:(NSDictionary *)value];
        }
        // 删除NSArray中的NSNull，再保存进字典
        else if ([value isKindOfClass:NSArray.class]) {
            mdic[strKey] = [self removeNullFromArray:(NSArray *)value];
        }
        // 剩余的非NSNull类型的数据保存进字典
        else if (![value isKindOfClass:NSNull.class]) {
            mdic[strKey] = dic[strKey];
        }
    }
    return mdic;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
            
        default:
        {
            return 1;
        }
            break;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *indentifier = [NSString stringWithFormat:@"cell%@%@",@(indexPath.section), @(indexPath.row)];
    MCUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MCUserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
        
        [cell.titleLabel setText:[[[listMutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"title"]];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width- 18, 26.5, 8, 15)];
        
        [image  setImage:[UIImage imageNamed:@"更多"]];
        
        
        
        switch (indexPath.row) {
            case 0:
                {
                    [cell addSubview:userPhotoImageView];
                    [cell addSubview:image];
                    
                    
                }
                break;
            case 1:
            {
               
                [cell addSubview:userNameLabel];
                
            }
                break;
            case 2:
            {
                [cell addSubview:nikenameTF];
               
                
            }
                break;
            case 3:
            {
                [cell addSubview:sexLabel];
                [cell addSubview:image];
            }
                break;
            case 4:
            {
                
            }
                break;
                
            default:
                break;
        }
       
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    MCUserInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if ([cell.titleLabel.text isEqualToString:@"头像"])
    {
      
        [self showChoosePhotoActionSheet];
        
    }
    if ([cell.titleLabel.text isEqualToString:@"性别"])
    {
        
        
        MCPickerView *pickerView = [[MCPickerView alloc]initWithFrame:self.view.bounds];
        pickerView.delegate = self;
        [pickerView showInView:self.view animation:YES];
    }
    
    
    
    
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (_currentSelectIndexPath.section == 0)
    {
        return sexArray.count;
    }
    
   
    
    
    
    return 0;
}


#pragma -mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;
{
    NSString *string = nil;
    
    
    if (_currentSelectIndexPath.section == 0)
    {
       
        string = [sexArray objectAtIndex:row];
    }
   
    
    
    
    __unsafe_unretained Class labelClass = [UILabel class];
    if ([view isKindOfClass:labelClass])
    {
        [((UILabel *)view) setText:string];
    }
    else
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 30)];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor blackColor]];
        [label setText:string];
        return label;
    }
    
    
    return view;
    
}

- (void)pickerView:(MCPickerView *)pickerView  finishFirstComponentRow:(NSInteger)row;//代理只返第一组，多的可以使用pickerView本身的去调用；
{
    NSString *string = nil;
    
    if (_currentSelectIndexPath.section == 0)
    {
       
        string = [sexArray objectAtIndex:row];
        [sexLabel setText:string];
        _isChange = 1;
        
    }
    if (_currentSelectIndexPath.section == 1 &&_currentSelectIndexPath.row == 0)
    {
        
       
    }
    
    
    
    [pickerView dismissAnimation:YES];
    
}

- (void)pickerView:(MCPickerView *)pickerView  cancelFirstComponentRow:(NSInteger)row;//代理只返第一组，多的可以使用pickerView本身的去调用；
{
    [pickerView dismissAnimation:YES];
}

#pragma -mark
- (void)showCamera
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
    
    
}

- (void)showPhotoLibary
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
    
}


- (void)showChoosePhotoActionSheet
{
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
    
    
    
}


- (void )updatePhotos:(NSInteger )index finish:(void (^)(BOOL finishedAll))finish;
{
    NSMutableDictionary *sendDictionary1 = [NSMutableDictionary dictionary];
    
  
    
  //  [sendDictionary1 setValue:@"colourlife" forKey:@"appID"];
    [sendDictionary1 setValue:@"image" forKey:@"file"];
   
    
    [STTextHudTool showWaitText:@"头像上传中"];
    [MCHttpManager upUserHeadWithIPString:BASEURL_ROSTER urlMethod:@"/upload/picupload"andDictionary:sendDictionary1 andImage:imageMutableArray success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        
         [STTextHudTool hideSTHud];
        
        if ([[NSString stringWithFormat:@"%@",dic[@"code"]] isEqualToString:@"0"]) {
            
            self.image = [NSString stringWithFormat:@"%@",responseObject[@"content"][@"path"]];
            
        }else{
            
            self.image = @"url";
        }
       
       

    } failure:^(NSError *error) {

      [STTextHudTool hideSTHud];

    }];
    
    
    
    
}
- (void)submit
{
    
    if (_isChange== 0) {
    //没有发生修改
        [STTextHudTool showText:@"您暂时还未修改资料"];
        
    }else{
        
        if (nikenameTF.text.length >=12)
        {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"昵称长度不得超过12位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
            
            return;
            
            
        }
        
        
        
        NSMutableDictionary *sendDictionary = [NSMutableDictionary dictionary];
        
        [sendDictionary setValue:self.image forKey:@"icon"];
        
        if ([sexLabel.text isEqualToString:@"女"]) {
            [sendDictionary setValue:@0 forKey:@"sex"];
        }else{
            
            [sendDictionary setValue:@1 forKey:@"sex"];
        }
        
        [sendDictionary setValue:UUID forKey:@"uuid"];
        
       
        
        [MCHttpManager PutWithIPString:BASEURL_USER urlMethod:@"/archives"parameters:sendDictionary success:^(id responseObject)
         {
             
             NSDictionary *dicDictionary = responseObject;
             
             
             if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"])
             {
                 
                 if ([self.delegate respondsToSelector:@selector(delegateViewControllerDidClickIconString:)]) {
                     [self.delegate delegateViewControllerDidClickIconString:self.image];
                 }
                 [self.navigationController popViewControllerAnimated:YES];
                 [STTextHudTool showSuccessText:@"修改成功"];
                 
                 
             }else{
                 
                 
                 [STTextHudTool showErrorText:@"修改失败"];
                 
             }
             
         } failure:^(NSError *error) {
             
             [STTextHudTool showErrorText:@"修改失败"];
             
         }];
        
        
    }
    
   
    
  
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    if (originalImage.size.width > 100)
//    {
//        originalImage = [MCPublicDataSingleton scaleImage:originalImage toScale: (100) / originalImage.size.width];
//
//    }
    originalImage = [MCPublicDataSingleton fixOrientation:originalImage];
   
    
    NSMutableDictionary *imageDictionary = [NSMutableDictionary dictionary];
    [imageDictionary setValue:originalImage forKey:@"image"];
     [imageMutableArray removeAllObjects];
    [imageMutableArray addObject:imageDictionary];
    
    [userPhotoImageView setImage:originalImage];
    self.isChange = 1;
   
   
    [self updatePhotos:0 finish:^(BOOL finishedAll) {
        
        if (finishedAll == NO)
        {
            // [hub setDetailsLabelText:@"提交图片出错....."];
            // [hub hide:YES afterDelay:3];
        }
        else
        {
            // [hub setDetailsLabelText:@"正在提交"];
            // [self submit];
        }
        
    }];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
}
#pragma -mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    switch (buttonIndex)
    {
        case 0:
        {
            [self showCamera];
        }
            break;
        case 1:
        {
            [self showPhotoLibary];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma -mark ZZPhotoBrowseViewControllerDelegate
- (void)photoBrowseViewController:(MCPhotoBrowseViewController *)photoBrowseViewController deleteIndex:(NSInteger )currnetIndex currentPhotoArray:(NSArray *)photoArray;
{
   
    
    [userPhotoImageView setImage:nil];
   
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
