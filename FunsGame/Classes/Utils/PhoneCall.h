//
//  PhoneCall.h
//  kinhop
//
//  Created by weibin on 14/12/23.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneCall : NSObject

typedef void (^ACETelCallBlock)(NSTimeInterval duration);
typedef void (^ACETelCancelBlock)(void);

+ (BOOL)callPhoneNumber:(NSString *)phoneNumber
                   call:(ACETelCallBlock)callBlock
                 cancel:(ACETelCancelBlock)cancelBlock;

@end
