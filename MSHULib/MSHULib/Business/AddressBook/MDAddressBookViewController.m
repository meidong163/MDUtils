//
//  MDAddressBookViewController.m
//  MSHULib
//
//  Created by 舒江波 on 2019/4/30.
//  Copyright © 2019 com.pactera. All rights reserved.
//
/*
 * 需求 1. 展示手机上所有的联系人
       2. 点击联系人能显示联系人详情
 */



#import "MDAddressBookViewController.h"
#import <AddressBookUI/AddressBookUI.h>

#import <AddressBookUI/ABNewPersonViewController.h>
#import <Contacts/Contacts.h>

#import "MDScaffoldTableViewController.h"

@interface MDAddressBookViewController ()

@property(nonatomic,strong)NSMutableDictionary *dataSource;

@property(nonatomic,strong)NSMutableArray *sectionTitleArray;

@end


@implementation MDAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 获取所有的电话号码
    NSMutableArray<CNContact *> *muArray = [self getContactList];
    // 排序
    [self addressBookOrdering:muArray];
    
    for (int i = 0; i < self.sectionTitleArray.count; i++) {
        @weakify(self);
        [self addSecion:^(MDScaffoldTableViewSection *tableViewSection, NSInteger sectionIndex) {
            @strongify(self);
            tableViewSection.sectionTitle = self.sectionTitleArray[i]; // title
            NSArray *sectionData = [self.dataSource objectForKey:self.sectionTitleArray[i]];
            [sectionData enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [tableViewSection addCell:^(MDScaffoldCellConfig *cellConfig, UITableViewCell *cell, NSIndexPath *indexPath) {
                    cellConfig.cellStyle = UITableViewCellStyleValue1;
                    cellConfig.cellHeight = 50;
                    cell.textLabel.text = [dict objectForKey:@"name"];
                    cell.detailTextLabel.text = [(NSArray *)[dict objectForKey:@"phones"] firstObject];
                } whenSelectedCell:^(NSIndexPath *indexPath) {
                    NSLog(@"点击了 %@ - %@", [dict objectForKey:@"name"],[(NSArray *)[dict objectForKey:@"phones"] firstObject]);
                }];
            }];
        }];
    }
    
}

- (NSMutableDictionary *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return _dataSource;
}

/**
 按照字母顺序排序

 @return 返回排序好的数据
 */
- (NSMutableArray *)sectionTitleArray {
    _sectionTitleArray = [[self.dataSource allKeys] mutableCopy];
    // 系统排序，相对较为牛逼
    [_sectionTitleArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    [_sectionTitleArray removeObject:@"#"];
    [_sectionTitleArray addObject:@"#"];
    return _sectionTitleArray;
}


/**
 获取首字母拼音

 @param string 汉字
 @return 返回
 */
- (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    if (pinYin.length == 0) {
        return @"#";
    }
    unichar c = [pinYin characterAtIndex:0];
    if (c <'A'|| c >'Z'){
        return @"#";
    }
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([[pinYin substringToIndex:1] rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        // 是数字
        return @"#";
    }
    if ([[pinYin substringToIndex:1] isEqual:@"_"]) {
        return @"#";
    }
    return [pinYin substringToIndex:1];
}

// 通讯录排序
- (void)addressBookOrdering:(NSArray *)array
{
    [self.sectionTitleArray removeAllObjects];
    [self.dataSource removeAllObjects];
    // 字母
    for (int i = 65; i < 91; i ++) {
        char c = (char)i;
        NSMutableArray *array = [NSMutableArray array];
        NSString *key = [NSString stringWithFormat:@"%c",c];
        [self.dataSource setObject:array forKey:key];
    }
    [self.dataSource setObject:[NSMutableArray array] forKey:@"#"];
    
    //遍历联系人信息
    for (CNContact *cnContact in array) {
        //备注名
        NSString *name = [NSString stringWithFormat:@"%@%@",cnContact.familyName,cnContact.givenName];
        //判断是否有备注名
        if (name.length == 0) {
            CNLabeledValue *lableValue = cnContact.phoneNumbers[0];
            name = lableValue.label;
        }
        if (name.length == 0) {
            NSArray *arrayWithPhone = cnContact.phoneNumbers;
            CNLabeledValue *labelValue = arrayWithPhone[0];
            CNPhoneNumber *phoneNumber = labelValue.value;
            name = phoneNumber.stringValue;
        }
        //获取备注名首字母
        NSString *key = [self firstCharactorWithString:name];
        NSMutableArray *ar = self.dataSource[key];
        //保存备注名
        NSMutableDictionary *dic = [@{@"name":name} mutableCopy];
        NSMutableArray *phones = [NSMutableArray array];
        NSArray *arrayWithPhone = cnContact.phoneNumbers;
        for (CNLabeledValue *labelValue in arrayWithPhone) {
            CNPhoneNumber *phoneNumber = labelValue.value;
            [phones addObject:phoneNumber.stringValue];
        }
        //保存电话
        [dic setObject:phones forKey:@"phones"];
        NSData *data = cnContact.thumbnailImageData;
        UIImage *image = [UIImage imageWithData:data];
        //保存头像
        if (image == nil) {
            [dic setObject:@"" forKey:@"header"];
        } else{
            [dic setObject:image forKey:@"header"];
        }
        [ar addObject:dic];
        //保存联系人信息
        [self.dataSource setObject:ar forKey:key];
    }
    //删除多余的分类
    for (NSString *key in self.dataSource.allKeys) {
        NSArray *array = self.dataSource[key];
        if (array.count == 0) {
            [self.dataSource removeObjectForKey:key];
        }
    }
}

#pragma mark - 获取通讯录列表
-(NSMutableArray*)getContactList{
    
    NSMutableArray *array = [NSMutableArray array];
    //获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    //判断授权状态,如果不是已经授权,则直接返回
    if (status != CNAuthorizationStatusAuthorized) {
        CNContactStore *contactStore = [[CNContactStore alloc]init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey];
                // 4.2.创建CNContactFetchRequest对象
                CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                // 5.遍历所有的联系人
                [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    [array addObject:contact];
                }];
            }
        }];
    }else
    {
        //创建通信录对象
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        // 4.1.拿到所有打算获取的属性对应的key
        NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey];
        // 4.2.创建CNContactFetchRequest对象
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
        // 5.遍历所有的联系人
        [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [array addObject:contact];
        }];
    }
    return array;
    
}

@end
