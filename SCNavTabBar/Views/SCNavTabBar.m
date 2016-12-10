//
//  SCNavTabBar.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCNavTabBar.h"
#import "CommonMacro.h"
#import "SCPopView.h"

@interface SCNavTabBar () <SCPopViewDelegate>
{
    UIScrollView    *_navgationTabBar;      // all items on this scroll view
    UIImageView     *_arrowButton;          // arrow button
    UIImageView     *_arrowRightButton;
    
    UIView          *_line;                 // underscore show which item selected
    SCPopView       *_popView;              // when item menu, will show this view
    
//    NSMutableArray  *_items;                // SCNavTabBar pressed item
    NSMutableArray  *_itemsWidth;           // an array of items' width
    BOOL            _showArrowButton;       // is showed arrow button
    BOOL            _popItemMenu;           // is needed pop item menu
    CGFloat         _contentWidth;
}
@property (nonatomic,strong) UIView *bottomLine;
@end

@implementation SCNavTabBar

- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show showArrowRightButton:(BOOL)showArrowRightButton
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _showArrowButton = show;
        _showArrowRightButton = showArrowRightButton;
        [self initConfig];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)initConfig
{
    _items = [@[] mutableCopy];
    _arrowImage = [UIImage imageNamed:SCNavTabbarSourceName(@"arrow.png")];
    [self viewConfig];
    [self addTapGestureRecognizer];
}

- (void)viewConfig
{
    CGFloat functionButtonX = (_showArrowButton|| _showArrowRightButton) ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    if (_showArrowButton)
    {
        _arrowButton = [[UIImageView alloc] initWithFrame:CGRectMake(functionButtonX, DOT_COORDINATE, ARROW_BUTTON_WIDTH, ARROW_BUTTON_WIDTH)];
        _arrowButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _arrowButton.image = _arrowImage;
        _arrowButton.userInteractionEnabled = YES;
        [self addSubview:_arrowButton];
       // [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
        [_arrowButton addGestureRecognizer:tapGestureRecognizer];
    }
    if (_showArrowRightButton) {
        _arrowRightButton = [[UIImageView alloc] initWithFrame:CGRectMake(functionButtonX, DOT_COORDINATE+15, ARROW_BUTTON_WIDTH, ARROW_BUTTON_WIDTH-30)];
        _arrowRightButton.image = [UIImage imageNamed:SCNavTabbarSourceName(@"arrowRight")];
        _arrowRightButton.userInteractionEnabled = YES;
        _arrowRightButton.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_arrowRightButton];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(arrowRightClick)];
        [_arrowRightButton addGestureRecognizer:tapGestureRecognizer];
    }

    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, functionButtonX, NAV_TAB_BAR_HEIGHT)];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.bottomLine];
    [self addSubview:_navgationTabBar];
   // [self viewShowShadow:self shadowRadius:10.0f shadowOpacity:10.0f];
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0,NAV_TAB_BAR_HEIGHT+0.5,SCREEN_WIDTH,0.5)];
        _bottomLine.backgroundColor = UIColorWithRGBA(207,210,213,1);
    }
    return _bottomLine;
}

- (void)showLineWithButtonWidth:(CGFloat)width
{
    _line = [[UIView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 3.0f, width - 4.0f, 3.0f)];
    _line.backgroundColor = self.lineColor;
    [_navgationTabBar addSubview:_line];
}

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = UIColorWithRGBA(61.0f, 164.0f, 252.0f, 1.0f);
    }
    return _lineColor;
}

- (void)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = DOT_COORDINATE;
    for (NSInteger index = 0; index < [_itemTitles count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, DOT_COORDINATE, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:_titleColor forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:(self.titleFontSize==0?15:self.titleFontSize)]];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_navgationTabBar addSubview:button];
        
        [_items addObject:button];
        buttonX += [widths[index] floatValue];
    }
    _selectedBtn = _items[0];
    [_selectedBtn setTitleColor:_titleSelectedColor forState:UIControlStateNormal];
    [self showLineWithButtonWidth:[widths[0] floatValue]];
}

- (void)updateNavTaBarTitleWithIndex:(NSInteger)index title:(NSString *)title {
    index = index>(_items.count-1)?(_items.count-1):index;
    UIButton *titleBtn = _items[index];
    [titleBtn setTitle:title forState:UIControlStateNormal];
}


- (void)addTapGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
    [_arrowButton addGestureRecognizer:tapGestureRecognizer];
}

- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    [_delegate itemDidSelectedWithIndex:index];
}

