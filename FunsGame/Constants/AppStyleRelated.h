//
//  AppStyleRelated.h
//  FDSDemo
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  功能描述:定义系统颜色／字体等

#ifndef FDSDemo_AppStyleRelated_h
#define FDSDemo_AppStyleRelated_h

/*********************** Font ***************************/
#pragma mark- Font

// 大小-细体
/// 7.5号字体
#define kFontSize8 [UIFont systemFontOfSize:7.5]

/// 9号字体
#define kFontSize9 [UIFont systemFontOfSize:9.0]

/// 10号字体
#define kFontSize10 [UIFont systemFontOfSize:10.0]

/// 11号字体
#define kFontSize11 [UIFont systemFontOfSize:11.0]

/// 12号字体
#define kFontSize12 [UIFont systemFontOfSize:12.0]

/// 13号字体
#define kFontSize13 [UIFont systemFontOfSize:13.0]

/// 14号字体
#define kFontSize14 [UIFont systemFontOfSize:14.0]

/// 15号字体
#define kFontSize15 [UIFont systemFontOfSize:15.0]

/// 16号字体
#define kFontSize16 [UIFont systemFontOfSize:16.0]

/// 17号字体
#define kFontSize17 [UIFont systemFontOfSize:17.0]

/// 18号字体
#define kFontSize18 [UIFont systemFontOfSize:18.0]

/// 19号字体
#define kFontSize19 [UIFont systemFontOfSize:19.0]

/// 20号字体
#define kFontSize20 [UIFont systemFontOfSize:20.0]

/// 21号字体
#define kFontSize21 [UIFont systemFontOfSize:21.0]

/// 22号字体
#define kFontSize22 [UIFont systemFontOfSize:22.0]

/// 23号字体
#define kFontSize23 [UIFont systemFontOfSize:23.0]

/// 24号字体
#define kFontSize24 [UIFont systemFontOfSize:24.0]

/// 25号字体
#define kFontSize25 [UIFont systemFontOfSize:25.0]

/// 30号字体
#define kFontSize30 [UIFont systemFontOfSize:30.0]

/// 50号字体
#define kFontSize50 [UIFont systemFontOfSize:50.0]

/// 60号字体
#define kFontSize60 [UIFont systemFontOfSize:60.0]

// 大小-粗体
/// 10号粗字体
#define kFontSizeBold10 [UIFont boldSystemFontOfSize:10.0]

/// 11号粗字体
#define kFontSizeBold11 [UIFont boldSystemFontOfSize:11.0]

/// 12号粗字体
#define kFontSizeBold12 [UIFont boldSystemFontOfSize:12.0]

/// 13号粗字体
#define kFontSizeBold13 [UIFont boldSystemFontOfSize:13.0]

/// 14号粗字体
#define kFontSizeBold14 [UIFont boldSystemFontOfSize:14.0]

/// 15号粗字体
#define kFontSizeBold15 [UIFont boldSystemFontOfSize:15.0]

/// 16号粗字体
#define kFontSizeBold16 [UIFont boldSystemFontOfSize:16.0]

/// 17号粗字体
#define kFontSizeBold17 [UIFont boldSystemFontOfSize:17.0]

/// 18号粗字体
#define kFontSizeBold18 [UIFont boldSystemFontOfSize:18.0]

/// 19号粗字体
#define kFontSizeBold19 [UIFont boldSystemFontOfSize:19.0]

/// 20号字粗体
#define kFontSizeBold20 [UIFont boldSystemFontOfSize:20.0]

/// 21号字粗体
#define kFontSizeBold21 [UIFont boldSystemFontOfSize:21.0]
/// 大小-粗体

/********************** Color ****************************/
#pragma mark- Color

// 颜色

/// 导航栏背景颜色
#define kColorNavBground UIColorHex(@"#2e3737")

/// 透明色
#define kColorClear [UIColor clearColor]

/// 白色-如导航栏字体颜色
#define kColorWhite UIColorHex(@"#ffffff")

/// 淡灰色-如普通界面的背景颜色
#define kColorLightgrayBackground UIColorHex(@"#f5f5f5")

/// 灰色—如内容字体颜色
#define kColorLightgrayContent UIColorHex(@"#969696")

/// 灰色-如输入框占位符字体颜色
#define kColorLightgrayPlaceholder UIColorHex(@"#aaaaaa")

/// 深灰色
#define kColorDarkgray UIColorHex(@"#666666")

/// 黑色-如输入框输入字体颜色或标题颜色
#define kColorBlack UIColorHex(@"#333333")

/// 黑色-纯黑
#define kColorDeepBlack UIColorHex(@"000000")

/// 灰色—如列表cell分割线颜色
#define kColorSeparatorline UIColorHex(@"#d1d1d1")

/// 灰色-边框线颜色
#define kColorBorderline UIColorHex(@"#b8b8b8")

/// 绿色-如导航栏背景颜色
#define kColorGreenNavBground UIColorHex(@"#38ad7a")

/// 绿色
#define kColorGreen UIColorHex(@"#349c6f")

/// 深绿色
#define kColorDarkGreen UIColorHex(@"#188d5a")

/// 橙色
#define kColorOrange UIColorHex(@"#fe933d")

/// 深橙色
#define kColorDarkOrange UIColorHex(@"#e48437")

/// 淡紫色
#define kColorLightPurple UIColorHex(@"#909af8")

/// 红色
#define kColorRed UIColorHex(@"#fd492e")

/// 蓝色
#define kColorBlue UIColorHex(@"#0076ff")

/// 高雅黑
#define kColorElegantBlack UIColorRGB(29, 31, 38)


/**************************************************/
#define IQKeyboardDistanceFromTextField 50

/********************** message ****************************/
#pragma mark- message

#define AlertTitle @"温馨提示"
#define AlertCancel @"取消"
#define AlertExit @"退出"
#define AlertConfirm @"确定"
#define AlertClose @"关闭"
#define AlertUpgrade @"去升级"
#define AlertUpDate @"立即更新"

#define WithoutData @"暂无数据"
#define WithoutInvestmentData @"暂无可投资项目"

/*********************** 常量 ***************************/
#pragma mark-

#define kSeparatorlineHeight 0.5
#define kLeftSize 110

#endif
