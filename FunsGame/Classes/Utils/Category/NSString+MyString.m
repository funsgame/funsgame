//
//  NSString+MyString.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)

//去空格
+ (NSString *)stringBySpaceTrim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)replacingAtWithOctothorpe
{
    return [self stringByReplacingOccurrencesOfString:@"@" withString:@"#"];
}

- (NSString *)replacingOctothorpeWithAt
{
    return [self stringByReplacingOccurrencesOfString:@"#" withString:@"@"];
}

//将回车转成空格
- (NSString *)replacingEnterWithNull
{
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

//是否包含汉字
+ (BOOL)containsChinese:(NSString *)string
{
    for (int i = 0; i < [string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    
    return NO;
}

//回车转@""
+ (NSString*)stringByEnter:(NSString*)string
{
    for (int i = 0; i < [string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a == 0x0d) {
            a = 0x20;
        }
    }
    return string;
}

//null转@""
+ (NSString*)stringByNull:(NSString*)string
{
    if (!string) {
        return @"";
    }
    return string;
}

//null或者@""都返回yes
+ (BOOL)isNull:(NSString *)string
{
    if (!string || [string isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isBlank
{
    if([[self stringByStrippingWhitespace] length] == 0)
    {
        return YES;
    }
    
    return NO;
}

-(NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


//判断是否为整形：

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isEmptyAfterSpaceTrim:(NSString *)string
{
    NSString *str = [self stringBySpaceTrim:string];
    if (str.length == 0) {
        return YES;
    } else {
        return NO;
    }
}

//手机号添加空格
+ (NSString *)addBlank:(NSString *)phone
{
    //去掉-
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSMutableString *string = [NSMutableString string];
    for (int i = 0;i< phone.length; i++) {
        if (i == 2 ||i== 6) {
            [string appendString:[NSString stringWithFormat:@"%@ ",[phone substringWithRange:NSMakeRange(i, 1)]]];
        }else{
            [string appendString:[phone substringWithRange:NSMakeRange(i, 1)]];
            
        }
        
    }
    return string;
}

//浮点型数据不四舍五入
+(NSString *)notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = nil;
    NSDecimalNumber *roundedOunces = nil;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%.2f",[roundedOunces doubleValue]];
}

// 过滤html的所有标志(图片等也被过滤) NSScanner过滤html
+ (NSString *)getClearHtmlString:(NSString *)htmlString clearSpace:(BOOL)clear
{
    // 用来替换清除html代码标签
    NSString *text = nil;
    
    // 创建扫描给定的字符串
    NSScanner *theScanner = [NSScanner scannerWithString:htmlString];
    // 过滤全部html标签
    while (![theScanner isAtEnd])
    {
        // find start of tag 使用NULL为不保留当前位置的某个字符串的内容
        [theScanner scanUpToString:@"<" intoString:NULL];
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text];
        // replace the found tag with a space (you can filter multi-spaces out later if you wish)
        NSString *replaceString = [NSString stringWithFormat:@"%@>", text];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:replaceString withString:@""];
    }
    
    // 替换空格符号"&nbsp;"
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    // 过滤非法字符，如空格等
    if (clear)
    {
        //        NSString *clearString = @"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ <>";
        NSString *clearString = @" ";
        NSCharacterSet *wrongCharacterSet = [NSCharacterSet characterSetWithCharactersInString: clearString];
        NSArray *resultArray = [htmlString componentsSeparatedByCharactersInSet: wrongCharacterSet];
        htmlString = [resultArray componentsJoinedByString: @""];
    }
    
    return htmlString;
}


//普通字符串转换为十六进制的
+ (NSString *)hexStringFromString:(NSString *)string
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%%%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

@end
