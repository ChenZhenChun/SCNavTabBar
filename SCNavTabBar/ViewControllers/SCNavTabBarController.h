//
//  SCNavTabBarController.h
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCNavTabBarController : UIViewController

@property (nonatomic, assign)   BOOL        showArrowButton;     // Default value: NO(右侧更多按钮)
@property (nonatomic, assign)   BOOL        showArrowRightButton;// Default value: NO(右侧跳转小箭头按钮)
@property (nonatomic, assign)   BOOL        scrollAnimation;     // Default value: NO
@property (nonatomic, assign)   BOOL        mainViewBounces;     // Default value: NO
@property (nonatomic, assign)   BOOL        isEvenNavTabBar;     // Default value:YES（navTabBar是否被平均分配）
@property (nonatomic, assign)   CGFloat     tabDefaultPadding;// Default value: 40 (配置每一个tab的默认左右空隙)
@property (nonatomic, strong)   NSMutableArray     *subViewControllers;        // An array of children view controllers
@property (nonatomic, strong)   UIColor     *navTabBarColor;            // Could not set [UIColor clear], if you set, NavTabbar will show initialize color
@property (nonatomic, assign)   CGFloat     titleFontSize;
@property (nonatomic, strong)   UIColor     *navTabBarTitleColor;
@property (nonatomic, strong)   UIColor     *navTabBarSeletedTitleColor;
@property (nonatomic, strong)   UIColor     *navTabBarLineColor;
@property (nonatomic, strong)   UIImage     *navTabBarArrowImage;


/**
 *  Initialize Methods
 *
 *  @param show - is show the arrow button
 *
 *  @return Instance
 */
- (id)initWithShowArrowButton:(BOOL)show;

/**
 *  Initialize SCNavTabBarViewController Instance And Show Children View Controllers
 *
 *  @param subViewControllers - set an array of children view controllers
 *
 *  @return Instance
 */
- (id)initWithSubViewControllers:(NSMutableArray *)subViewControllers;

/**
 *  Initialize SCNavTabBarViewController Instance And Show On The Parent View Controller
 *
 *  @param viewController - set parent view controller
 *
 *  @return Instance
 */
- (id)initWithParentViewController:(UIViewController *)viewController;

/**
 *  Initialize SCNavTabBarViewController Instance, Show On The Parent View Controller And Show On The Parent View Controller
 *
 *  @param subControllers - set an array of children view controllers
 *  @param viewController - set parent view controller
 *  @param show           - is show the arrow button
 *
 *  @return Instance
 */
- (id)initWithSubViewControllers:(NSMutableArray *)subControllers andParentViewController:(UIViewController *)viewController showArrowButton:(BOOL)show;

/**
 *  Show On The Parent View Controller
 *
 *  @param viewController - set parent view controller
 */
- (void)addParentController:(UIViewController *)viewController;

//添加选项卡到父控制器的一个子view上
- (void)addParentController:(UIViewController *)viewController withControllerView:(UIView *)view;

/**
 *  定位navTabBar初始位置
 *
 *  @param index navTabBarButtom 索引 从0开始
 */
- (void)itemSelectedWithIndex:(NSInteger)index;

/**
 *  navTabBar右侧小箭头点击事件
 *  showArrowRightButton = YES;才能出现小箭头按钮
 */
- (void)arrowRightButtonPressed:(void(^)())block;

/**
 *  修改navtabBarButtom标题
 *
 *  @param index tabar索引  从0开始
 *  @param title 标题内容
 */
- (void)updateNavTaBarTitleWithIndex:(NSInteger)index title:(NSString *)title;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
