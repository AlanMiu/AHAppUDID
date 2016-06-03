//
//  AHAppUDID.h
//  AHKit
//
//  Created by Alan Miu on 15/10/27.
//  Copyright (c) 2015年 AutoHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHAppUDID : NSObject

/**
 *  获取UDID
 *
 *  @return UDID
 */
+ (NSString *)udid;

/**
 *  获取UDID
 *
 *  @param identifier 标示
 *
 *  @return UDID
 */
+ (NSString *)udid:(NSString *)identifier;

@end
