//
//  ViewController.m
//  autolayout
//
//  Created by 陈小雅 on 16/10/14.
//  Copyright © 2016年 陈小雅. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ALEngine.h"

@interface ViewController () <UIScrollViewDelegate>
{
    ALView * _section1;
    ALView * _body;
    ALView * _block;
    ALLabel * _allabel;
    
    ALLabel * _nicklabel;
    ALLabel * _vlabel;
    ALLabel * _timelabel;
    
    UIView * _testInlineView;
    
    ALView * _wrap;
    ALView * _absView1;
    ALView * _absView2;
    ALView * _absView3;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 测试单元
//    [self initLayoutWithMargin];
//    [self initLayout];
//    [self initLayoutWithAbsolute];
//    [self initLayoutWithAbsolutePriority];
//    [self initLayoutWithScrollView];
//    [self initMixScrollLayout];
//    [self initBlockContentBlockLayout];
//    [self initBlockContentInlineLayout];
//    [self initBlockContentMixLayout];
//    [self initInlineAutoWidthHeightLayout];
//    [self initALLabelAutoHeightWidthLayout];
//    [self initBlockAndInlineLayout1];
//    [self initBlockAndInlineLayout2];
    // demo
//    [self initInlineLayout];
//    [self initBlockLayout];
//    [self initInlineLayout];
//    [self initMarginLayout];
//    [self initPaddingLayout];
//    [self initWithALEngineLayout];
//    [self initALLabelAndAutoBlockLayout];
//    [self initWithRelativeViewLayout];
//    [self initWithAbsuluteLayout];
//    [self initWithBlockLayout];
//    [self initDemoOfSize];
//    [self initDemoOfMaxSize];
//    [self initDemoOfAbsolute];
//    [self initDemoOfDynamicAbsolute];
//    [self initDemoOfPadding];
//    [self initDemoOfBreak];
    [self initDemoOfBreakHack];
    
//    [self initDynamicLayout];
    
//    [self initDynamicAbsolute];
//    [self initDynamicLayout2];
//    [self initPositionAutoSizeWhenBottomAndRight];
//    [self initMixAutoWidthLayout];
//    [self initDynamicALLabel];
//    [self initDynamicSizeWhenAutoWidth];
    
//    [self initWithoutALEngineLayout];
//    [self initWithALLayout];
    
//    [self initWithPaddingLayout];
//    [self initWithDynamicHiddenLayout];
//    [self initWithMaxWidthLayout];
//    [self initMiniCard];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) initDemoOfBreakHack
{
    [[self createTitleViewWith: @"demo-1 如果没有isEndOfLine"] addTo: self.view];
    
    [self initMiniCard];
    
//    [[self createTitleViewWith: @"demo-1 使用isEndOfLine"] addTo: self.view];
}

- (void) initDemoOfBreak
{
    [[self createTitleViewWith: @"demo-1 未设置isEndOfLine"] addTo: self.view];
    [[self createInlineViewIsEndOfLine: NO] addTo: self.view];
    [[self createInlineViewIsEndOfLine: NO] addTo: self.view];
    [[self createInlineViewIsEndOfLine: NO] addTo: self.view];
    
    [[self createTitleViewWith: @"demo-1 设置isEndOfLine"] addTo: self.view];
    [[self createInlineViewIsEndOfLine: YES] addTo: self.view];
    [[self createInlineViewIsEndOfLine: YES] addTo: self.view];
    [[self createInlineViewIsEndOfLine: YES] addTo: self.view];

    
    [[self createTitleViewWith: @"demo-1 未设置isFirstOfLine"] addTo: self.view];
    [[self createInlineViewIsFirstOfLine: NO] addTo: self.view];
    [[self createInlineViewIsFirstOfLine: NO] addTo: self.view];
    [[self createInlineViewIsFirstOfLine: NO] addTo: self.view];
    
    [[self createTitleViewWith: @"demo-1 设置isFirstOfLine"] addTo: self.view];
    [[self createInlineViewIsFirstOfLine: YES] addTo: self.view];
    [[self createInlineViewIsFirstOfLine: YES] addTo: self.view];
    [[self createInlineViewIsFirstOfLine: YES] addTo: self.view];
}

- (ALView *) createInlineViewIsEndOfLine: (BOOL) isEndOfLine
{
    ALView * view = [self createInlineViewWidth:80 height:30 alpha:0.3];
    view.style.isEndOFLine = isEndOfLine;
    return  view;
}

- (ALView *) createInlineViewIsFirstOfLine: (BOOL) isFirstOfLine
{
    ALView * view = [self createInlineViewWidth:80 height:30 alpha:0.3];
    view.style.isFirstOFLine = isFirstOfLine;
    return  view;
}

- (void) initDemoOfPadding
{
    [[self createTitleViewWith: @"demo-1 未设置padding"] addTo: self.view];
    [[self createALLabel:@"jdochen" padding:(ALRect){0,0,0,0}] addTo: self.view];
    [[self createALLabel:@"jdochennnn" padding:(ALRect){0,0,0,0}] addTo: self.view];
    [[self createALLabel:@"jdochennnnnn" padding:(ALRect){0,0,0,0}] addTo: self.view];
    
    [[self createTitleViewWith: @"demo-2 设置padding=10"] addTo: self.view];
    [[self createALLabel:@"jdochen" padding:(ALRect){10,10,10,10}] addTo: self.view];
    [[self createALLabel:@"jdochennnn" padding:(ALRect){10,10,10,10}] addTo: self.view];
    [[self createALLabel:@"jdochennnnnn" padding:(ALRect){10,10,10,10}] addTo: self.view];
    
    [[self createTitleViewWith: @"demo-3 设置不同方向的padding"] addTo: self.view];
    [[self createALLabel:@"jdochen" padding:(ALRect){10,20,10,0}] addTo: self.view];
    [[self createALLabel:@"jdochennnn" padding:(ALRect){10,20,10,0}] addTo: self.view];
    [[self createALLabel:@"jdochennnnnn" padding:(ALRect){10,20,10,0}] addTo: self.view];
}

- (ALLabel *) createALLabel: (NSString *) text padding: (ALRect) padding
{
    ALLabel * view = [[ALLabel alloc] init];
    view.text = text;
    view.style.margin = (ALRect) {2, 0, 0, 2};
    view.style.padding = padding;
    view.numberOfLines = 0;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    view.font = [UIFont systemFontOfSize:14.0];
    view.textColor = [UIColor whiteColor];
    
    return view;
}


- (void) initDemoOfDynamicAbsolute
{
    // 左下角
    _absView1 = [self createAbsViewWithOrigin: (ALRect) {0, 0, 20, 20}];
    [_absView1 addTo: self.view];
    // 右下角
    _absView2 = [self createAbsViewWithOrigin: (ALRect) {0, 20, 20, 0}];
    [_absView2 addTo: self.view];
    // 居中
    _absView3 = [self createAbsViewWithCenter: (CGPoint) {0, 0}];
    [_absView3 addTo: self.view];
    
    [[self createSizeCtrlView] addTo: self.view];
}

- (void) initDemoOfAbsolute
{
    // 左上角
    [[self createAbsViewWithOrigin: (ALRect) {20, 0, 0, 20}] addTo: self.view];
    // 右上角
    [[self createAbsViewWithOrigin: (ALRect) {20, 20, 0, 0}] addTo: self.view];
    // 左下角
    [[self createAbsViewWithOrigin: (ALRect) {0, 0, 20, 20}] addTo: self.view];
    // 右下角
    [[self createAbsViewWithOrigin: (ALRect) {0, 20, 20, 0}] addTo: self.view];
    // 居中
    [[self createAbsViewWithCenter: (CGPoint) {0, 0}] addTo: self.view];
}

- (ALView *) createAbsViewWithCenter: (CGPoint) center
{
    ALView * view = [ALView newAbsoluteView];
    view.style.center = center;
    view.style.size = (CGSize) {50, 50};
    view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:0.5];
    return view;
}

- (ALView *) createAbsViewWithOrigin: (ALRect) origin
{
    ALView * view = [ALView newAbsoluteView];
    view.style.origin = origin;
    view.style.size = (CGSize) {50, 50};
    view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:0.5];
    return view;
}

- (void) initDemoOfMaxSize
{
    [[self createTitleViewWith: @"demo-1 子view未超200"] addTo: self.view];
    ALView * inlView1 = [ALView newInlineView];
    inlView1.style.maxWidth = 200;
    inlView1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [inlView1 addTo: self.view];
    
    [[self createInlineViewWidth:20 height:30 alpha:0.1] addTo:inlView1];
    [[self createInlineViewWidth:40 height:30 alpha:0.2] addTo:inlView1];
    [[self createInlineViewWidth:60 height:30 alpha:0.3] addTo:inlView1];
    
    [[self createTitleViewWith: @"demo-2 子view超过200"] addTo: self.view];
    ALView * inlView2 = [ALView newInlineView];
    inlView2.style.maxWidth = 200;
    inlView2.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [inlView2 addTo: self.view];
    
    [[self createInlineViewWidth:20 height:30 alpha:0.1] addTo:inlView2];
    [[self createInlineViewWidth:40 height:30 alpha:0.2] addTo:inlView2];
    [[self createInlineViewWidth:60 height:30 alpha:0.3] addTo:inlView2];
    [[self createInlineViewWidth:50 height:30 alpha:0.4] addTo:inlView2];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo:inlView2];
    [[self createInlineViewWidth:30 height:30 alpha:0.6] addTo:inlView2];
}

