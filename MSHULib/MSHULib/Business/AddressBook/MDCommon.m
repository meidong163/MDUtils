//
//  MDCommon.m
//  MSHULib
//
//  Created by 舒江波 on 2019/5/5.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDCommon.h"

@implementation MDCommon

- (void)saveYdCallAnswerPhoneToAdrBook{
    NSString *ydContactName = [MDCommon getRandomStringOfRunLoopCount:10];
    NSString *ydContactNote = @"这是亿点连接的电话测试号码";
    if (![MDCommon isExistContactNameByName:ydContactName] &&
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        NSMutableString *str = [[NSMutableString alloc] init];
        for (int i = 0; i<11; i++) {
            [str appendString:[NSString stringWithFormat:@"%d",arc4random()%10]];
        }
        [MDCommon createAddBookRecordByPhoneArr:@[str]
                                              andTitle:ydContactName
                                               andNote:ydContactNote];
    }
}

+ (BOOL)isExistContactNameByName:(NSString *)contactName{
    ABAddressBookRef addBook = nil;
    __block BOOL isExist = NO;
    CFErrorRef error = nil;
    addBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
    // 申请权限
    ABAddressBookRequestAccessWithCompletion(addBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
            CFIndex number = ABAddressBookGetPersonCount(addBook);
            for (NSInteger index = 0; index < number; index++) {
                //获取联系人对象的引用
                ABRecordRef  people = CFArrayGetValueAtIndex(allPeople, index);
                //获取当前联系人名字
                NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
                
                if ([firstName isEqualToString:contactName]) {
                    isExist = YES;
                }
            }
        }
        dispatch_semaphore_signal(sema);
    });
    //等待信号触发
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    return isExist;
}

// 往通讯录添加一条新联系人
+ (void)createAddBookRecordByPhoneArr:(NSArray *)phoneArr andTitle:(NSString *)title andNote:(NSString *)note{
    CFErrorRef error = NULL;
    if (!phoneArr || !title) {return;}
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABRecordRef newRecord = ABPersonCreate();
    
    ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)title, &error);
    
    //创建一个多值属性(电话)
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    //    ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)obj, (__bridge CFStringRef)@"亿点连接呼转测试", NULL);
    
    [phoneArr enumerateObjectsUsingBlock:^(NSString *phone, NSUInteger idx, BOOL * _Nonnull stop) {
        // 添加手机号码
        ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phone, kABPersonPhoneMobileLabel, NULL);
    }];
    
    ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
    
    //添加email
    //    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    //    ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef)([self.infoDic objectForKey:@"email"]), kABWorkLabel, NULL);
    //    ABRecordSetValue(newRecord, kABPersonEmailProperty, multiEmail, &error);
    
    // 添加备注
    ABRecordSetValue(newRecord, kABPersonNoteProperty, (__bridge CFTypeRef)note, &error);
    
    //添加记录到通讯录操作对象
    ABAddressBookAddRecord(addressBook, newRecord, &error);
    
    //保存通讯录操作对象
    ABAddressBookSave(addressBook, &error);
    
    CFRelease(multi);
    CFRelease(newRecord);
    CFRelease(addressBook);
}

/**
 获取随机字符串

 @param runLoopCount 随机数长度
 @return 随机字符串
 */
+ (NSString *) getRandomStringOfRunLoopCount:(NSInteger)runLoopCount {
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < runLoopCount; i++) {
        int ra = arc4random()%3;
        char c = '0';
        switch (ra) {
            case 0:
            {
                c = (char)(arc4random()%26 + 65);
                [str appendFormat:@"%c", c];
            }
                break;
                
            case 1:
            {
                c = (char)(arc4random()%26 + 97);
                [str appendFormat:@"%c", c];
            }
                break;
                
            default:
            {
                int num = arc4random()%10;
                [str appendFormat:@"%c", c + num];
            }
                break;
        }
    }
    return [NSString stringWithString:str];
}
@end