- (void)functionButtonPressed
{
    _popItemMenu = !_popItemMenu;
    [_delegate shouldPopNavgationItemMenu:_popItemMenu height:[self popMenuHeight]];
}

- (void)arrowRightClick {
    if ([self.delegate respondsToSelector:@selector(arrowRightButtonPressed)]) {
        [self.delegate arrowRightButtonPressed];
    }
}

- (NSMutableArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    _contentWidth = 0;
    float extFloat = 0;
    if (self.tabDefaultPadding == 0) {
        _tabDefaultPadding = 40.0f;
    }
    for (NSString *title in titles)
    {
//        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:(self.titleFontSize==0?15:self.titleFontSize)]];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:(self.titleFontSize==0?15:self.titleFontSize)]};
        CGSize size = [title sizeWithAttributes:attributes];
        _contentWidth += (size.width + _tabDefaultPadding);
        NSNumber *width = [NSNumber numberWithFloat:size.width + _tabDefaultPadding];
        [widths addObject:width];
    }
    if ((SCREEN_WIDTH - _contentWidth)>0) {
        extFloat = (SCREEN_WIDTH - _contentWidth)/widths.count;
    }
    if (extFloat>0 && _isEvenNavTabBar) {
        for (int i=0; i<widths.count; i++) {
            NSNumber *temp = widths[i];
            [widths replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:([temp floatValue]+extFloat)]];
            temp = nil;
        }
    }
    
    return widths;
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)popMenuHeight
{
    CGFloat buttonX = DOT_COORDINATE;
    CGFloat buttonY = ITEM_HEIGHT;
    CGFloat maxHeight = SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - NAV_TAB_BAR_HEIGHT;
    for (NSInteger index = 0; index < [_itemsWidth count]; index++)
    {
        buttonX += [_itemsWidth[index] floatValue];
        
        @try {
            if ((buttonX + [_itemsWidth[index + 1] floatValue]) >= SCREEN_WIDTH)
            {
                buttonX = DOT_COORDINATE;
                buttonY += ITEM_HEIGHT;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    buttonY = (buttonY > maxHeight) ? maxHeight : buttonY;
    return buttonY;
}

- (void)popItemMenu:(BOOL)pop
{
    if (pop)
    {
        //[self viewShowShadow:_arrowButton shadowRadius:DOT_COORDINATE shadowOpacity:DOT_COORDINATE];
        [UIView animateWithDuration:0.5f animations:^{
            _navgationTabBar.hidden = YES;
            _arrowButton.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                if (!_popView)
                {
                    _popView = [[SCPopView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, self.frame.size.height - NAVIGATION_BAR_HEIGHT)];
                    _popView.delegate = self;
                    _popView.itemNames = _itemTitles;
                    [self addSubview:_popView];
                }
                _popView.hidden = NO;
            }];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _popView.hidden = !_popView.hidden;
            _arrowButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            _navgationTabBar.hidden = !_navgationTabBar.hidden;
            //[self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
        }];
    }
}

#pragma mark -
#pragma mark - Public Methods
- (void)setArrowImage:(UIImage *)arrowImage
{
    _arrowImage = arrowImage ? arrowImage : _arrowImage;
    _arrowButton.image = _arrowImage;
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    CGFloat flag = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    
    if (button.frame.origin.x + button.frame.size.width > flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (_currentItemIndex < [_itemTitles count] - 1)
        {
            offsetX = offsetX + 40.0f;
        }
        
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, DOT_COORDINATE) animated:YES];
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(DOT_COORDINATE, DOT_COORDINATE) animated:YES];
    }
    [UIView animateWithDuration:0.2f animations:^{
        _line.frame = CGRectMake(button.frame.origin.x + 2.0f, _line.frame.origin.y, [_itemsWidth[currentItemIndex] floatValue] - 4.0f, _line.frame.size.height);
        [_selectedBtn setTitleColor:_titleColor forState:UIControlStateNormal];
        _selectedBtn = _items[currentItemIndex];
        [_selectedBtn setTitleColor:_titleSelectedColor forState:UIControlStateNormal];
    }];
}

- (void)updateData
{
    _arrowButton.backgroundColor = self.backgroundColor;
    
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
        [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(_contentWidth, DOT_COORDINATE);
    }
}

- (void)refresh
{
    [self popItemMenu:_popItemMenu];
}

#pragma mark - SCFunctionView Delegate Methods
#pragma mark -
- (void)itemPressedWithIndex:(NSInteger)index
{
    [self functionButtonPressed];
    [_delegate itemDidSelectedWithIndex:index];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