- (void) initDemoOfSize
{
    [[self createTitleViewWith: @"demo-1"] addTo: self.view];
    ALView * inlView1 = [ALView newInlineView];
    inlView1.style.size = (CGSize) {100, 30};
    inlView1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [inlView1 addTo: self.view];
    
    ALView * blkView1 = [ALView new];
    blkView1.style.size = (CGSize) {100, 30};
    blkView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    [blkView1 addTo: self.view];
    
    [[self createTitleViewWith: @"demo-2"] addTo: self.view];
    ALView * inlView2 = [ALView newInlineView];
    inlView2.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [inlView2 addTo: self.view];
    
    ALView * blkView2 = [ALView new];
    blkView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    [blkView2 addTo: self.view];
    
    [[self createTitleViewWith: @"demo-3"] addTo: self.view];
    ALView * inlView3 = [ALView newInlineView];
    inlView3.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [inlView3 addTo: self.view];
    
    [[self createInlineViewWidth:20 height:30 alpha:0.1] addTo:inlView3];
    [[self createInlineViewWidth:40 height:30 alpha:0.2] addTo:inlView3];
    [[self createInlineViewWidth:60 height:30 alpha:0.3] addTo:inlView3];
    
    ALView * blkView3 = [ALView new];
    blkView3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    [blkView3 addTo: self.view];
    [[self createInlineViewWidth:20 height:30 alpha:0.1] addTo:blkView3];
    [[self createInlineViewWidth:40 height:30 alpha:0.2] addTo:blkView3];
    [[self createInlineViewWidth:60 height:30 alpha:0.3] addTo:blkView3];
}

- (ALView *) createTitleViewWith: (NSString *) tx
{
    ALView * wrap = [ALView new];
    wrap.style.margin = (ALRect) {20, 0, 5, 0};
    wrap.style.contentAlign = ALContentAlignCenter;
    ALLabel * title = [ALLabel new];
    title.text = tx;
    title.font = [UIFont systemFontOfSize:12];
    [title addTo: wrap];
    return wrap;
}

- (void) initBlockContentMixLayout
{
    ALView * article1 = [[ALView alloc] init];
    article1.style.margin = (ALRect){20, 0, 20, 0};
    article1.style.contentAlign = ALContentAlignLeft;
    article1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [article1 addTo: self.view];
    
    [[self createInlineViewWidth:100 height:50 alpha:0.2] addTo:article1];
    [[self createBlockViewWidth:200 height:80 alpha:0.3] addTo: article1];
    [[self createAbsoluteViewWidth: 40 height:40 alpha:0.5] addTo:article1];
    
    ALView * article2 = [[ALView alloc] init];
    article2.style.marginBottom = 20;
    article2.style.contentAlign = ALContentAlignCenter;
    article2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [article2 addTo: self.view];
    
    [[self createInlineViewWidth:100 height:50 alpha:0.2] addTo:article2];
    [[self createBlockViewWidth:200 height:80 alpha:0.3] addTo: article2];
    [[self createAbsoluteViewWidth: 40 height:40 alpha:0.5] addTo:article2];
    
    ALView * article3 = [[ALView alloc] init];
    article3.style.contentAlign = ALContentAlignRight;
    article3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [article3 addTo: self.view];
    
    [[self createInlineViewWidth:100 height:50 alpha:0.2] addTo:article3];
    [[self createBlockViewWidth:200 height:80 alpha:0.3] addTo: article3];
    [[self createAbsoluteViewWidth: 40 height:40 alpha:0.5] addTo:article3];
}

- (void) initWithBlockLayout
{
    ALView * block1 = [ALView new];
    block1.style.height = 50;
    block1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    block1.style.margin = (ALRect) {20, 0, 10, 0};
    [block1 addTo: self.view];
    
    ALView * block2 = [ALView new];
    block2.style.size = (CGSize) {100, 50};
    block2.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
    block2.style.marginBottom = 10;
    [block2 addTo: self.view];
    
    _section1 = [ALView newInlineView];
    _section1.style.size = (CGSize) {20, 50};
    _section1.style.margin = (ALRect) {0, 5, 5, 0};
    _section1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    [_section1 addTo: self.view];
    
    [[self createInlineViewWidth:50 height:50 alpha:0.1] addTo: self.view];
    [[self createInlineViewWidth:100 height:50 alpha:0.2] addTo: self.view];
    [[self createInlineViewWidth:150 height:50 alpha:0.3] addTo: self.view];
    [[self createInlineViewWidth:200 height:50 alpha:0.4] addTo: self.view];
    
    ALView * block3 = [ALView new];
    block3.style.size = (CGSize) {120, 100};
    block3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
    block3.style.marginBottom = 10;
    [block3 addTo: self.view];
    
    ALView * block4 = [ALView new];
    block4.style.size = (CGSize) {80, 40};
    block4.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    [block4 addTo: self.view];
    
    [[self createSizeCtrlView] addTo: self.view];
}

- (void) initWithAbsuluteLayout
{
    // 定义一个absolute方式布局的body
    ALView * body = [ALView newAbsoluteView];
    // 设置body相对父view垂直水平居中
    body.style.center = (CGPoint) {0, 0};
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [body addTo: self.view];

    // 定义一个relative方式布局的section1，并将其添加到body中
    ALView * section1 = [ALView new];
    // 设置view的尺寸
    section1.style.size = (CGSize) {200, 50};
    section1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    [section1 addTo: body];
    
    // 定义一个relative方式布局的section2，并将其添加到body中
    _section1 = [ALView new];
    _section1.style.size = (CGSize) {200, 100};
    // 设置view的上下外边距
    _section1.style.margin = (ALRect) {20, 0, 20, 0};
    _section1.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
    [_section1 addTo: body];
    
    // 定义一个relative方式布局的section3，并将其添加到body中
    ALView * section3 = [ALView new];
    section3.style.size = (CGSize) {200, 150};
    section3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
    [section3 addTo: body];
    
    [[self createSizeCtrlView] addTo: self.view];
}

- (void) initWithRelativeViewLayout
{
    // 定义一个relative方式布局的body
    ALView * body = [ALView new];
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [body addTo: self.view];
    
    // 定义一个relative方式布局的section1，并将其添加到body中
    ALView * section1 = [ALView new];
    section1.style.height = 50;
    // 设置view的外边距
    section1.style.marginTop = 20;
    section1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    [section1 addTo: body];
    
    // 定义一个relative方式布局的section2，并将其添加到body中
    _section1 = [ALView new];
    _section1.style.height = 100;
    _section1.style.marginTop = 20;
    _section1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    [_section1 addTo: body];
    
    // 定义一个relative方式布局的section3，并将其添加到body中
    ALView * section3 = [ALView new];
    section3.style.height = 150;
    section3.style.margin = (ALRect) {20, 0, 20, 0};
    section3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
    [section3 addTo: body];
    
    // 定义一个absolute方式布局的absView，并将其添加到body中
    ALView * absView = [ALView newAbsoluteView];
    // 设置view的大小
    absView.style.size = (CGSize) {80, 80};
    // 设置view相对父view垂直水平居中
    absView.style.center = (CGPoint) {0, 0};
    absView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    [absView addTo: body];
    
    [[self createSizeCtrlView] addTo: self.view];
}

- (void) initMiniCard
{
    ALView * wrap = [ALView newAbsoluteView];
    wrap.style.centerX = 0;
    wrap.style.top = 100;
    wrap.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [wrap addTo: self.view];
    
    ALView * head = [ALView newAbsoluteView];
    head.style.size = (CGSize) {60, 60};
    head.style.centerX = 0;
    head.style.top = -30;
    head.backgroundColor = [UIColor redColor];
    [head addTo: wrap];
    
    ALView * main = [ALView new];
    main.style.contentAlign = ALContentAlignCenter;
    main.style.width = 200;
    main.style.margin = (ALRect) {40, 10, 10, 10};
    main.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    [main addTo: wrap];
    
    ALLabel * nick = [ALLabel new];
//    nick.style.isEndOFLine = YES;
    nick.style.margin = (ALRect) {10, 0, 10, 0};
    nick.text = @"jdochen";
    nick.font = [UIFont systemFontOfSize:12];
    [nick addTo: main];
    
    ALLabel * bigv = [ALLabel new];
    bigv.style.isEndOFLine = YES;
    bigv.style.hidden = YES;
//    bigv.style.marginLeft = 5;
    bigv.style.margin = (ALRect) {10, 0, 10, 5};
    bigv.text = @"V";
    bigv.font = [UIFont systemFontOfSize:12];
    [bigv addTo: main];
    
    ALLabel * focus = [ALLabel new];
    focus.style.isEndOFLine = YES;
    focus.style.marginBottom = 10;
    focus.text = @"粉丝数：1000";
    focus.font = [UIFont systemFontOfSize:12];
    [focus addTo: main];
    
    ALLabel * desc = [ALLabel new];
    desc.style.isEndOFLine = YES;
    desc.style.marginBottom = 10;
    desc.text = @"i'm jdochen";
    desc.font = [UIFont systemFontOfSize:12];
    [desc addTo: main];
}

- (void) initWithMaxWidthLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    body.style.contentAlign = ALContentAlignCenter;
    body.style.height = [[UIScreen mainScreen] bounds].size.height - 20;
    [body addTo: self.view];
    
