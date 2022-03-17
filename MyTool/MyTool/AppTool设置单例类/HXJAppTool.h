//
//  HXJAppTool.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import <Foundation/Foundation.h>



@interface HXJAppTool : NSObject

#pragma mark - 单例
//单例
+ (instancetype)shareTool;


#pragma mark - APP设置
//导航栏颜色
@property(nonatomic,strong)UIColor *appNaviBarColor;
//主题色
@property(nonatomic,strong)UIColor *appMainColor;



#pragma mark - 数据解析转换
/*!
 字典转字符串
 */
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
/*!
 字符串转字典
 */
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*!
 字符串转数组
 */
+(NSArray *)arrayWithJsonString:(NSString *)jsonString;
/*!
 数组转字符串
 */
+(NSString *)arrayToJson:(NSArray *)array;




//===============MD5加密
#pragma mark - MD5加密
/**
 32位小写
 */
+ (NSString *)MD5ForLower32Bate:(NSString *)str;
/**
 32位大写
 */
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;




//===============判断方法
#pragma mark - 判断方法
//判断是否为整形：
+(BOOL)checkIsPureInt:(NSString*)string;

//判断是否为浮点形：
+(BOOL)checkIsPureFloat:(NSString*)string;

//判断是不是金钱格式
+(BOOL)checkIsMoneyNumberString:(NSString *)string;

//判断是不是手机号
+(BOOL)checkIsPhoneNumberString:(NSString *)string;

//计算文字高度
+(CGFloat)checkCalculatedStringHeightAccoringToWidthWithString:(NSString *)string width:(CGFloat)width font:(CGFloat)font;

//计算文字宽度
+(CGFloat)checkCalculatedStringWidthAccoringToHeightWithString:(NSString *)string height:(CGFloat)height font:(CGFloat)font;




#pragma mark - 二维码生成
/**
  二维码
*/
+ (UIImage *)QRCode_createQRCodeImageWithString:(NSString *)string withSize:(CGFloat)size;



#pragma mark - 其他经常用到的方法
/**
 数字精度丢失，处理返回准确精度
 */
+(NSString *)floatNumberRepair:(id)str;


#pragma mark - 富文本颜色改变
/**
 富文本颜色改变
 */
+(NSMutableAttributedString *)attributedTextWithMessageTotleSting:(NSString *)messageStr selectStr:(NSString *)selectStr selectColor:(UIColor *)color;
/**
 富文本颜色改变
 多个字体改变，两个数组个数要对应
*/
+(NSMutableAttributedString *)attributedTextWithMessageTotleSting:(NSString *)messageStr selectStrArr:(NSArray *)selectStrArr selectColorArr:(NSArray *)colorArr;


#pragma mark - 时间/时间戳转换
/** 获取当前时间戳 */
+ (NSInteger)timeConversion_timestamp;
/**
 获取当前时间
 format：自定义格式
 */
+ (NSString *)timeConversion_getCurrentTimeWithFormat:(NSString *)format;

/** 将日期、时间转换为时间戳 */
+ (NSInteger)timeConversion_dateWithDateStr:(NSString *)dateStr withFormat:(NSString *)format;

/** 将时间戳转换为时间 */
+ (NSString *)timeConversion_dateWithInteger:(NSInteger)integer withFormatter:(NSString *)format;



#pragma mark - 颜色对象 和 颜色16进制字符 互转
/**
 颜色16进制字符串 转 颜色对象
 */
+(UIColor *)color_RGBHexValueStrToUIColor:(NSString*)colorStr;
/**
 颜色对象 转 颜色16进制字符串
 */
+(NSString*)color_UIColoroToRGBHexValueStr:(UIColor*)color;


@end


