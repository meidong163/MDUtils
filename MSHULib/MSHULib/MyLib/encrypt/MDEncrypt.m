//
//  MDEncrypt.m
//  MSHULib
//
//  Created by 舒江波 on 2019/5/8.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDEncrypt.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation MDEncrypt


- (NSString*)dynamicEncrypt:(id)text
{
    NSString *errorkey = @"jZslzUMjczG9K";
    NSRange range = NSMakeRange(4, 8);
    NSString *key = [errorkey substringWithRange:range];
    NSString *ciphertext = @"";
    if ([text isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:text options:0 error:nil];
        NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSData *cipherData = [self DESEncrypt:[str dataUsingEncoding:NSUTF8StringEncoding] WithKey:key];
        ciphertext = [NSString stringWithFormat:@"%@%@",errorkey,[cipherData base64EncodedStringWithOptions:NSUTF8StringEncoding]];
        
    }else
    {
        NSDebugLog(@"非字典类型");
    }
    return ciphertext? ciphertext : @"";
}

- (NSDictionary *)dynamicDecrypt:(NSString *)ciphertext;
{
    // 截取后13位
    NSString *footString = [ciphertext substringToIndex:13];
    NSRange range =NSMakeRange(4, 8);
    NSString *key = [footString substringWithRange:range];
    NSString *cipherOrg = [ciphertext substringFromIndex:13];
    NSData *cipherData =[[NSData alloc] initWithBase64EncodedString:cipherOrg options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *clearData = [self DESDecrypt:cipherData WithKey:key];
    
    NSString *clearText = [[NSString alloc]initWithData:clearData encoding:NSUTF8StringEncoding];
    
    NSData *jsonData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    NSDebugLog(@"解析 dict = %@",dict);
    
    return dict;
}

- (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{   // DES密钥参与运算的只有64位，超出的部分并不参与加密运算
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    NSData *keybyte = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeDES,
                                          [keybyte bytes],
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    NSData *keybyte = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeDES,
                                          [keybyte bytes],
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    NSLog(@"解密失败");
    return nil;
}
@end