//    ALLabel * tx = [[ALLabel alloc] init];
//    tx.style.maxWidth = 100;
//    tx.style.padding = (ALRect) {10, 10, 10, 10};
//    tx.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
//    tx.text = @"jdochenjdochenjdochenjdochenjdochen";
//    tx.numberOfLines = 1;
//    [tx addTo: body];
    
    _section1 = [[ALView alloc] initInlineView];
    _section1.style.maxWidth = 200;
    _section1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    [_section1 addTo: body];
    
    [[self createInlineViewWidth:100 height:40 alpha:0.2] addTo: _section1];
    [[self createInlineViewWidth:20 height:40 alpha:0.2] addTo: _section1];
    [[self createInlineViewWidth:60 height:40 alpha:0.2] addTo: _section1];
    [[self createInlineViewWidth:50 height:40 alpha:0.2] addTo: _section1];
    [[self createInlineViewWidth:80 height:40 alpha:0.2] addTo: _section1];
}

- (void) initWithDynamicHiddenLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    body.style.contentAlign = ALContentAlignCenter;
    body.style.height = [[UIScreen mainScreen] bounds].size.height - 20;
    [body addTo: self.view];
    
    ALView * section = [[ALView alloc] initInlineView];
    section.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [section addTo: body];
    
    [[self createInlineViewWidth:50 height:30 alpha:0.2] addTo: section];
    [[self createInlineViewWidth:70 height:30 alpha:0.3] addTo: section];
    [[self createInlineViewWidth:90 height:30 alpha:0.4] addTo: section];
    [[self createInlineViewWidth:120 height:30 alpha:0.5] addTo: section];
    
    
    [[self createInlineViewWidth:80 height:30 alpha:0.2] addTo: section];
    [[self createInlineViewWidth:70 height:30 alpha:0.3] addTo: section];
    [[self createInlineViewWidth:90 height:30 alpha:0.4] addTo: section];
    [[self createInlineViewWidth:120 height:30 alpha:0.5] addTo: section];
    
    _section1 = [[ALView alloc] initInlineView];
    _section1.style.size = (CGSize) {300, 30};
    _section1.style.margin = (ALRect) {0, 5, 5, 0};
    _section1.style.hidden = YES;
    _section1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.4];
    [_section1 addTo: section];
    
//    _block = [[ALView alloc] init];
//    _block.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
//    [_block addTo: section];
//    [[self createInlineViewWidth:50 height:30 alpha:0.2] addTo: _block];
//    [[self createInlineViewWidth:70 height:30 alpha:0.3] addTo: _block];
//    [[self createInlineViewWidth:120 height:30 alpha:0.4] addTo: _block];
//    [[self createInlineViewWidth:20 height:30 alpha:0.5] addTo: _block];
//    [[self createInlineViewWidth:200 height:30 alpha:0.6] addTo: _block];
    
    
    [[self createHiddenCtrlView] addTo:body];
}

- (void) initDynamicLayout2
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    body.style.height = [[UIScreen mainScreen] bounds].size.height - 20;
    [body addTo: self.view];
    
    _wrap = [[ALView alloc] initAbsoluteView];
    _wrap.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [_wrap addTo: body];
    
    _section1 = [[ALView alloc] initInlineView];
    _section1.style.size = (CGSize) {50, 50};
    _section1.style.margin = (ALRect) {10, 10, 10, 10};
    _section1.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.4];
    [_section1 addTo: _wrap];
    
    [[self createInlineViewWidth:100 height:50 alpha:0.3] addTo: _wrap];
    [[self createInlineViewWidth:10 height:50 alpha:0.5] addTo: _wrap];
    
    [[self createSizeCtrlView] addTo: body];
    
    ALLabel * reflow = [[ALLabel alloc] initWithAbsolute];
    reflow.style.origin = (ALRect) {0, 10, 10, 0};
    reflow.style.padding = (ALRect) {10, 10, 10, 10};
    reflow.userInteractionEnabled = YES;
    reflow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    reflow.text = @"reflow";
    reflow.font = [UIFont systemFontOfSize:12];
    [reflow addTo: body];
    UITapGestureRecognizer * reflowBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reflowWrap)];
    [reflow addGestureRecognizer: reflowBtn];
}

- (void) reflowWrap
{
//    [_wrap reflow];
}

- (void) initWithPaddingLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    body.style.height = [[UIScreen mainScreen] bounds].size.height - 20;
    [body addTo: self.view];
    
    ALView * wrap = [[ALView alloc] init];
    wrap.style.padding = (ALRect) {10, 10, 10, 10};
    [wrap addTo: body];
    
    ALView * sub1 = [[ALView alloc] initInlineView];
    sub1.style.padding = (ALRect) {10, 10, 10, 10};
    sub1.style.size = (CGSize) {30, 40};
    sub1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [sub1 addTo:wrap];
    
    ALView * sub2 = [[ALView alloc] initInlineView];
    sub2.style.padding = (ALRect) {10, 10, 10, 10};
    sub2.style.size = (CGSize) {30, 40};
    sub2.style.marginLeft = 5;
    sub2.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.4];
    [sub2 addTo:wrap];
}

- (void) initWithoutALEngineLayout
{
    _testInlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    _testInlineView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [self.view addSubview: _testInlineView];
    
    UIView * bluebox = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_testInlineView.frame), 0, 90, 40)];
    bluebox.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    [self.view addSubview: bluebox];
    
    UIView * greenbox = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bluebox.frame), 0, 120, 40)];
    greenbox.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.4];
    [self.view addSubview: greenbox];
    
    [[self createSizeCtrlView] addTo:self.view];
}

- (void) initWithALLayout
{
    _testInlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    _testInlineView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [self.view addSubview: _testInlineView];
    
    UIView * bluebox = [[UIView alloc] init];
    bluebox.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    bluebox.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: bluebox];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:bluebox
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_testInlineView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bluebox
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:90],
                                [NSLayoutConstraint constraintWithItem:bluebox
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:40]]];
    
    UIView * greenbox = [[UIView alloc] init];
    greenbox.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.4];
    greenbox.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: greenbox];

    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:greenbox
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bluebox
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:greenbox
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:120],
                                [NSLayoutConstraint constraintWithItem:greenbox
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:40]]];
    
    [[self createSizeCtrlView] addTo:self.view];
}

- (void) initWithALEngineLayout
{
    ALView * wrap = [[ALView alloc] init];
    wrap.style.marginTop = 20;
    wrap.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [wrap addTo: self.view];
    
    _testInlineView = [[ALView alloc] initInlineView];
    _testInlineView.style.size = (CGSize){80, 40};
    _testInlineView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
    [_testInlineView addTo: wrap];
    
    ALView * blueView = [[ALView alloc] initInlineView];
    blueView.style.size = (CGSize){90, 40};
    blueView.style.marginLeft = 5;
    blueView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    [blueView addTo: wrap];
    
    ALView * greenView = [[ALView alloc] initInlineView];
    greenView.style.size = (CGSize){120, 40};
    greenView.style.marginLeft = 5;
    greenView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.4];
    [greenView addTo: wrap];
    
    [[self createSizeCtrlView] addTo:self.view];
}

- (void) initALLabelAndAutoBlockLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    body.style.height = [[UIScreen mainScreen] bounds].size.height - 20;
    [body addTo: self.view];
    
    ALView * wrap = [[ALView alloc] initAbsoluteView];
    
    ALView * avatar = [[ALView alloc] initInlineView];
    avatar.style.size = (CGSize) {35, 35};
    avatar.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    [avatar addTo: wrap];
    
    ALView * infoWrap = [[ALView alloc] initInlineView];
    infoWrap.style.margin = (ALRect) {0, 50, 0, 10};
    infoWrap.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.2];
    [infoWrap addTo:wrap];
    
    _nicklabel = [[ALLabel alloc] init];
    _nicklabel.text = @"jdochenchenchenchenchenchen";
    _nicklabel.style.maxWidth = 100;
    _nicklabel.font = [UIFont systemFontOfSize:12];
    [_nicklabel addTo: infoWrap];
    
    _vlabel = [[ALLabel alloc] init];
    _vlabel.style.marginLeft = 4;
    _vlabel.font = [UIFont systemFontOfSize:12];
    _vlabel.text = @"V";
    [_vlabel addTo: infoWrap];
    
    _timelabel = [[ALLabel alloc] init];
    _timelabel.style.marginTop = 4;
    _timelabel.style.isFirstOFLine = YES;
    _timelabel.text = @"20:20";
    _timelabel.font = [UIFont systemFontOfSize:12];
    [_timelabel addTo: infoWrap];
    
    ALLabel * focus = [[ALLabel alloc] initWithAbsolute];
    focus.text = @"关注";
    focus.font = [UIFont systemFontOfSize:13];
    focus.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.2];
    focus.style.padding = (ALRect){5, 10, 5, 10};
    focus.style.top = 3;
    focus.style.right = 0;
    [focus addTo:wrap];
    
    [wrap addTo: body];
    
    [[self createHiddenCtrlView] addTo:body];
}

