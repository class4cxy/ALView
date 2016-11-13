//
//  ViewController.m
//  autolayout
//
//  Created by 陈小雅 on 16/10/14.
//  Copyright © 2016年 陈小雅. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ALBase.h"

@interface ViewController () <UIScrollViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initLayoutWithMargin];
//    [self initLayout];
//    [self initLayoutWithAbsolute];
//    [self initLayoutWithScrollView];
//    [self initMixScrollLayout];
//    [self initInlineLayout];
//    [self initBlockContentBlockLayout];
//    [self initSiblingLayout];
//    [self initBlockContentInlineLayout];
    [self initInlineAutoWidthHeightLayout];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) initInlineAutoWidthHeightLayout
{
    ALView * body = [[ALView alloc] init];
    body.marginTop = 20;
    [body addTo: self.view];

    ALView * inlinewrap = [[ALView alloc] init];
    inlinewrap.backgroundColor = [UIColor redColor];
    inlinewrap.display = ALDisplayInline;
    [inlinewrap addTo: body];
    
    [[self createInlineBox1:0.1] addTo:inlinewrap];
    [[self createInlineBox1:0.2] addTo:inlinewrap];
    [[self createInlineBox1:0.3] addTo:inlinewrap];
    [[self createInlineBox1:0.4] addTo:inlinewrap];
    [[self createInlineBox1:0.5] addTo:inlinewrap];
    [[self createInlineBox1:0.6] addTo:inlinewrap];
    [[self createInlineBox1:0.7] addTo:inlinewrap];
    [[self createInlineBox1:0.8] addTo:inlinewrap];
}

- (void) initSiblingLayout
{
    ALView * body = [[ALView alloc] init];
    body.marginTop = 20;
    [body addTo: self.view];
    
    ALScrollView * artivle1 = [[ALScrollView alloc] init];
    artivle1.marginBottom = 20;
    artivle1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle1 addTo: body];
    
    NSLog(@"%@", artivle1.previousSibling);
    NSLog(@"%@", artivle1.nextSibling);
    
    ALScrollView * artivle2 = [[ALScrollView alloc] init];
    artivle2.marginBottom = 20;
    artivle2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle2 addTo: body];
    
    NSLog(@"%@", artivle1);
    NSLog(@"%@", artivle2);
    NSLog(@"previousSibling: %@", artivle1.previousSibling);
    NSLog(@"nextSibling: %@", artivle1.nextSibling);
    NSLog(@"previousSibling: %@", artivle2.previousSibling);
    NSLog(@"nextSibling: %@", artivle2.nextSibling);
}
- (void) initBlockContentInlineLayout
{
    ALView * body = [[ALView alloc] init];
    body.marginTop = 20;
    [body addTo: self.view];
    
    ALView * artivle1 = [[ALView alloc] init];
    artivle1.marginBottom = 20;
    artivle1.contentAlign = ALContentAlignLeft;
    artivle1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle1 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:artivle1];
    [[self createInlineBox1:0.2] addTo:artivle1];
    [[self createInlineBox1:0.3] addTo:artivle1];
    [[self createInlineBox1:0.4] addTo:artivle1];
    [[self createInlineBox1:0.5] addTo:artivle1];
    [[self createInlineBox1:0.6] addTo:artivle1];
    
    ALView * artivle2 = [[ALView alloc] init];
    artivle2.marginBottom = 20;
    artivle2.contentAlign = ALContentAlignCenter;
    artivle2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle2 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:artivle2];
    [[self createInlineBox1:0.2] addTo:artivle2];
    [[self createInlineBox1:0.3] addTo:artivle2];
    [[self createInlineBox1:0.4] addTo:artivle2];
    [[self createInlineBox1:0.5] addTo:artivle2];
    [[self createInlineBox1:0.6] addTo:artivle2];
    
