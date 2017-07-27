//  macro.h
//  iOS 相关宏定义

#ifndef MOS_macro_h
#define MOS_macro_h

#ifdef __cplusplus
extern "C" {
#endif

#pragma mark - Device && Screen
/// 判断是否是iPhone5
#define isPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
/// 是否模拟器
#ifdef TARGET_IPHONE_SIMULATOR
#define isSimulator TARGET_IPHONE_SIMULATOR
#endif
///URL 头

//登录信息
#define USER_NAME @"username"
#define USER_PWD @"userpassword"
#define LOGINFO_KEY @"logInfoKey"
#define USERNAME @"userName"
#define USER_PHOTO @"userPhone"
#define USER_ID @"userId"

    
#define Screen_frame [UIScreen mainScreen].bounds
//self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;
/// 屏幕高度、宽度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define PageSize @"20"
#pragma mark - System Version

// 我的界面的比例布局。目前4寸为基本
#define HOME_HEIGHT  Screen_height < 568 ? 420 : Screen_height
#define HOME_TOP_HEIGHT    (HOME_HEIGHT-64-49-44)*0.35
#define HOME_CENTER_HEIGHT (HOME_HEIGHT-64-49-44)*0.2
#define HOME_TODO_HEIGHT 44
#define HOME_BOTTOM_HEIGHT (HOME_HEIGHT-64-49-44)*0.45

/// 当前系统版本大于等于某版本
#define IOS_SYSTEM_VERSION_EQUAL_OR_ABOVE(v) (([[[UIDevice currentDevice] systemVersion] floatValue] >= (v))? (YES):(NO))
/// 当前系统版本小于等于某版本
#define IOS_SYSTEM_VERSION_EQUAL_OR_BELOW(v) (([[[UIDevice currentDevice] systemVersion] floatValue] <= (v))? (YES):(NO))
/// 当前系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define iOS7 (IOS_SYSTEM_VERSION >= 7.0)
/// 系统语言
#define IOS_SYSTEM_Language ([[NSLocale preferredLanguages] objectAtIndex:0])
/// 当前应用版本号
#define AppVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]
#pragma mark - common path
/// 常用文件路径
#define PathForDocument NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define PathForLibrary NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES)[0]
#define PathForCaches NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES)[0]
#pragma mark - shared tool
#define SharedUserDefault [NSUserDefaults standardUserDefaults]
#define SharedNotificationCenter [NSNotificationCenter defaultCenter]
#define SharedFileManager [NSFileManager defaultManager]
#define SharedApplicationDelegate [[UIApplication sharedApplication] delegate]
#pragma mark - image && color
/// 加载图片
#define UIImageLoad(name, type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:type]]
#define UIImageNamed( name ) [UIImage imageNamed: name]
/// 颜色
#define UIColorWithRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorWithRGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
// 默认头像
#define NAN_AVATAR              UIImageNamed(@"nan_avatar.png")
#define NV_AVATAR                 UIImageNamed(@"nv_avatar.png")
#define NOKNOWN_AVATAR  UIImageNamed(@"unknown_avatar.png")

#pragma mark - GCD
/** 全局线程执行方法 */
extern void st_dispatch_async_global(dispatch_block_t block);
/** 主线程执行方法 */
extern void st_dispatch_async_main(dispatch_block_t block);
/** 主线程延时执行方法 */
extern void st_dispatch_async_main_after(NSTimeInterval ti, dispatch_block_t block);

    
/** 根据给定字体计算单位高度 */
extern CGFloat UnitHeightOfFont(UIFont*font);

/** 根据字符串、最大尺寸、字体计算字符串最合适尺寸 */
extern CGSize CGSizeOfString(NSString * text, CGSize maxSize, UIFont * font);
/** 设置视图大小，原点不变 */
extern void SetViewSize(UIView *view, CGSize size);
/** 设置视图宽度，其他不变 */
void SetViewSizeWidth(UIView *view, CGFloat width);
/** 设置视图高度，其他不变 */
void SetViewSizeHeight(UIView *view, CGFloat height);
/** 设置视图原点，大小不变 */
extern void SetViewOrigin(UIView *view, CGPoint pt);
/** 设置视图原点x坐标，大小不变 */
extern void SetViewOriginX(UIView *view, CGFloat x);
/** 设置视图原点y坐标，大小不变 */
extern void SetViewOriginY(UIView *view, CGFloat y);

extern void setSubviewDelaysContentTouchesNO(UIView * v);

/** data format */

/** 根据文件类型获取文件图片 */
extern UIImage* FileImageWithFileType(NSString *type);

/** 颜色转图片 */
extern UIImage* CreateImageWithColor(UIColor *color);

#define NSStringFromNumber_c( __v__ ) [NSString stringWithFormat:@"%@", @(__v__)]
#define NSStringFromObject_oc( __v__ ) [NSString stringWithFormat:@"%@", __v__]
    
    
#pragma mark - 可变参数格式化
extern NSString* StringWithFormat(NSString*format,...);

    
    

#pragma mark - DEBUG
/** ======================= 调试相关宏定义 ========================== */
/// 添加调试控制台输出
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d]\n😄 " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ELog(fmt, ...) NSLog((@"%s [Line %d]\n😥 " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#define ELog(...)
#define NSLog(...)
#endif
/// 是否输出dealloc log
//#define Dealloc
#ifdef Dealloc
#define DeallocLog(fmt, ...) NSLog((fmt @"dealloc ..."), ##__VA_ARGS__);
#else
#define DeallocLog(...)
#endif

#pragma mark - singleton
//singleton
//
// SynthesizeSingleton.h
// CocoaWithLove
//
// Created by Matt Gallagher on 20/10/08.
// Copyright 2009 Matt Gallagher. All rights reserved.
//
// Permission is given to use this source code file without charge in any
// project, commercial or otherwise, entirely at your risk, with the condition
// that any redistribution (in part or whole) of source code must retain
// this copyright and permission notice. Attribution in compiled projects is
// appreciated but not required.
//
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#ifdef __cplusplus
}
#endif



// .h
#define singleton_interface(className) + (instancetype)shared##className;

// .m
// 最后一句不要斜线
#define singleton_implementation(className) \
static className *_instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
\
return _instace; \
} \
\
+ (instancetype)shared##className \
{ \
if (_instace == nil) { \
_instace = [[className alloc] init]; \
} \
\
return _instace; \
}

/** ======================= 字符串格式化宏定义 ========================== */

#define FMI_Str(objc) [NSString stringWithFormat:@"%ld",objc]
#define FMS_Str(objc) [NSString stringWithFormat:@"%@",objc]
#define APPEND_Str(abc,def) [NSString stringWithFormat:@"%@%@",abc,def]

#endif
