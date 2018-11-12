//
//  NSString+MyPhone.m
//  FanbaMobileApp
//
//  Created by yytmzys on 16/1/11.
//
//

#import "NSString+Verify.h"

@implementation NSString (Verify)


/// 验证手机号码, 正确:YES , 错误:NO
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    // NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0136-8]|8[0-9])\\d{8}$";
    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9]|9[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES){
        return YES;
    }
    
    return NO;
}

/// 验证 18 位 身份证号, 正确:YES , 错误:NO
+ (BOOL)verifyIDCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0){
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    
    /// 如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identityCard.length == 18)
        {
            /// 将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            /// 这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            /// 用来保存前17位各自乖以加权因子后的总和
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum += subStrIndex * idCardWiIndex;
            }
            
            /// 计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            /// 得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            /// 如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                /// 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
}

+ (BOOL)StringIsNULL:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
}

/// 验证字符串为空 ,为空:YES, 不为空:NO
+ (BOOL)MyStringIsNULL:(NSString *)string
{
    //    NSLog(@"string == %@", string);
    if (string == nil || string == NULL || [string  isEqual:NULL]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}

/// 判断某个字符串的长度是否在某个范围内0除外
- (BOOL)RangeMinNum:(int) minNum maxNum:(int) maxNum
{
    if ((self.length >= minNum) && (self.length <= maxNum) && (self.length != 0)) {
        return YES;
    }
    return NO;
}

/// 判断是否只有数字或字母
+ (BOOL)isOnlyNumAndLetter:(NSString *)string
{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
    s = [s invertedSet];
    NSRange r = [string rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        return NO;
    }
    return YES;
    
//    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9]{6,20}$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    if ([predicate evaluateWithObject:self]) {
//        return YES;
//    }
//    return NO;
}

+(BOOL)judgePassWordLegal:(NSString *)pass
{
    BOOL result = false;
    
    // 判断长度大于8位后再接着判断是否同时包含数字和字符
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    
    return result;
}

/// 纯中文
- (BOOL)isChinese
{                    //    [\u4e00-\u9fa5]+
    NSString *regex = @"$|^[\u4E00-\u9FA5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}
/// 验证零和非零开头的数字
- (BOOL)isFloat_two
{
    NSString *regex = @"^[0-9]+(.[0-9]{1+2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

- (BOOL)isIntNum
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:self] == YES) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPureFloat:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+(BOOL)isRightPs:(NSString *)string
{
//   NSString *regex= @"^(?=\\d+)(?!(\\d)\1{5})\\d{6}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    if ([regextestmobile evaluateWithObject:string] == YES){
//        return YES;
//    }
    NSString *str=@"01234567890_09876543210";
    if ([str rangeOfString:string].length!=0) {
        return NO;
    }
    if ([string integerValue]==0||[string integerValue]%111111==0) {
        return NO;
    }
    
    return YES;
}

@end
