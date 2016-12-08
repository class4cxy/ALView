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
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initLayoutWithMargin];
//    [self initLayout];
//    [self initLayoutWithAbsolute];
//    [self initLayoutWithAbsolutePriority];
//    [self initLayoutWithScrollView];
//    [self initMixScrollLayout];
//    [self initInlineLayout];
//    [self initBlockContentBlockLayout];
//    [self initSiblingLayout];
//    [self initBlockContentInlineLayout];
//    [self initInlineAutoWidthHeightLayout];
//    [self initALLabelAutoHeightWidthLayout];
//    [self initBlockAndInlineLayout1];
//    [self initBlockAndInlineLayout2];
//    [self initBlockLayout];
//    [self initInlineLayout];
//    [self initMarginLayout];
//    [self initPaddingLayout];
    
//    [self initDynamicLayout];
    [self initDynamicAbsolute];
//    [self initPositionAutoSizeWhenBottomAndRight];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) initPositionAutoSizeWhenBottomAndRight
{
    ALView * body = [[ALView alloc] init];
    body.style.height = [[UIScreen mainScreen] bounds].size.height;
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [body addTo: self.view];

    ALView * sub1 = [[ALView alloc] init];
    sub1.style.position = ALPositionAbsolute;
    sub1.style.display = ALDisplayInline;
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
    [body2 addTo: b];
    
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

    
    ALView * block1 = [[ALView alloc] init];
    block1.style.height = 100;
    block1.style.width = 200;
    block1.style.marginBottom = 10;
    block1.backgroundColor = [UIColor redColor];
    [block1 addTo: _body];

    [[self createInlineViewWidth:40 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _body];
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _body];

    [[self createSizeCtrlView] addTo:b];
}

- (void) initDynamicAbsolute
{
    ALView * b = [[ALView alloc] init];
    b.style.height = [[UIScreen mainScreen] bounds].size.height;
    [b addTo: self.view];
    
    _section1 = [[ALView alloc] init];
    _section1.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.2];
    _section1.style.position = ALPositionAbsolute;
    _section1.style.centerX = 0;
    _section1.style.centerY = 0;
    _section1.style.width = 200;
    _section1.style.contentAlign = ALContentAlignCenter;
    [_section1 addTo:b];
    
    [[self createInlineViewWidth:40 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _section1];
    
    _block = [self createBlockViewWidth: 0 height:0 alpha:0.5];
    _block.style.hidden = YES;
    _block.style.contentAlign = ALContentAlignRight;
    [_block addTo: _section1];
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:40 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _block];
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _block];
    
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:40 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:100 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:60 height:30 alpha:0.5] addTo: _section1];
    [[self createInlineViewWidth:170 height:30 alpha:0.5] addTo: _section1];
    
    [[self createSizeCtrlView] addTo:b];
    [[self createHiddenCtrlView] addTo:b];
}

- (ALView *) createSizeCtrlView
{
    ALView * panelWrap = [[ALView alloc] init];
    panelWrap.style.position = ALPositionAbsolute;
    panelWrap.style.bottom = 10;
    panelWrap.style.left = 10;
    
    ALLabel * widthTx = [[ALLabel alloc] init];
    widthTx.text = @"height: ";
    widthTx.font = [UIFont systemFontOfSize:12];
    widthTx.style.height = 30;
    [widthTx addTo: panelWrap];
    
    ALLabel * subBtn = [[ALLabel alloc] init];
    subBtn.userInteractionEnabled = YES;
    subBtn.text = @"-";
    subBtn.style.height = 30;
    subBtn.style.width = 30;
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
    addBtn.style.height = 30;
    addBtn.style.width = 30;
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
    _section1.style.width -= 5;
//    _section1.style.height -= 5;
//    _section1.style.marginBottom -= 3;
    [_section1 reflow];
}
- (void) addTheSize
{
    _section1.style.width += 5;
//    _section1.style.height += 5;
//    _section1.style.marginBottom += 3;
    [_section1 reflow];
//    NSLog(@"%@", _body.);
}

- (void) hideView
{
    _block.style.hidden = YES;
    [_block reflow];
}

- (void) showView
{
    _block.style.hidden = NO;
    [_block reflow];
}