- (void) initDynamicSizeWhenAutoWidth
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    body.style.height = [[UIScreen mainScreen] bounds].size.height - 20;
    [body addTo: self.view];
    
    ALView * wrap = [[ALView alloc] init];
    wrap.style.position = ALPositionAbsolute;
    //    sub1.style.display = ALDisplayInline;
    wrap.style.contentAlign = ALContentAlignCenter;
    //    wrap.style.width = 200;
    //    wrap.style.bottom = 10;
    wrap.style.centerY = 0;
    wrap.style.centerX = 0;
    wrap.backgroundColor = [UIColor yellowColor];
    [wrap addTo: body];
    
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: wrap];
    [[self createInlineViewWidth:30 height:30 alpha:0.5] addTo: wrap];
    [[self createInlineViewWidth:70 height:30 alpha:0.5] addTo: wrap];
    
    _section1 = [[ALView alloc] init];
    _section1.style.display = ALDisplayInline;
    _section1.style.height = 30;
    _section1.style.width = 150;
    _section1.style.marginBottom = 5;
    _section1.style.marginRight = 5;
    _section1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    [_section1 addTo:wrap];
    
    [[self createInlineViewWidth:90 height:30 alpha:0.5] addTo: wrap];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: wrap];
    
    [[self createSizeCtrlView] addTo:body];
}

- (void) initDynamicALLabel
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    body.style.height = [[UIScreen mainScreen] bounds].size.height - 20;
    [body addTo: self.view];
    
    ALView * wrap = [[ALView alloc] init];
    wrap.style.position = ALPositionAbsolute;
    //    sub1.style.display = ALDisplayInline;
    wrap.style.contentAlign = ALContentAlignCenter;
//    wrap.style.width = 200;
//    wrap.style.bottom = 10;
    wrap.style.centerY = 0;
    wrap.style.centerX = 0;
    wrap.backgroundColor = [UIColor yellowColor];
    [wrap addTo: body];
    
    _allabel = [self createALLabel: @"jdochen" numberOfLine:0];
    [_allabel addTo: wrap];
    [[self createALLabel: @"jdochen123" numberOfLine:0] addTo: wrap];
    [[self createALLabel: @"jdochen24321732" numberOfLine:0] addTo: wrap];
    [[self createALLabel: @"jdochen3343217328718732187" numberOfLine:0] addTo: wrap];
    [[self createALLabel: @"jdochen432143217328718732187" numberOfLine:0] addTo: wrap];
    
    [[self createHiddenCtrlView] addTo:body];
}

- (void) initMixAutoWidthLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.height = [[UIScreen mainScreen] bounds].size.height;
    [body addTo: self.view];
    
    
    ALView * section = [self createAutoSizeInlineView: 0.1];
    [section addTo:body];

    [[self createInlineViewWidth:300 height:30 alpha:0.5] addTo: section];
//    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: section];

    ALView * section2 = [self createAutoSizeInlineView: 0.2];
    [section2 addTo:section];
    
    [[self createInlineViewWidth:20 height:30 alpha:0.5] addTo: section2];
//
    ALView * section3 = [self createAutoSizeInlineView: 0.3];
    [section3 addTo:section2];
//
//    [[self createInlineViewWidth:240 height:30 alpha:0.5] addTo: section];

    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: section3];

    [[self createInlineViewWidth:130 height:30 alpha:0.5] addTo: section3];

    [[self createInlineViewWidth:50 height:30 alpha:0.5] addTo: section3];
}

- (void) initPositionAutoSizeWhenBottomAndRight
{
    ALView * body = [[ALView alloc] init];
    body.style.height = [[UIScreen mainScreen] bounds].size.height;
//    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [body addTo: self.view];

    ALView * sub1 = [[ALView alloc] init];
    sub1.style.position = ALPositionAbsolute;
//    sub1.style.display = ALDisplayInline;
    sub1.style.contentAlign = ALContentAlignCenter;
    sub1.style.width = 200;
    sub1.style.bottom = 10;
//    sub1.style.centerY = 0;
    sub1.style.centerX = 0;
    sub1.backgroundColor = [UIColor yellowColor];
    [sub1 addTo: body];
    
    [[self createInlineViewWidth:50 height:30 alpha:0.7] addTo:sub1];
    [[self createInlineViewWidth:70 height:30 alpha:0.8] addTo:sub1];
    [[self createInlineViewWidth:100 height:30 alpha:0.9] addTo:sub1];
    [[self createInlineViewWidth:150 height:30 alpha:0.8] addTo:sub1];
    [[self createInlineViewWidth:10 height:30 alpha:0.9] addTo:sub1];
    [[self createInlineViewWidth:70 height:30 alpha:0.8] addTo:sub1];
    [[self createInlineViewWidth:100 height:30 alpha:0.9] addTo:sub1];
    [[self createInlineViewWidth:150 height:30 alpha:0.8] addTo:sub1];
    [[self createInlineViewWidth:10 height:30 alpha:0.9] addTo:sub1];
}

- (void) initPositionAutoSizeWhenCenterXAndY
{
    
}

- (void) initDynamicLayout
{
    ALView * b = [[ALView alloc] init];
    b.style.height = [[UIScreen mainScreen] bounds].size.height;
    [b addTo: self.view];
    
    ALView * b2 = [[ALView alloc] init];
    b2.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.2];
    [b2 addTo: b];

    
    _body = [[ALView alloc] init];
    _body.style.contentAlign = ALContentAlignRight;
    _body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.2];
    _body.style.marginBottom = 10;
    [_body addTo: b2];
    
    ALView * body2 = [[ALView alloc] init];
    body2.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    body2.style.height = 100;
    body2.style.marginBottom = 10;
    [body2 addTo: b2];
    
    [[self createInlineViewWidth:50 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:70 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:80 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:50 height:30 alpha:0.5] addTo: _body];

    _section1 = [[ALView alloc] init];
    _section1.style.display = ALDisplayInline;
    _section1.style.height = 30;
    _section1.style.width = 150;
    _section1.style.marginBottom = 5;
    _section1.style.marginRight = 5;
    _section1.style.top = -20;
    _section1.backgroundColor = [UIColor yellowColor];
    [_section1 addTo: _body];
    [[self createInlineViewWidth:40 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:70 height:30 alpha:0.5] addTo: _body];

    
    _block = [ALView new];
    _block.style.contentAlign = ALContentAlignRight;
//    _block.style.center = (CGPoint) {0, 0};
    _block.style.width = 200;
//    _block.style.hidden = YES;
    _block.style.margin = (ALRect) {0, 5, 10, 0};
    _block.backgroundColor = [UIColor redColor];
    [[self createInlineViewWidth:50 height:40 alpha:0.1] addTo: _block];
    [[self createInlineViewWidth:20 height:40 alpha:0.2] addTo: _block];
    [[self createInlineViewWidth:70 height:40 alpha:0.3] addTo: _block];
    [[self createInlineViewWidth:120 height:40 alpha:0.4] addTo: _block];
    [[self createInlineViewWidth:20 height:40 alpha:0.2] addTo: _block];
    [[self createInlineViewWidth:70 height:40 alpha:0.3] addTo: _block];
    [[self createInlineViewWidth:120 height:40 alpha:0.4] addTo: _block];

    [_block addTo: _body];

    [[self createInlineViewWidth:90 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _body];

    [[self createSizeCtrlView] addTo:b];
    [[self createHiddenCtrlView] addTo:b];
}

- (void) initDynamicAbsolute
{
    ALView * b = [[ALView alloc] init];
    b.style.height = [[UIScreen mainScreen] bounds].size.height;
    b.style.contentAlign = ALContentAlignCenter;
    [b addTo: self.view];
    
    [[self createInlineViewWidth:100 height:40 alpha:0.6] addTo: b];
    [[self createInlineViewWidth:80 height:40 alpha:0.5] addTo: b];
    [[self createInlineViewWidth:60 height:40 alpha:0.4] addTo: b];
    
    _section1 = [[ALView alloc] init];
    _section1.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.2];
//    _section1.style.display = ALDisplayInline;
    _section1.style.position = ALPositionAbsolute;
//    _section1.style.centerX = 0;
//    _section1.style.centerY = 0;
    _section1.style.center = (CGPoint){0, 0};
//    _section1.style.width = 200;
    _section1.style.contentAlign = ALContentAlignRight;
    [[self createInlineViewWidth:100 height:40 alpha:0.6] addTo: b];
    [[self createInlineViewWidth:80 height:40 alpha:0.5] addTo: b];
    [[self createInlineViewWidth:60 height:40 alpha:0.4] addTo: b];
//
    [[self createInlineViewWidth:40 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _section1];
    [_section1 addTo: b];
//
    _block = [self createBlockViewWidth: 0 height:0 alpha:0.5];
//    _block = [self createInlineViewWidth:0 height:0 alpha:0.5];
    _block.style.hidden = YES;
//    _block.style.contentAlign = ALContentAlignRight;
    [_block addTo: _section1];
    [[self createInlineViewWidth:120 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:40 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _block];
//
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:70 height:30 alpha:0.5] addTo: _section1];
//
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _section1];
//
    [[self createSizeCtrlView] addTo:b];
    [[self createHiddenCtrlView] addTo:b];
}

- (ALView *) createAutoSizeInlineView: (CGFloat) alpha
{
    ALView * inlineView = [[ALView alloc] init];
    inlineView.style.display = ALDisplayInline;
    inlineView.style.marginRight = 10;
    inlineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return inlineView;
}