//    ALView * inline2 = [[ALView alloc] init];
//    inline2.width = 150;
//    inline2.height = 50;
//    inline2.display = ALDisplayInline;
//    inline2.backgroundColor = [UIColor blueColor];
//    [inline2 addTo: artivle2];
    
    ALView * artivle3 = [[ALView alloc] init];
    artivle3.marginBottom = 20;
    artivle3.contentAlign = ALContentAlignRight;
    artivle3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle3 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:artivle3];
    [[self createInlineBox1:0.2] addTo:artivle3];
    [[self createInlineBox1:0.3] addTo:artivle3];
    [[self createInlineBox1:0.4] addTo:artivle3];
    [[self createInlineBox1:0.5] addTo:artivle3];
    [[self createInlineBox1:0.6] addTo:artivle3];
}

- (void) initBlockContentBlockLayout
{
    ALView * body = [[ALView alloc] init];
    body.marginTop = 20;
    [body addTo: self.view];
    
    ALView * artivle1 = [[ALView alloc] init];
    artivle1.marginBottom = 20;
    artivle1.contentAlign = ALContentAlignLeft;
    artivle1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle1 addTo: body];
    
    ALView * block1 = [[ALView alloc] init];
    block1.width = 150;
    block1.height = 100;
    block1.marginLeft = 20;
    block1.backgroundColor = [UIColor yellowColor];
    [block1 addTo: artivle1];
    
    ALView * artivle2 = [[ALView alloc] init];
    artivle2.marginBottom = 20;
    artivle2.contentAlign = ALContentAlignCenter;
    artivle2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle2 addTo: body];
    
    ALView * block2 = [[ALView alloc] init];
    block2.width = 150;
    block2.height = 100;
    block2.backgroundColor = [UIColor blueColor];
    [block2 addTo: artivle2];
    
    ALView * artivle3 = [[ALView alloc] init];
    artivle3.marginBottom = 20;
    artivle3.contentAlign = ALContentAlignRight;
    artivle3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [artivle3 addTo: body];
    
    ALView * block3 = [[ALView alloc] init];
    block3.width = 150;
    block3.height = 100;
    block3.marginRight = 20;
    block3.backgroundColor = [UIColor redColor];
    [block3 addTo: artivle3];
}

- (void) initInlineLayout
{
    ALView * body = [[ALView alloc] init];
    body.marginTop = 20;
    [body addTo:self.view];
    
    ALView * article1 = [[ALView alloc] init];
    article1.display = ALDisplayInline;
    article1.width = 320;
    article1.marginBottom = 20;
    article1.backgroundColor = [UIColor yellowColor];
    [article1 addTo: body];
    
    [[self createInlineBox1:0.1] addTo:article1];
    [[self createInlineBox1:0.2] addTo:article1];
    [[self createInlineBox1:0.3] addTo:article1];
    [[self createInlineBox1:0.4] addTo:article1];
    [[self createInlineBox1:0.5] addTo:article1];
    [[self createInlineBox1:0.6] addTo:article1];
    [[self createInlineBox1:0.7] addTo:article1];
    [[self createInlineBox1:0.8] addTo:article1];
    [[self createInlineBox1:0.9] addTo:article1];
    [[self createInlineBox1:1.0] addTo:article1];
    
    ALView * article2 = [[ALView alloc] init];
    article2.display = ALDisplayInline;
    article2.width = 320;
    article2.marginBottom = 20;
    article2.backgroundColor = [UIColor blueColor];
    [article2 addTo: body];
    
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
}

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
    body.height = [[UIScreen mainScreen] bounds].size.height;
    [body addTo: self.view];
    
    // header block view
    ALView * header = [[ALView alloc] init];
    header.marginTop = 20;
    header.backgroundColor = [UIColor greenColor];
    [header addTo:body];
    
    // header's subview inline view
    ALLabel * headerLabel = [[ALLabel alloc] init];
    headerLabel.height = 50;
    headerLabel.width = 140;
    headerLabel.marginTop = 10;
    headerLabel.marginLeft = 10;
    headerLabel.marginRight = 10;
    headerLabel.marginBottom = 10;
    headerLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [headerLabel addTo:header];
    
    ALLabel * headerLabel2 = [[ALLabel alloc] init];
    headerLabel2.height = 50;
    headerLabel2.width = 140;
    headerLabel2.marginTop = 10;
    headerLabel2.marginLeft = 10;
    headerLabel2.marginRight = 10;
    headerLabel2.marginBottom = 10;
    headerLabel2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [headerLabel2 addTo:header];
    
    ALScrollView * scbox1 = [[ALScrollView alloc] init];
    scbox1.marginTop = 10;
    scbox1.height = 200;
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
    
