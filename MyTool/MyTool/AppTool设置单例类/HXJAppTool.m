//
//  HXJAppTool.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "HXJAppTool.h"

#import <CommonCrypto/CommonDigest.h>


@implementation HXJAppTool

#pragma mark - 单例
+ (instancetype)shareTool{
    
    static HXJAppTool *_shareAppTool=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _shareAppTool=[[HXJAppTool alloc]init];
    });
    
    return _shareAppTool;
}


#pragma mark - APP设置
-(UIColor *)appNaviBarColor{
    
    if (_appNaviBarColor==nil) {
        
        //本地取颜色
        NSString *appNaviBarColorStr = n_UserDefaultsGet(n_ThemeColor_appNaviBarColor);
        
        _appNaviBarColor=[HXJAppTool color_RGBHexValueStrToUIColor:appNaviBarColorStr];
    }
    
    return _appNaviBarColor;
}

-(UIColor *)appMainColor{
    
    if (_appMainColor==nil) {
        
        //本地取颜色
        NSString *appMainColorStr = n_UserDefaultsGet(n_ThemeColor_appMainColor);
        
        _appMainColor=[HXJAppTool color_RGBHexValueStrToUIColor:appMainColorStr];
    }
    
    return _appMainColor;
}



#pragma mark - 数据解析转换
+(NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
    
    if (err) {
        NSLog(@"Dic转String失败：%@",err);
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    NSString *jsonStr=[NSString stringWithFormat:@"%@",jsonString];
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"jsonStr转Dic失败：%@",err);
        return nil;
    }
    
    return dic;
}

+(NSString *)arrayToJson:(NSArray *)array{
    
    NSError *err = nil;
    if (array) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&err];
        
        if (err) {
            NSLog(@"array转Str失败：%@",err);
            return nil;
        }
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

+(NSArray *)arrayWithJsonString:(NSString *)jsonString{
    
    NSString *jsonStr=[NSString stringWithFormat:@"%@",jsonString];
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"jsonString转Arr失败：%@",err);
        return nil;
    }
    
    return array;
}


//===============MD5加密
#pragma mark - MD5加密
//32位 小写
+ (NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

//32位 大写
+ (NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}


#pragma mark - 判断方法
//判断是否为整形：
+(BOOL)checkIsPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


//判断是否为浮点形：
+(BOOL)checkIsPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//判断是不是金钱格式
+(BOOL)checkIsMoneyNumberString:(NSString *)string{
    
    if( [self checkIsPureInt:string] == YES || [self checkIsPureFloat:string] == YES ){
        if ([string length]>0){
            unichar single=[string characterAtIndex:0];
            if ((single >='0' && single<='9') || single=='.'){
                //第一个数是小数点
                if (single=='.'){
                    NSString *subStr=[string substringFromIndex:1];
                    if ([subStr rangeOfString:@"."].location==NSNotFound) {
                        if (subStr.length <= 2) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return NO;
                    }
                    //第一个数字不是小数点
                }else{
                    //没有小数点的数
                    if ([string rangeOfString:@"."].location==NSNotFound) {
                        return YES;
                    }else{
                        //判断小数点的个数
                        NSRange range1=[string rangeOfString:@"."];
                        NSString *str1=[string substringFromIndex:range1.location+1];
                        if ([str1 rangeOfString:@"."].location==NSNotFound) {
                            if (str1.length <= 2) {
                                return YES;
                            }else{
                                return NO;
                            }
                        }else{
                            return NO;
                        }
                    }
                }
                //第一个数字不是0-9 和 ，
            }else{
                return NO;
            }
            //没有长度
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}


//判断是不是手机号
+(BOOL)checkIsPhoneNumberString:(NSString *)string{
    
    if (string.length == 0 || string.length != 11) {
        
        return NO;
        
    }else {
        
        //验证手机号码是否正确   手机号以13， 15，18 17 开头，八个 \d 数字字符
//        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}$";
//        NSString *phoneRegex =@"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
//        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//        BOOL  isMobileNum = [phoneTest evaluateWithObject:string];
//
//        return isMobileNum;
        
        return YES;
    }
    
}

//计算文字高度
+(CGFloat)checkCalculatedStringHeightAccoringToWidthWithString:(NSString *)string width:(CGFloat)width font:(CGFloat)font{
    
    CGRect contentBounds = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    
    return contentBounds.size.height;
    
}


//计算文字宽度
+(CGFloat)checkCalculatedStringWidthAccoringToHeightWithString:(NSString *)string height:(CGFloat)height font:(CGFloat)font{
    
    CGRect contentBounds = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    return contentBounds.size.width;
    
}


#pragma mark - 二维码生成
+ (UIImage *)QRCode_createQRCodeImageWithString:(NSString *)string withSize:(CGFloat)size{
    // 实例化二维码滤镜
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性（因为滤镜可能保存上一次的属性）
    [filter setDefaults];
    // 讲字符串转换为NSData
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 通过了滤镜输出的图像
    CIImage * outputImage = [filter outputImage];
    // 来获得高清的二维码图片
    UIImage * image = [self getQRCodeImageFormCIImage:outputImage withSize:size];
    return image;
}

+(UIImage *)getQRCodeImageFormCIImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



#pragma mark - 其他经常用到的方法
/**
数字精度丢失，处理返回准确精度
*/
+(NSString *)floatNumberRepair:(id)str{
    
    NSString *tempStr=[NSString stringWithFormat:@"%@",str];
    
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [tempStr doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}



#pragma mark - 富文本颜色改变
+(NSMutableAttributedString *)attributedTextWithMessageTotleSting:(NSString *)messageStr selectStr:(NSString *)selectStr selectColor:(UIColor *)color{
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",messageStr]];
    
    NSRange range=[messageStr rangeOfString:[NSString stringWithFormat:@"%@",selectStr]];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return attrStr;
}

+(NSMutableAttributedString *)attributedTextWithMessageTotleSting:(NSString *)messageStr selectStrArr:(NSArray *)selectStrArr selectColorArr:(NSArray *)colorArr{
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",messageStr]];
    
    NSInteger selectStrArrCount = selectStrArr.count;
     
    for (int i=0; i<selectStrArrCount; i++) {
        
        NSString *selectStr=[NSString stringWithFormat:@"%@",selectStrArr[i]];
        UIColor *color=colorArr[i];
        
        NSRange range=[messageStr rangeOfString:selectStr];
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        
    }
    
    return attrStr;
}



#pragma mark - 时间/时间戳转换
+ (NSInteger)timeConversion_timestamp {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    //时间转时间戳的方法:
    NSInteger timestamp = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] integerValue];
    
    return timestamp;
}

+ (NSString *)timeConversion_getCurrentTimeWithFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString * currentTimeStr = [formatter stringFromDate:[NSDate date]];
    
    return currentTimeStr;
}

+ (NSInteger)timeConversion_dateWithDateStr:(NSString *)dateStr withFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"yyyy-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:dateStr]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return timestamp;
}

+ (NSString *)timeConversion_dateWithInteger:(NSInteger)integer withFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:integer];
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}



#pragma mark - 颜色对象 和 颜色16进制字符 互转
/**
 颜色16进制字符串 转 颜色对象
 */
+(UIColor *)color_RGBHexValueStrToUIColor:(NSString*)colorStr{
    
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/**
 颜色对象 转 颜色16进制字符串
 */
+(NSString*)color_UIColoroToRGBHexValueStr:(UIColor*)color{
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
   
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    
    return [NSString stringWithFormat:@"%06x", rgb];
}



@end
