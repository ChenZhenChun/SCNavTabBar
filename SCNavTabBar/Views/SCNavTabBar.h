//
//  SCNavTabBar.h
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCNavTabBarDelegate <NSObject>

@optional
/**
 *  When NavTabBar Item Is Pressed Call Back
 *
 *  @param index - pressed item's index
 */
- (void)itemDidSelectedWithIndex:(NSInteger)index;

/**
 *  When Arrow Pressed Will Call Back
 *
 *  @param pop    - is needed pop menu
 *  @param height - menu height
 */
- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height;

- (void)arrowRightButtonPressed;

@end

@interface SCNavTabBar : UIView

@property (nonatomic, weak)     id          <SCNavTabBarDelegate>delegate;

@property (nonatomic, assign)   NSInteger   currentItemIndex;           // current selected item's index
@property (nonatomic, strong)   NSArray     *itemTitles;                // all items' title

@property (nonatomic, strong)   UIColor     *lineColor;                 // set the underscore color
@property (nonatomic, strong)   UIColor     *titleColor;
@property (nonatomic, strong)   UIColor     *titleSelectedColor;
@property (nonatomic, assign)   CGFloat     titleFontSize;
@property (nonatomic, strong)   UIImage     *arrowImage;                // set arrow button's image
@property (nonatomic, assign)   BOOL        isEvenNavTabBar;            // Default value: NO
@property (nonatomic, assign)   BOOL        showArrowRightButton;       // Default value: NO
@property (nonatomic, assign)   CGFloat     tabDefaultPadding;// Default value: 40
@property (nonatomic, strong)   NSMutableArray  *items;                // SCNavTabBar pressed item
@property (nonatomic, strong)   UIButton    *selectedBtn;               //seleted navtabBarButtom 

/**
 *  Initialize Methods
 *
 *  @param frame - SCNavTabBar frame
 *  @param show  - is show Arrow Button
 *
 *  @return Instance
 */
- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show showArrowRightButton:(BOOL)showArrowRightButton;

/**
 *  Update Item Data
 */
- (void)updateData;

/**
 *  Refresh All Subview
 */
- (void)refresh;


/**
 *  修改tabar标题
 *
 *  @param index tabar索引  从0开始
 *  @param title 标题内容
 */
- (void)updateNavTaBarTitleWithIndex:(NSInteger)index title:(NSString *)title;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