- (ALView *) createSizeCtrlView
{
    ALView * panelWrap = [ALView newAbsoluteView];
    panelWrap.style.bottom = 10;
    panelWrap.style.centerX = 0;
    
    ALLabel * widthTx = [[ALLabel alloc] init];
    widthTx.text = @"size: ";
    widthTx.font = [UIFont systemFontOfSize:12];
    widthTx.style.height = 30;
    [widthTx addTo: panelWrap];
    
    ALLabel * subBtn = [[ALLabel alloc] init];
    subBtn.userInteractionEnabled = YES;
    subBtn.text = @"-";
    subBtn.style.size = (CGSize) {30, 30};
    subBtn.style.marginLeft = 10;
    subBtn.textColor = [UIColor whiteColor];
    subBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    subBtn.textAlignment = NSTextAlignmentCenter;
    [subBtn addTo: panelWrap];
    UITapGestureRecognizer * tapSubBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subTheSize)];
    [subBtn addGestureRecognizer: tapSubBtn];
    
    ALLabel * addBtn = [[ALLabel alloc] init];
    addBtn.userInteractionEnabled = YES;
    addBtn.text = @"+";
    addBtn.style.size = (CGSize) {30, 30};
    addBtn.style.marginLeft = 10;
    addBtn.textColor = [UIColor whiteColor];
    addBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    addBtn.textAlignment = NSTextAlignmentCenter;
    [addBtn addTo: panelWrap];
    UITapGestureRecognizer * tapAddBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTheSize)];
    [addBtn addGestureRecognizer: tapAddBtn];
    
    return panelWrap;
}

- (ALView *) createHiddenCtrlView
{
    ALView * panelWrap = [[ALView alloc] init];
    panelWrap.style.position = ALPositionAbsolute;
    panelWrap.style.bottom = 10;
    panelWrap.style.right = 10;
    
    ALLabel * widthTx = [[ALLabel alloc] init];
    widthTx.text = @"hidden: ";
    widthTx.font = [UIFont systemFontOfSize:12];
    widthTx.style.height = 30;
    [widthTx addTo: panelWrap];
    
    ALLabel * subBtn = [[ALLabel alloc] init];
    subBtn.userInteractionEnabled = YES;
    subBtn.text = @"Y";
    subBtn.style.height = 30;
    subBtn.style.width = 30;
    subBtn.style.marginLeft = 10;
    subBtn.textColor = [UIColor whiteColor];
    subBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    subBtn.textAlignment = NSTextAlignmentCenter;
    [subBtn addTo: panelWrap];
    UITapGestureRecognizer * tapSubBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [subBtn addGestureRecognizer: tapSubBtn];
    
    ALLabel * addBtn = [[ALLabel alloc] init];
    addBtn.userInteractionEnabled = YES;
    addBtn.text = @"N";
    addBtn.style.height = 30;
    addBtn.style.width = 30;
    addBtn.style.marginLeft = 10;
    addBtn.textColor = [UIColor whiteColor];
    addBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    addBtn.textAlignment = NSTextAlignmentCenter;
    [addBtn addTo: panelWrap];
    UITapGestureRecognizer * tapAddBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showView)];
    [addBtn addGestureRecognizer: tapAddBtn];
    
    return panelWrap;
}

- (void) subTheSize
{
//    _testInlineView.style.width -= 5;
//    [_testInlineView reflow];
//    _testInlineView.frame = CGRectMake(0, 0, _testInlineView.frame.size.width - 5, _testInlineView.frame.size.height);
//    _block.style.width -= 5;
//    [_block reflow];
//    _section1.style.hidden = YES;
//    [_section1 reflow];
//    [_section1.belongRow refreshSize];
//    _section1.style.width -= 5;
//    _section1.style.marginBottom -= 3;
//    [_section1 reflow];
    _absView1.style.width -= 5;
    _absView1.style.height -= 5;
    _absView2.style.width -= 5;
    _absView2.style.height -= 5;
    _absView3.style.width -= 5;
    _absView3.style.height -= 5;
}
- (void) addTheSize
{
//    _testInlineView.style.width += 5;
//    [_testInlineView reflow];
//    _testInlineView.frame = CGRectMake(0, 0, _testInlineView.frame.size.width + 5, _testInlineView.frame.size.height);
//    NSLog(@"%f", _section1.style.width);
//    _block.style.width += 5;
//    [_block reflow];
//    _section1.style.hidden = NO;
//    [_section1 reflow];
//    [_section1.belongRow refreshSize];
//    _section1.style.width += 5;
//    _section1.style.marginBottom += 3;
//    [_section1 reflow];
    _absView1.style.width += 5;
    _absView1.style.height += 5;
    _absView2.style.width += 5;
    _absView2.style.height += 5;
    _absView3.style.width += 5;
    _absView3.style.height += 5;

}

- (void) hideView
{
    _block.style.hidden = YES;
//    [_block reflow];
//    _section1.style.hidden = YES;
//    [_section1 reflow];
//    _allabel.text = @"jdochennnnnn";
//    [_allabel reflow];
//    _nicklabel.text = @"jdochen";
//    _timelabel.text = @"";
}

- (void) showView
{
//    _section1.style.hidden = NO;
//    [_section1 reflow];
//    _allabel.text = @"jdochen";
//    [_allabel reflow];
    _block.style.hidden = NO;
//    [_block reflow];
//    _nicklabel.text = @"jdochenchen";
//    _timelabel.text = @"10:00";
}


- (ALView *) createBlockViewWidth: (CGFloat) width height: (CGFloat) height alpha: (CGFloat) alpha
{
    ALView * view = [[ALView alloc] init];
    view.style.margin = (ALRect) {0, 0, 5, 5};
    if ( height ) {
        view.style.height = height;
    }
    if ( width ) {
        view.style.width = width;
    }
    view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:alpha];
    return view;
}

- (void) initPaddingLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * article = [[ALView alloc] init];
    article.style.margin = (ALRect) {50, 20, 0, 20};
//    article.style.marginRight = 20;
//    article.style.marginLeft = 20;
//    article.style.marginTop = 50;
//    article.style.height = 100;
    article.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [article addTo: body];
    
    ALLabel * tx = [[ALLabel alloc] init];
//    tx.style.marginTop = 20;
//    tx.style.marginLeft = 20;
    tx.style.margin = (ALRect){20, 0, 0, 20};
    tx.style.padding = (ALRect){20, 30, 20, 30};
    tx.style.height = 50;
    tx.text = @"我是一个ALLabel";
    tx.font = [UIFont systemFontOfSize:12];
    tx.backgroundColor = [UIColor yellowColor];
    [tx addTo: article];
}

- (void) initMarginLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * article = [[ALView alloc] init];
    article.style.margin = (ALRect) {50, 20, 0, 20};
//    article.style.marginRight = 20;
//    article.style.marginLeft = 20;
//    article.style.marginTop = 50;
    article.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [article addTo: body];
    
    ALView * sub = [[ALView alloc] init];
    sub.style.marginTop = 20;
    sub.style.marginLeft = 20;
    sub.style.width = 100;
    sub.style.height = 50;
    sub.backgroundColor = [UIColor yellowColor];
    [sub addTo: article];
    
    [[self createALLView:@"我是一个block"] addTo: sub];
    
    ALView * sub2 = [[ALView alloc] init];
    sub2.style.marginTop = 30;
    sub2.style.marginLeft = 20;
    sub2.style.width = 150;
    sub2.style.height = 50;
    sub2.backgroundColor = [UIColor yellowColor];
    [sub2 addTo: article];
    
    [[self createALLView:@"我也是一个block"] addTo: sub2];
    
    ALView * sub3 = [[ALView alloc] init];
    sub3.style.marginTop = 30;
    sub3.style.marginLeft = 20;
    sub3.style.marginBottom = 30;
    sub3.style.width = 120;
    sub3.style.height = 50;
    sub3.backgroundColor = [UIColor yellowColor];
    [sub3 addTo: article];
    
    [[self createALLView:@"我还是一个block"] addTo: sub3];
}

- (void) initInlineLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * inline1 = [self createInlineViewWidth:100 height:40 alpha:1];
    [inline1 addTo: body];
    [[self createALLView: @"我是inline view"] addTo: inline1];
    
    ALView * inline2 = [self createInlineViewWidth:70 height:40 alpha:1];
    [inline2 addTo: body];
    [[self createALLView: @"我接着排这行"] addTo: inline2];
    
    ALView * inline3 = [self createInlineViewWidth:120 height:40 alpha:1];
    [inline3 addTo: body];
    [[self createALLView: @"我还能排这行"] addTo: inline3];
    
    ALView * inline4 = [self createInlineViewWidth:90 height:40 alpha:1];
    [inline4 addTo: body];
    [[self createALLView: @"我要断行啦~"] addTo: inline4];
    
    ALView * inline5 = [self createInlineViewWidth:190 height:40 alpha:1];
    [inline5 addTo: body];
    [[self createALLView: @"我又能接这行排"] addTo: inline5];
}

- (ALLabel *) createALLView: (NSString *) tx
{
    ALLabel * tx1 = [[ALLabel alloc] init];
    tx1.text = tx;
    tx1.font = [UIFont systemFontOfSize:12];
    tx1.numberOfLines = 0;
    tx1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    return tx1;
}