//    ALView * fixed1 = [[ALView alloc] init];
//    fixed1.width = 30;
//    fixed1.height = 30;
//    fixed1.top = 20;
//    fixed1.left = 20;
//    fixed1.position = ALPositionFixed;
//    fixed1.backgroundColor = [UIColor whiteColor];
//    [fixed1 addTo: scbox1];
    
    ALScrollView * scbox2 = [[ALScrollView alloc] init];
    scbox2.marginTop = 20;
    scbox2.height = 500;
    scbox2.backgroundColor = [UIColor redColor];
    [scbox2 addTo: body];
    
    ALView * block1 = [[ALView alloc] init];
    block1.marginTop = 20;
    block1.marginLeft = 20;
    block1.marginRight = 20;
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
    block2.marginTop = 20;
    block2.marginLeft = 20;
    block2.marginRight = 20;
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
    scbox.height = [[UIScreen mainScreen] bounds].size.height;
    scbox.backgroundColor = [UIColor greenColor];
    [scbox addTo:self.view];
    
    ALView * redbox = [[ALView alloc] init];
    redbox.height = 100;
    redbox.backgroundColor = [UIColor redColor];
    [redbox addTo:scbox];
//
    ALView * blueBox = [[ALView alloc] init];
    blueBox.height = 400;
    blueBox.backgroundColor = [UIColor blueColor];
    [blueBox addTo:scbox];
    
    ALView * yellowBox = [[ALView alloc] init];
    yellowBox.height = 400;
    yellowBox.backgroundColor = [UIColor yellowColor];
    [yellowBox addTo:scbox];
//
    ALView * absoluteGradView = [[ALView alloc] init];
    absoluteGradView.height = 50;
    absoluteGradView.width = 50;
    absoluteGradView.top = 20;
    absoluteGradView.left = 20;
    absoluteGradView.backgroundColor = [UIColor grayColor];
    absoluteGradView.position = ALPositionAbsolute;
    [absoluteGradView addTo:scbox];
    
    ALView * absoluteGradView2 = [[ALView alloc] init];
    absoluteGradView2.height = 50;
    absoluteGradView2.width = 50;
    absoluteGradView2.top = 20;
    absoluteGradView2.right = 20;
    absoluteGradView2.backgroundColor = [UIColor grayColor];
    absoluteGradView2.position = ALPositionAbsolute;
    [absoluteGradView2 addTo:scbox];
    
    ALView * absoluteGradView3 = [[ALView alloc] init];
    absoluteGradView3.height = 50;
    absoluteGradView3.width = 50;
    absoluteGradView3.bottom = 20;
    absoluteGradView3.right = 20;
    absoluteGradView3.backgroundColor = [UIColor grayColor];
    absoluteGradView3.position = ALPositionAbsolute;
    [absoluteGradView3 addTo:scbox];

//
//    ALView * fixedWhiteView = [[ALView alloc] init];
//    fixedWhiteView.height = 50;
//    fixedWhiteView.width = 50;
//    fixedWhiteView.top = 20;
//    fixedWhiteView.right = 20;
//    fixedWhiteView.backgroundColor = [UIColor whiteColor];
//    fixedWhiteView.position = ALPositionFixed;
//    [fixedWhiteView addTo:scbox];
}