- (ALView *) createBlockViewWidth: (CGFloat) width height: (CGFloat) height alpha: (CGFloat) alpha
{
    ALView * view = [[ALView alloc] init];
    view.style.marginRight = 5;
    view.style.marginBottom = 5;
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
    article.style.marginRight = 20;
    article.style.marginLeft = 20;
    article.style.marginTop = 50;
    article.style.height = 100;
    article.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [article addTo: body];
    
    ALLabel * tx = [[ALLabel alloc] init];
    tx.style.marginTop = 20;
    tx.style.marginLeft = 20;
    tx.style.paddingTop = 20;
    tx.style.paddingLeft = 30;
    tx.style.paddingBottom = 30;
    tx.style.paddingRight = 50;
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
    article.style.marginRight = 20;
    article.style.marginLeft = 20;
    article.style.marginTop = 50;
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
    block2.style.width = 300;
    block2.backgroundColor = [UIColor blueColor];
    [block2 addTo:body];
    
    ALLabel * tx2 = [[ALLabel alloc] init];
    tx2.text = @"我也是block view，我设置了width=300";
    tx2.font = [UIFont systemFontOfSize:12];
    tx2.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [tx2 addTo:block2];
    
    
    ALView * block3 = [[ALView alloc] init];
    block3.style.marginTop = 20;
    block3.style.height = 100;
    block3.style.width = 200;
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

- (ALView *) createInlineViewWidth: (CGFloat) width height: (CGFloat) height alpha: (CGFloat) alpha
{
    ALView * inlineView = [[ALView alloc] init];
    inlineView.style.display = ALDisplayInline;
    inlineView.style.marginRight = 5;
    inlineView.style.marginBottom = 5;
    inlineView.style.height = height;
    inlineView.style.width = width;
    inlineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return inlineView;
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
    [[self createALLabel: @"jdochen8765dbsabdsadsadjksakjdsajdskjadsjkawwwwwwwww" numberOfLine:1] addTo:blockwrap];
    [[self createALLabel: @"jdochen8765dbsabdsadsadjksakjdsajdskjadsjkawwwwwwwww" numberOfLine:0] addTo:blockwrap];
    [[self createALLabel: @"jdochen" numberOfLine:0] addTo:blockwrap];
}

- (ALLabel *) createALLabel: (NSString *) text numberOfLine: (NSInteger) num
{
    ALLabel * tx1 = [[ALLabel alloc] init];
    tx1.text = text;
    tx1.style.marginTop = 2;
    tx1.style.marginRight = 2;
    tx1.style.padding = 10;
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

- (void) initSiblingLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALScrollView * artivle1 = [[ALScrollView alloc] init];
    artivle1.style.marginBottom = 20;
    artivle1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle1 addTo: body];
    
    NSLog(@"%@", artivle1.alPreviousSibling);
    NSLog(@"%@", artivle1.alNextSibling);
    
    ALScrollView * artivle2 = [[ALScrollView alloc] init];
    artivle2.style.marginBottom = 20;
    artivle2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle2 addTo: body];
    
    NSLog(@"%@", artivle1);
    NSLog(@"%@", artivle2);
    NSLog(@"previousSibling: %@", artivle1.alPreviousSibling);
    NSLog(@"nextSibling: %@", artivle1.alNextSibling);
    NSLog(@"previousSibling: %@", artivle2.alPreviousSibling);
    NSLog(@"nextSibling: %@", artivle2.alNextSibling);
}
- (void) initBlockContentInlineLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * artivle1 = [[ALView alloc] init];
    artivle1.style.marginBottom = 20;
    artivle1.style.marginTop = 20;
    artivle1.style.contentAlign = ALContentAlignLeft;
    artivle1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle1 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:artivle1];
    [[self createInlineBox1:0.2] addTo:artivle1];
    [[self createInlineBox1:0.3] addTo:artivle1];
    [[self createInlineBox1:0.4] addTo:artivle1];
    [[self createInlineBox1:0.5] addTo:artivle1];
    [[self createInlineBox1:0.6] addTo:artivle1];
    
    ALView * artivle2 = [[ALView alloc] init];
    artivle2.style.marginBottom = 20;
    artivle2.style.contentAlign = ALContentAlignCenter;
    artivle2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle2 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:artivle2];
    [[self createInlineBox1:0.2] addTo:artivle2];
    [[self createInlineBox1:0.3] addTo:artivle2];
    [[self createInlineBox1:0.4] addTo:artivle2];
    [[self createInlineBox1:0.5] addTo:artivle2];
    [[self createInlineBox1:0.6] addTo:artivle2];
    
    ALView * artivle3 = [[ALView alloc] init];
    artivle3.style.marginBottom = 20;
    artivle3.style.contentAlign = ALContentAlignRight;
    artivle3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle3 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:artivle3];
    [[self createInlineBox1:0.2] addTo:artivle3];
    [[self createInlineBox1:0.3] addTo:artivle3];
    [[self createInlineBox1:0.4] addTo:artivle3];
    [[self createInlineBox1:0.5] addTo:artivle3];
    [[self createInlineBox1:0.6] addTo:artivle3];
    [[self createInlineBox1:0.7] addTo:artivle3];
    [[self createInlineBox1:0.8] addTo:artivle3];
//    NSLog(@"%@", artivle3.rows);
}