- (void) initBlockLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * block1 = [[ALView alloc] init];
    block1.style.height = 50;
    block1.backgroundColor = [UIColor yellowColor];
    [block1 addTo:body];
    
    ALLabel * tx1 = [[ALLabel alloc] init];
    tx1.text = @"我是block view，我不设置width属性";
    tx1.font = [UIFont systemFontOfSize:12];
    tx1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [tx1 addTo:block1];
    
    
    ALView * block2 = [[ALView alloc] init];
    block2.style.marginTop = 20;
    block2.style.height = 60;
    block2.style.width = 200;
    block2.backgroundColor = [UIColor blueColor];
    [block2 addTo:body];
    
    ALLabel * tx2 = [[ALLabel alloc] init];
    tx2.text = @"我也是block view，我设置了width=200";
    tx2.numberOfLines = 0;
    tx2.font = [UIFont systemFontOfSize:12];
    tx2.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [tx2 addTo:block2];
    
    
    ALView * block3 = [[ALView alloc] init];
    block3.style.marginTop = 20;
    block3.style.height = 100;
    block3.style.width = 100;
    block3.backgroundColor = [UIColor redColor];
    [block3 addTo:body];
    
    ALLabel * tx3 = [[ALLabel alloc] init];
    tx3.text = @"我还是block view，我布局每次都是新的一行";
    tx3.numberOfLines = 0;
    tx3.font = [UIFont systemFontOfSize:12];
    tx3.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [tx3 addTo:block3];

}

- (void) initBlockAndInlineLayout2
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * blockArticle = [[ALView alloc] init];
    // if you did not set `height` property, it will auto update height by subview's total height
    // which feature is also fit to inline view
    // blockArticle.style.height = 50;
    blockArticle.backgroundColor = [UIColor yellowColor];
    [blockArticle addTo:body];
    
    // create an inline view addto blockArticle
    [[self createInlineViewWidth: 150 height:40 alpha:0.2] addTo: blockArticle];
    [[self createInlineViewWidth: 60 height:40 alpha:0.5] addTo: blockArticle];
    [[self createInlineViewWidth: 200 height:40 alpha:0.7] addTo: blockArticle];
    
    ALView * inlineArticle = [[ALView alloc] init];
    inlineArticle.style.display = ALDisplayInline;
    // If you did not set `width` property on inline view
    // It will auto update width by subview's total width, max width is parent's width
     inlineArticle.style.width = 320;
    // inlineArticle.style.height = 50;
    inlineArticle.backgroundColor = [UIColor redColor];
    [inlineArticle addTo:body];
    
    [[self createInlineViewWidth: 150 height:40 alpha:0.2] addTo: inlineArticle];
    [[self createInlineViewWidth: 100 height:40 alpha:0.3] addTo: inlineArticle];
    [[self createInlineViewWidth: 60 height:40 alpha:0.5] addTo: inlineArticle];
    [[self createInlineViewWidth: 200 height:40 alpha:0.7] addTo: inlineArticle];
}

- (ALView *) createAbsoluteViewWidth: (CGFloat) width height: (CGFloat) height alpha: (CGFloat) alpha
{
    ALView * view = [ALView newAbsoluteView];
    view.style.center = (CGPoint) {0, 0};
    if ( height ) {
        view.style.height = height;
    }
    if ( width ) {
        view.style.width = width;
    }
    view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:alpha];
    return view;
}

- (ALView *) createInlineViewWidth: (CGFloat) width height: (CGFloat) height alpha: (CGFloat) alpha
{
    ALView * view = [ALView newInlineView];
    view.style.margin = (ALRect){0, 5, 5, 0};
    if ( height ) {
        view.style.height = height;
    }
    if ( width ) {
        view.style.width = width;
    }
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return view;
}

- (void) initBlockAndInlineLayout1
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * blockArticle = [[ALView alloc] init];
    // if you did not set `display`, default is ALDisplayBlock
    // blockArticle.style.display = ALDisplayBlock;
    blockArticle.style.height = 50;
    blockArticle.style.width = 200;
    blockArticle.backgroundColor = [UIColor yellowColor];
    [blockArticle addTo:body];
    
    ALView * blockArticle2 = [[ALView alloc] init];
    blockArticle2.style.height = 100;
    // if you did not set `width`, default is parent's width
    blockArticle2.backgroundColor = [UIColor blueColor];
    [blockArticle2 addTo:body];
    
    ALView * inlineTx1 = [[ALView alloc] init];
    inlineTx1.style.display = ALDisplayInline;
    inlineTx1.style.height = 40;
    inlineTx1.style.width = 150;
    inlineTx1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [inlineTx1 addTo:body];
    
    ALView * inlineTx2 = [[ALView alloc] init];
    inlineTx2.style.display = ALDisplayInline;
    inlineTx2.style.height = 40;
    inlineTx2.style.width = 60;
    inlineTx2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [inlineTx2 addTo:body];
    
    ALView * inlineTx3 = [[ALView alloc] init];
    inlineTx3.style.display = ALDisplayInline;
    inlineTx3.style.height = 40;
    // will break in new line if need
    inlineTx3.style.width = 200;
    inlineTx3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [inlineTx3 addTo:body];
}

- (void) initALLabelAutoHeightWidthLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * blockwrap = [[ALView alloc] init];
    blockwrap.backgroundColor = [UIColor yellowColor];
    blockwrap.style.contentAlign = ALContentAlignRight;
    [blockwrap addTo: body];

    [[self createALLabel: @"jdochen" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"jdochen321" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"jdochen432" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"jdochen1" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"jdochen4" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"jdochen6789" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"jdochen0" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"22" numberOfLine:2] addTo:blockwrap];
    [[self createALLabel: @"jdochen8765dbsabdsadsadjksakjdsajdskjadsjkawwwwwwwww" numberOfLine:1] addTo:blockwrap];
//    [[self createALLabel: @"jdochen" numberOfLine:0] addTo:blockwrap];
}

- (ALLabel *) createALLabel: (NSString *) text numberOfLine: (NSInteger) num
{
    ALLabel * tx1 = [[ALLabel alloc] init];
    tx1.text = text;
    tx1.style.marginTop = 2;
    tx1.style.marginRight = 2;
    tx1.style.padding = (ALRect){10, 10, 10, 10};
    tx1.numberOfLines = num;
    tx1.lineBreakMode = NSLineBreakByTruncatingTail;
    tx1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    tx1.font = [UIFont systemFontOfSize:14.0];
    tx1.textColor = [UIColor redColor];
    
    return tx1;
}

- (void) initInlineAutoWidthHeightLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];

    ALView * inlinewrap = [[ALView alloc] init];
    inlinewrap.backgroundColor = [UIColor redColor];
    inlinewrap.style.width = 300;
    inlinewrap.style.contentAlign = ALContentAlignCenter;
    inlinewrap.style.display = ALDisplayInline;
    [inlinewrap addTo: body];
    
    [[self createInlineViewWidth:150 height:30 alpha:0.1] addTo: inlinewrap];
    [[self createInlineViewWidth:50 height:40 alpha:0.2] addTo: inlinewrap];
    [[self createInlineViewWidth:30 height:30 alpha:0.3] addTo: inlinewrap];
    [[self createInlineViewWidth:120 height:30 alpha:0.4] addTo: inlinewrap];
    [[self createInlineViewWidth:70 height:30 alpha:0.5] addTo: inlinewrap];
    [[self createInlineViewWidth:200 height:60 alpha:0.6] addTo: inlinewrap];
    [[self createInlineViewWidth:300 height:30 alpha:0.7] addTo: inlinewrap];
//    [[self createInlineViewWidth:200 height:30 alpha:0.8] addTo: inlinewrap];
//    [[self createInlineBox1:0.7] addTo:inlinewrap];
    //    [[self createInlineBox1:0.8] addTo:inlinewrap];
}

- (void) initBlockContentInlineLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * article1 = [[ALView alloc] init];
    article1.style.margin = (ALRect){20, 0, 20, 0};
    article1.style.contentAlign = ALContentAlignLeft;
    article1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [article1 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:article1];
    [[self createInlineBox1:0.2] addTo:article1];
    [[self createInlineBox1:0.3] addTo:article1];
    [[self createInlineBox1:0.4] addTo:article1];
    
    ALView * article2 = [[ALView alloc] init];
    article2.style.marginBottom = 20;
    article2.style.contentAlign = ALContentAlignCenter;
    article2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [article2 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:article2];
    [[self createInlineBox1:0.2] addTo:article2];
    [[self createInlineBox1:0.3] addTo:article2];
    [[self createInlineBox1:0.4] addTo:article2];
    
    ALView * article3 = [[ALView alloc] init];
    article3.style.contentAlign = ALContentAlignRight;
    article3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [article3 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:article3];
    [[self createInlineBox1:0.2] addTo:article3];
    [[self createInlineBox1:0.3] addTo:article3];
    [[self createInlineBox1:0.4] addTo:article3];
}

