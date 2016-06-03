//
//  AHAppUDID.m
//  AHKit
//
//  Created by Alan Miu on 15/10/27.
//  Copyright (c) 2015年 AutoHome. All rights reserved.
//

#import "AHAppUDID.h"
#import "AHKeychain.h"

#define APPUDID_LENGTH      40
#define APPUDID_IDENTIFIER  @"UDID"


@implementation AHAppUDID

static NSString *_udid = nil;

/**
 *  获取UDID
 *
 *  @return UDID
 */
+ (NSString *)udid {
    return [AHAppUDID udid:APPUDID_IDENTIFIER];
}

/**
 *  获取UDID
 *
 *  @param identifier 标示
 *
 *  @return UDID
 */
+ (NSString *)udid:(NSString *)identifier {
    if (_udid.length != APPUDID_LENGTH) {
        // 优先获取钥匙串中的UDID
        AHKeychain *keychain = [[AHKeychain alloc] initWithIdentifier:APPUDID_IDENTIFIER];
        _udid = [keychain load];
        
        // UDID无效
        if (_udid.length != APPUDID_LENGTH) {
            // 读取本地已存在的OpenUDID
            _udid = [self.class localOpenUDID];
            
            // 本地无OpenUDID, 创建新的UDID
            if (_udid.length != APPUDID_LENGTH)
                _udid = [self.class createUDID];
            
            // 将本地已存在的OpenUDID或新创建的UDID保存到钥匙串
            [keychain save:_udid];
        }
    }
    return _udid;
}

/**
 *  创建UDID
 *
 *  @return UDID
 */
+ (NSString *)createUDID {
    // 创建UUID(32位)
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFUUIDBytes uuidBytes = CFUUIDGetUUIDBytes(uuidRef);
    CFRelease(uuidRef);
    
    // UDID(40位) = UUID(32位) + 随机数(8位)
    NSString *udid = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%08x",
                      uuidBytes.byte0, uuidBytes.byte1, uuidBytes.byte2, uuidBytes.byte3,
                      uuidBytes.byte4, uuidBytes.byte5, uuidBytes.byte6, uuidBytes.byte7,
                      uuidBytes.byte8, uuidBytes.byte9, uuidBytes.byte10, uuidBytes.byte11,
                      uuidBytes.byte12, uuidBytes.byte13, uuidBytes.byte14, uuidBytes.byte15, arc4random() % UINT32_MAX];
    
    return udid;
}

/**
 *  获取本地已存在的OpenUDID
 *
 *  @return openUDID 或 nil
 */
+ (NSString *)localOpenUDID {
    NSString *openUDID = nil;
    
    NSString *kOpenUDIDKey = @"OpenUDID";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id localDict = [defaults objectForKey:kOpenUDIDKey];
    if ([localDict isKindOfClass:[NSDictionary class]]) {
        openUDID = [localDict objectForKey:kOpenUDIDKey];
    }
    
    return openUDID;
}


@end