- (void) initLayoutWithAbsolute
{
    ALView * body = [[ALView alloc] init];
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    body.height = 200;
    body.marginTop = 100;
    body.marginLeft = 50;
    body.marginRight = 50;
    [body addTo:self.view];
    
    [[self createAbsoluteBox:10 left:10 right:0 bottom:0 alpha:0.1] addTo: body];
    [[self createAbsoluteBox:10 left:0 right:10 bottom:0 alpha:0.2] addTo: body];
    [[self createAbsoluteBox:0 left:10 right:0 bottom:10 alpha:0.3] addTo: body];
    [[self createAbsoluteBox:0 left:0 right:10 bottom:10 alpha:0.4] addTo: body];
    
    
    [[self createAbsoluteBox:-50 left:-50 right:0 bottom:0 alpha:0.1] addTo: body];
    [[self createAbsoluteBox:-50 left:0 right:-50 bottom:0 alpha:0.2] addTo: body];
    [[self createAbsoluteBox:0 left:-50 right:0 bottom:-50 alpha:0.3] addTo: body];
    [[self createAbsoluteBox:0 left:0 right:-50 bottom:-50 alpha:0.4] addTo: body];
}
- (ALView *) createAbsoluteBox: (CGFloat) top left: (CGFloat) left right: (CGFloat) right bottom: (CGFloat) bottom alpha: (CGFloat) alpha
{
    ALView * box = [[ALView alloc] init];
    box.height = 40;
    box.width = 40;
    box.position = ALPositionAbsolute;
    if (top) box.top = top;
    if (left) box.left = left;
    if (right) box.right = right;
    if (bottom) box.bottom = bottom;
    box.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return box;
}

- (void) initLayoutWithMargin
{
    ALView * body = [[ALView alloc] init];
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
//    body.height = 450;
    [body addTo:self.view];
    
    ALView * article2 = [[ALView alloc] init];
    article2.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
    article2.marginTop = 50;
    article2.marginLeft = 20;
    article2.marginRight = 20;
    [article2 addTo:body];
    
    [[self createInlineBox1:0.1] addTo:article2];
    [[self createInlineBox1:0.2] addTo:article2];
    [[self createInlineBox1:0.3] addTo:article2];
    [[self createInlineBox1:0.4] addTo:article2];
    [[self createInlineBox1:0.5] addTo:article2];
    
    ALView * subInline = [[ALView alloc] init];
    subInline.height = 40;
    subInline.width = 40;
    subInline.marginTop = 50;
    subInline.marginLeft = 10;
    subInline.marginRight = 10;
    subInline.marginBottom = 10;
    subInline.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [subInline addTo:article2];
    
    [[self createInlineBox1:0.6] addTo:article2];
    [[self createInlineBox1:0.7] addTo:article2];
    [[self createInlineBox1:0.8] addTo:article2];
    [[self createInlineBox1:0.9] addTo:article2];
    [[self createInlineBox1:1.0] addTo:article2];
    
    
    [[self createInlineBox1:0.1] addTo:body];
    [[self createInlineBox1:0.2] addTo:body];
    [[self createInlineBox1:0.3] addTo:body];
    [[self createInlineBox1:0.4] addTo:body];
    [[self createInlineBox1:0.5] addTo:body];
    [[self createInlineBox1:0.6] addTo:body];
    [[self createInlineBox1:0.7] addTo:body];
    [[self createInlineBox1:0.8] addTo:body];
    [[self createInlineBox1:0.9] addTo:body];
    }

- (ALView *) createInlineBox1: (CGFloat) alpha
{
    ALView * subInline = [[ALView alloc] init];
    subInline.height = 50;
    subInline.width = 40;
    subInline.marginTop = 10;
    subInline.marginLeft = 10;
    subInline.marginRight = 10;
    subInline.marginBottom = 10;
    subInline.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return subInline;
}
- (ALView *) createInlineBox2: (CGFloat) alpha
{
    ALView * subInline = [[ALView alloc] init];
    subInline.height = 50;
    subInline.width = 80;
    subInline.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return subInline;
}

- (void) initLayout
{
    ALView * body = [[ALView alloc] init];
    [body addTo:self.view];
    
    ALView * header = [[ALView alloc] init];
    header.height = 120;
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
    footer.height = 150;
    footer.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    [footer addTo:body];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