- (void) initBlockContentBlockLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * artivle1 = [[ALView alloc] init];
    artivle1.style.margin = (ALRect) {20, 0, 20, 0};
    artivle1.style.contentAlign = ALContentAlignLeft;
    artivle1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle1 addTo: body];
    
    ALView * block1 = [[ALView alloc] init];
    block1.style.size = (CGSize) {150, 100};
    block1.backgroundColor = [UIColor yellowColor];
    [block1 addTo: artivle1];
    
    ALView * artivle2 = [[ALView alloc] init];
    artivle2.style.marginBottom = 20;
    artivle2.style.contentAlign = ALContentAlignCenter;
    artivle2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle2 addTo: body];
    
    ALView * block2 = [[ALView alloc] init];
    block2.style.size = (CGSize) {150, 100};
    block2.backgroundColor = [UIColor blueColor];
    [block2 addTo: artivle2];
    
    ALView * artivle3 = [[ALView alloc] init];
    artivle3.style.marginBottom = 20;
    artivle3.style.contentAlign = ALContentAlignRight;
    artivle3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle3 addTo: body];
    
    ALView * block3 = [[ALView alloc] init];
    block3.style.size = (CGSize) {150, 100};
    block3.backgroundColor = [UIColor redColor];
    [block3 addTo: artivle3];
}

//- (void) initInlineLayout
//{
//    ALView * body = [[ALView alloc] init];
//    body.style.marginTop = 20;
//    [body addTo:self.view];
//    
//    ALView * article1 = [[ALView alloc] init];
//    article1.style.display = ALDisplayInline;
//    article1.style.width = 320;
//    article1.style.marginBottom = 20;
//    article1.backgroundColor = [UIColor yellowColor];
//    [article1 addTo: body];
//    
//    [[self createInlineBox1:0.1] addTo:article1];
//    [[self createInlineBox1:0.2] addTo:article1];
//    [[self createInlineBox1:0.3] addTo:article1];
//    [[self createInlineBox1:0.4] addTo:article1];
//    [[self createInlineBox1:0.5] addTo:article1];
//    [[self createInlineBox1:0.6] addTo:article1];
//    [[self createInlineBox1:0.7] addTo:article1];
//    [[self createInlineBox1:0.8] addTo:article1];
//    [[self createInlineBox1:0.9] addTo:article1];
//    [[self createInlineBox1:1.0] addTo:article1];
//    
//    ALView * article2 = [[ALView alloc] init];
//    article2.style.display = ALDisplayInline;
//    article2.style.width = 320;
//    article2.style.marginBottom = 20;
//    article2.backgroundColor = [UIColor blueColor];
//    [article2 addTo: body];
//    
//    [[self createInlineBox1:0.1] addTo:article2];
//    [[self createInlineBox1:0.2] addTo:article2];
//    [[self createInlineBox1:0.3] addTo:article2];
//    [[self createInlineBox1:0.4] addTo:article2];
//    [[self createInlineBox1:0.5] addTo:article2];
//    [[self createInlineBox1:0.6] addTo:article2];
//    [[self createInlineBox1:0.7] addTo:article2];
//    [[self createInlineBox1:0.8] addTo:article2];
//    [[self createInlineBox1:0.9] addTo:article2];
//    [[self createInlineBox1:1.0] addTo:article2];
//}

/*
 * 多嵌套ALScrollView测试用例：
 * 1、ALScrollView使用
 * 2、ALScrollView中的绝对定位
 * 3、ALScrollView中的固定定位
 * 4、ALScrollView中的行内view的使用
 * 5、ALScrollView中的块级view的使用
 */
- (void) initMixScrollLayout
{
    // body scroll view
    ALScrollView * body = [[ALScrollView alloc] init];
    body.style.height = [[UIScreen mainScreen] bounds].size.height;
    [body addTo: self.view];
    
    // header block view
    ALView * header = [[ALView alloc] init];
    header.style.marginTop = 20;
    header.backgroundColor = [UIColor greenColor];
    [header addTo:body];
    
    // header's subview inline view
    ALLabel * headerLabel = [[ALLabel alloc] init];
    headerLabel.style.height = 50;
    headerLabel.style.width = 140;
    headerLabel.style.marginTop = 10;
    headerLabel.style.marginLeft = 10;
    headerLabel.style.marginRight = 10;
    headerLabel.style.marginBottom = 10;
    headerLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [headerLabel addTo:header];
    
    ALLabel * headerLabel2 = [[ALLabel alloc] init];
    headerLabel2.style.height = 50;
    headerLabel2.style.width = 140;
    headerLabel2.style.marginTop = 10;
    headerLabel2.style.marginLeft = 10;
    headerLabel2.style.marginRight = 10;
    headerLabel2.style.marginBottom = 10;
    headerLabel2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [headerLabel2 addTo:header];
    
    ALScrollView * scbox1 = [[ALScrollView alloc] init];
    scbox1.style.marginTop = 10;
    scbox1.style.height = 200;
    scbox1.backgroundColor = [UIColor blueColor];
    [scbox1 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:scbox1];
    [[self createInlineBox1:0.2] addTo:scbox1];
    [[self createInlineBox1:0.3] addTo:scbox1];
    [[self createInlineBox1:0.4] addTo:scbox1];
    [[self createInlineBox1:0.5] addTo:scbox1];
    [[self createInlineBox1:0.6] addTo:scbox1];
    [[self createInlineBox1:0.7] addTo:scbox1];
    [[self createInlineBox1:0.8] addTo:scbox1];
    [[self createInlineBox1:0.9] addTo:scbox1];
    [[self createInlineBox1:1.0] addTo:scbox1];
    [[self createInlineBox1:0.1] addTo:scbox1];
    [[self createInlineBox1:0.2] addTo:scbox1];
    [[self createInlineBox1:0.3] addTo:scbox1];
    [[self createInlineBox1:0.4] addTo:scbox1];
    [[self createInlineBox1:0.5] addTo:scbox1];
    [[self createInlineBox1:0.6] addTo:scbox1];
    [[self createInlineBox1:0.7] addTo:scbox1];
    [[self createInlineBox1:0.8] addTo:scbox1];
    [[self createInlineBox1:0.9] addTo:scbox1];
    [[self createInlineBox1:1.0] addTo:scbox1];
    
    ALScrollView * scbox2 = [[ALScrollView alloc] init];
    scbox2.style.marginTop = 20;
    scbox2.style.height = 500;
    scbox2.backgroundColor = [UIColor redColor];
    [scbox2 addTo: body];
    
    ALView * block1 = [[ALView alloc] init];
    block1.style.marginTop = 20;
    block1.style.marginLeft = 20;
    block1.style.marginRight = 20;
    block1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    [block1 addTo:scbox2];
    
    [[self createInlineBox2:0.1] addTo:block1];
    [[self createInlineBox2:0.2] addTo:block1];
    [[self createInlineBox2:0.3] addTo:block1];
    [[self createInlineBox2:0.4] addTo:block1];
    [[self createInlineBox2:0.5] addTo:block1];
    [[self createInlineBox2:0.6] addTo:block1];
    [[self createInlineBox2:0.7] addTo:block1];
    [[self createInlineBox2:0.8] addTo:block1];
    [[self createInlineBox2:0.9] addTo:block1];
    [[self createInlineBox2:1.0] addTo:block1];
    [[self createInlineBox2:0.1] addTo:block1];
    [[self createInlineBox2:0.2] addTo:block1];
    [[self createInlineBox2:0.3] addTo:block1];
    [[self createInlineBox2:0.4] addTo:block1];
    [[self createInlineBox2:0.5] addTo:block1];
    [[self createInlineBox2:0.6] addTo:block1];
    [[self createInlineBox2:0.7] addTo:block1];
    [[self createInlineBox2:0.8] addTo:block1];
    [[self createInlineBox2:0.9] addTo:block1];
    [[self createInlineBox2:1.0] addTo:block1];

    ALView * block2 = [[ALView alloc] init];
    block2.style.marginTop = 20;
    block2.style.marginLeft = 20;
    block2.style.marginRight = 20;
    block2.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    [block2 addTo:scbox2];
    
    [[self createInlineBox2:0.1] addTo:block2];
    [[self createInlineBox2:0.2] addTo:block2];
    [[self createInlineBox2:0.3] addTo:block2];
    [[self createInlineBox2:0.4] addTo:block2];
    [[self createInlineBox2:0.5] addTo:block2];
    [[self createInlineBox2:0.6] addTo:block2];
    [[self createInlineBox2:0.7] addTo:block2];
    [[self createInlineBox2:0.8] addTo:block2];
    [[self createInlineBox2:0.9] addTo:block2];
    [[self createInlineBox2:1.0] addTo:block2];
    [[self createInlineBox2:0.1] addTo:block2];
    [[self createInlineBox2:0.2] addTo:block2];
    [[self createInlineBox2:0.3] addTo:block2];
    [[self createInlineBox2:0.4] addTo:block2];
    [[self createInlineBox2:0.5] addTo:block2];
    [[self createInlineBox2:0.6] addTo:block2];
    [[self createInlineBox2:0.7] addTo:block2];
    [[self createInlineBox2:0.8] addTo:block2];
    [[self createInlineBox2:0.9] addTo:block2];
    [[self createInlineBox2:1.0] addTo:block2];
}

/*
 * ALScrollView测试用例
 * 1、当高度给定情况，contentSize会根据block类型的子view来自动撑高
 * 2、当存在fixed布局方式的子view TODO
 * 3、当存在absolute布局方式的子view TODO
 */