- (void) initBlockContentBlockLayout
{
    ALView * body = [[ALView alloc] init];
    body.style.marginTop = 20;
    [body addTo: self.view];
    
    ALView * artivle1 = [[ALView alloc] init];
    artivle1.style.marginBottom = 20;
    artivle1.style.marginTop = 20;
    artivle1.style.contentAlign = ALContentAlignLeft;
    artivle1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle1 addTo: body];
    
    ALView * block1 = [[ALView alloc] init];
    block1.style.width = 150;
    block1.style.height = 100;
    block1.backgroundColor = [UIColor yellowColor];
    [block1 addTo: artivle1];
    
    ALView * artivle2 = [[ALView alloc] init];
    artivle2.style.marginBottom = 20;
    artivle2.style.contentAlign = ALContentAlignCenter;
    artivle2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle2 addTo: body];
    
    ALView * block2 = [[ALView alloc] init];
    block2.style.width = 150;
    block2.style.height = 100;
    block2.backgroundColor = [UIColor blueColor];
    [block2 addTo: artivle2];
    
    ALView * artivle3 = [[ALView alloc] init];
    artivle3.style.marginBottom = 20;
    artivle3.style.contentAlign = ALContentAlignRight;
    artivle3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle3 addTo: body];
    
    ALView * block3 = [[ALView alloc] init];
    block3.style.width = 150;
    block3.style.height = 100;
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
    absoluteGradView.style.height = 50;
    absoluteGradView.style.width = 50;
    absoluteGradView.style.top = 20;
    absoluteGradView.style.left = 20;
    absoluteGradView.backgroundColor = [UIColor grayColor];
    absoluteGradView.style.position = ALPositionAbsolute;
    [absoluteGradView addTo:scbox];
    
    ALView * absoluteGradView2 = [[ALView alloc] init];
    absoluteGradView2.style.height = 50;
    absoluteGradView2.style.width = 50;
    absoluteGradView2.style.top = 20;
    absoluteGradView2.style.right = 20;
    absoluteGradView2.backgroundColor = [UIColor grayColor];
    absoluteGradView2.style.position = ALPositionAbsolute;
    [absoluteGradView2 addTo:scbox];
    
    ALView * absoluteGradView3 = [[ALView alloc] init];
    absoluteGradView3.style.height = 50;
    absoluteGradView3.style.width = 50;
    absoluteGradView3.style.bottom = 20;
    absoluteGradView3.style.right = 20;
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
    body.style.marginTop = 50;
    body.style.marginLeft = 50;
    body.style.marginRight = 50;
    [body addTo:self.view];
    
    // If you had set `left` property, then `right` propert is ignore
    [[self createAbsoluteBox:0 left:10 right:10 bottom:0 alpha:0.2] addTo: body];
    [[self createAbsoluteBox:0 left:0 right:10 bottom:0 alpha:0.4] addTo: body];
    
    ALView * body2 = [[ALView alloc] init];
    body2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    body2.style.height = 200;
    body2.style.marginTop = 50;
    body2.style.marginLeft = 50;
    body2.style.marginRight = 50;
    [body2 addTo:self.view];
    
    // If you had set `top` property, then `bottom` propert is ignore
    [[self createAbsoluteBox:10 left:0 right:0 bottom:10 alpha:0.2] addTo: body2];
    [[self createAbsoluteBox:0 left:0 right:0 bottom:10 alpha:0.4] addTo: body2];
}

- (void) initLayoutWithAbsolute
{
    ALView * body = [[ALView alloc] init];
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    body.style.height = 200;
    body.style.marginTop = 100;
    body.style.marginLeft = 50;
    body.style.marginRight = 50;
    [body addTo:self.view];
    
    [[self createAbsoluteBox:20 left:20 right:0 bottom:0 alpha:0.1] addTo: body];
    [[self createAbsoluteBox:10 left:0 right:10 bottom:0 alpha:0.2] addTo: body];
    [[self createAbsoluteBox:0 left:10 right:0 bottom:10 alpha:0.3] addTo: body];
    [[self createAbsoluteBox:0 left:0 right:20 bottom:20 alpha:0.1] addTo: body];
    
    
    [[self createAbsoluteBox:-50 left:-50 right:0 bottom:0 alpha:0.1] addTo: body];
    [[self createAbsoluteBox:-50 left:0 right:-50 bottom:0 alpha:0.2] addTo: body];
    [[self createAbsoluteBox:0 left:-50 right:0 bottom:-50 alpha:0.3] addTo: body];
    [[self createAbsoluteBox:0 left:0 right:-50 bottom:-50 alpha:0.4] addTo: body];
}
- (ALView *) createAbsoluteBox: (CGFloat) top left: (CGFloat) left right: (CGFloat) right bottom: (CGFloat) bottom alpha: (CGFloat) alpha
{
    ALView * box = [[ALView alloc] init];
    box.style.height = 40;
    box.style.width = 40;
    box.style.position = ALPositionAbsolute;
    if (top) box.style.top = top;
    if (left) box.style.left = left;
    if (right) box.style.right = right;
    if (bottom) box.style.bottom = bottom;
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
    ALView * subInline = [[ALView alloc] init];
    subInline.style.height = 50;
    subInline.style.width = 40;
    subInline.style.marginTop = 10;
    subInline.style.marginLeft = 10;
    subInline.style.marginRight = 10;
    subInline.style.marginBottom = 10;
    subInline.style.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return subInline;
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
