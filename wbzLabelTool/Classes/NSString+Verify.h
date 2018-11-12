//
//  NSString+MyPhone.h
//  FanbaMobileApp
//
//  Created by yytmzys on 16/1/11.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

/// 验证手机号码, 正确:YES , 错误: 提示
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/// 验证 18 位 身份证号, 正确:YES , 错误:NO
+ (BOOL)verifyIDCard:(NSString *)identityCard;

/// 验证字符串为空 ,为空:YES, 不为空:NO
+ (BOOL)StringIsNULL:(NSString *)string;

/// 验证字符串为空 ,为空:YES, 不为空:NO
+ (BOOL)MyStringIsNULL:(NSString *)string;

/// 判断某个字符串的长度是否在某个范围内0除外
- (BOOL)RangeMinNum:(int) minNum maxNum:(int) maxNum;

/// 判断是否只有数字或字母
+ (BOOL)isOnlyNumAndLetter:(NSString *)string;

+(BOOL)judgePassWordLegal:(NSString *)pass;

/// 纯中文
- (BOOL)isChinese;

- (BOOL)isIntNum;

- (BOOL)isFloat_two;

+ (BOOL)isPureFloat:(NSString *)string;

+(BOOL)isRightPs:(NSString *)string;

@end