- (void) initLayoutWithScrollView
{
    ALScrollView * scbox = [[ALScrollView alloc] init];
    scbox.style.height = [[UIScreen mainScreen] bounds].size.height;
    scbox.backgroundColor = [UIColor greenColor];
    [scbox addTo:self.view];
    
    ALView * redbox = [[ALView alloc] init];
    redbox.style.height = 100;
    redbox.backgroundColor = [UIColor redColor];
    [redbox addTo:scbox];
//
    ALView * blueBox = [[ALView alloc] init];
    blueBox.style.height = 400;
    blueBox.backgroundColor = [UIColor blueColor];
    [blueBox addTo:scbox];
    
    ALView * yellowBox = [[ALView alloc] init];
    yellowBox.style.height = 400;
    yellowBox.backgroundColor = [UIColor yellowColor];
    [yellowBox addTo:scbox];
//
    ALView * absoluteGradView = [[ALView alloc] init];
//    absoluteGradView.style.height = 50;
//    absoluteGradView.style.width = 50;
    absoluteGradView.style.size = (CGSize) {50, 50};
//    absoluteGradView.style.top = 20;
//    absoluteGradView.style.left = 20;
    absoluteGradView.style.origin = (ALRect) {20, 0, 0, 20};
    absoluteGradView.backgroundColor = [UIColor grayColor];
    absoluteGradView.style.position = ALPositionAbsolute;
    [absoluteGradView addTo:scbox];
    
    ALView * absoluteGradView2 = [[ALView alloc] init];
//    absoluteGradView2.style.height = 50;
//    absoluteGradView2.style.width = 50;
    absoluteGradView2.style.size = (CGSize) {50, 50};
//    absoluteGradView2.style.top = 20;
//    absoluteGradView2.style.right = 20;
    absoluteGradView2.style.origin = (ALRect) {20, 20, 0, 0};
    absoluteGradView2.backgroundColor = [UIColor grayColor];
    absoluteGradView2.style.position = ALPositionAbsolute;
    [absoluteGradView2 addTo:scbox];
    
    ALView * absoluteGradView3 = [[ALView alloc] init];
//    absoluteGradView3.style.height = 50;
//    absoluteGradView3.style.width = 50;
    absoluteGradView3.style.size = (CGSize) {50, 50};
//    absoluteGradView3.style.bottom = 20;
//    absoluteGradView3.style.right = 20;
    absoluteGradView3.style.origin = (ALRect) {0, 0, 20, 20};
    absoluteGradView3.backgroundColor = [UIColor grayColor];
    absoluteGradView3.style.position = ALPositionAbsolute;
    [absoluteGradView3 addTo:scbox];

//
//    ALView * fixedWhiteView = [[ALView alloc] init];
//    fixedWhiteView.style.height = 50;
//    fixedWhiteView.style.width = 50;
//    fixedWhiteView.style.top = 20;
//    fixedWhiteView.style.right = 20;
//    fixedWhiteView.backgroundColor = [UIColor whiteColor];
//    fixedWhiteView.style.position = ALPositionFixed;
//    [fixedWhiteView addTo:scbox];
}

- (void) initLayoutWithAbsolutePriority
{
    ALView * body = [[ALView alloc] init];
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    body.style.height = 200;
    body.style.margin = (ALRect) {50, 50, 0, 50};
//    body.style.marginTop = 50;
//    body.style.marginLeft = 50;
//    body.style.marginRight = 50;
    [body addTo:self.view];
    
    // If you had set `left` property, then `right` propert is ignore
    [[self createAbsoluteBox:0 left:10 right:10 bottom:0 alpha:0.2] addTo: body];
    [[self createAbsoluteBox:0 left:0 right:10 bottom:0 alpha:0.4] addTo: body];
    
    ALView * body2 = [[ALView alloc] init];
    body2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    body2.style.height = 200;
    body2.style.margin = (ALRect) {50, 50, 0, 50};
//    body2.style.marginTop = 50;
//    body2.style.marginLeft = 50;
//    body2.style.marginRight = 50;
    [body2 addTo:self.view];
    
    // If you had set `top` property, then `bottom` propert is ignore
    [[self createAbsoluteBox:10 left:0 right:0 bottom:10 alpha:0.2] addTo: body2];
    [[self createAbsoluteBox:0 left:0 right:0 bottom:10 alpha:0.4] addTo: body2];
}

- (void) initLayoutWithAbsolute
{
    _body = [[ALView alloc] init];
    _body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    _body.style.height = 200;
    _body.style.margin = (ALRect) {100, 50, 0, 50};
//    body.style.marginTop = 100;
//    body.style.marginLeft = 50;
//    body.style.marginRight = 50;
    [_body addTo:self.view];
    
    [[self createAbsoluteBox:10 left:10 right:0 bottom:0 alpha:0.1] addTo: _body];
    [[self createAbsoluteBox:10 left:0 right:10 bottom:0 alpha:0.2] addTo: _body];
    [[self createAbsoluteBox:0 left:10 right:0 bottom:10 alpha:0.3] addTo: _body];
    [[self createAbsoluteBox:0 left:0 right:10 bottom:10 alpha:0.1] addTo: _body];
    
    
    [[self createAbsoluteBox:-50 left:-50 right:0 bottom:0 alpha:0.1] addTo: _body];
    [[self createAbsoluteBox:-50 left:0 right:-50 bottom:0 alpha:0.2] addTo: _body];
    [[self createAbsoluteBox:0 left:-50 right:0 bottom:-50 alpha:0.3] addTo: _body];
    [[self createAbsoluteBox:0 left:0 right:-50 bottom:-50 alpha:0.4] addTo: _body];
    
    [[self createSizeCtrlView] addTo: self.view];
}
- (ALView *) createAbsoluteBox: (CGFloat) top left: (CGFloat) left right: (CGFloat) right bottom: (CGFloat) bottom alpha: (CGFloat) alpha
{
    ALView * box = [[ALView alloc] init];
//    box.style.height = 40;
//    box.style.width = 40;
    box.style.size = (CGSize) {40, 40};
    box.style.position = ALPositionAbsolute;
    box.style.origin = (ALRect) {top, right, bottom, left};
//    if (top) box.style.top = top;
//    if (left) box.style.left = left;
//    if (right) box.style.right = right;
//    if (bottom) box.style.bottom = bottom;
    box.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return box;
}

- (void) initLayoutWithMargin
{
    ALView * body = [[ALView alloc] init];
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    [body addTo:self.view];
    body.style.contentAlign = ALContentAlignRight;
    
    [[self createInlineBox1:0.1] addTo:body];
    [[self createInlineBox1:0.2] addTo:body];
    [[self createInlineBox1:0.3] addTo:body];
    [[self createInlineBox1:0.4] addTo:body];
    [[self createInlineBox1:0.5] addTo:body];
    [[self createInlineBox1:0.6] addTo:body];
    [[self createInlineBox1:0.7] addTo:body];
    [[self createInlineBox1:0.8] addTo:body];
    [[self createInlineBox1:0.9] addTo:body];
    
    ALView * article2 = [[ALView alloc] init];
    article2.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
//    article2.style.marginTop = 10;
    article2.style.marginLeft = 20;
    article2.style.marginRight = 20;
    [article2 addTo:body];
//
    [[self createInlineBox1:0.1] addTo:article2];
    [[self createInlineBox1:0.2] addTo:article2];
    [[self createInlineBox1:0.3] addTo:article2];
    [[self createInlineBox1:0.4] addTo:article2];
    [[self createInlineBox1:0.5] addTo:article2];
    [[self createInlineBox1:0.6] addTo:article2];
    [[self createInlineBox1:0.7] addTo:article2];
    [[self createInlineBox1:0.8] addTo:article2];
    [[self createInlineBox1:0.9] addTo:article2];
    [[self createInlineBox1:1.0] addTo:article2];
//    NSLog(@"%@", article2.rows);
    
    
    [[self createInlineBox1:0.1] addTo:body];
    [[self createInlineBox1:0.2] addTo:body];
    [[self createInlineBox1:0.3] addTo:body];
    [[self createInlineBox1:0.4] addTo:body];
    [[self createInlineBox1:0.5] addTo:body];
    [[self createInlineBox1:0.6] addTo:body];
    [[self createInlineBox1:0.7] addTo:body];
    [[self createInlineBox1:0.8] addTo:body];
    [[self createInlineBox1:0.9] addTo:body];
    
//    NSLog(@"%@", body.rows);
}

- (ALView *) createInlineBox1: (CGFloat) alpha
{
    ALView * view = [ALView newInlineView];
    view.style.size = (CGSize) {40, 50};
    view.style.margin = (ALRect) {10, 10, 10, 10};
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return view;
}
- (ALView *) createInlineBox2: (CGFloat) alpha
{
    ALView * subInline = [[ALView alloc] init];
    subInline.style.height = 50;
    subInline.style.width = 80;
    subInline.style.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return subInline;
}

- (void) initLayout
{
    ALView * body = [[ALView alloc] init];
    [body addTo:self.view];
    
    ALView * header = [[ALView alloc] init];
    header.style.height = 120;
    header.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    [header addTo:body];
    
    ALView * container = [[ALView alloc] init];
    [container addTo:body];
    
    [[self createInlineBox2:0.1] addTo:container];
    [[self createInlineBox2:0.2] addTo:container];
    [[self createInlineBox2:0.3] addTo:container];
    [[self createInlineBox2:0.4] addTo:container];
    [[self createInlineBox2:0.5] addTo:container];
    [[self createInlineBox2:0.6] addTo:container];
    [[self createInlineBox2:0.7] addTo:container];
    [[self createInlineBox2:0.8] addTo:container];
    
    ALView * footer = [[ALView alloc] init];
    footer.style.height = 150;
    footer.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    [footer addTo:body];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
