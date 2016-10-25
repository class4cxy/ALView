//
//  ViewController.m
//  autolayout
//
//  Created by 陈小雅 on 16/10/14.
//  Copyright © 2016年 陈小雅. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ALBase.h"
#import "ALBaseView.h"

@interface ViewController () <UIScrollViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initLayoutWithMargin];
//    [self initLayout];
    [self initLayoutWithAbsolute];
//    [self initLayoutWithScrollView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) initLayoutWithScrollView
{
    UIScrollView * scbox = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    scbox.contentSize = CGSizeMake(scbox.frame.size.width * 2, scbox.frame.size.height * 3);
    scbox.delegate = self;
//    scbox.contentOffset = CGPointMake(0, -200);
    scbox.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scbox];
    
    ALBaseView * redbox = [[ALBaseView alloc] init];
    redbox.height = 100;
    redbox.width = [[UIScreen mainScreen] bounds].size.width;
    redbox.position = ALPositionAbsolute;
    redbox.backgroundColor = [UIColor redColor];
    
    [redbox addTo:scbox];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%@", NSStringFromCGPoint(point));
}

- (void) initLayoutWithAbsolute
{
    ALBaseView * body = [[ALBaseView alloc] init];
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
- (ALBaseView *) createAbsoluteBox: (CGFloat) top left: (CGFloat) left right: (CGFloat) right bottom: (CGFloat) bottom alpha: (CGFloat) alpha
{
    ALBaseView * box = [[ALBaseView alloc] init];
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
    ALBaseView * body = [[ALBaseView alloc] init];
    body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
//    body.height = 450;
    [body addTo:self.view];
    
    ALBaseView * article2 = [[ALBaseView alloc] init];
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
    
    ALBaseView * subInline = [[ALBaseView alloc] init];
    subInline.height = 40;
    subInline.width = 40;
    subInline.marginTop = 20;
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

- (ALBaseView *) createInlineBox1: (CGFloat) alpha
{
    ALBaseView * subInline = [[ALBaseView alloc] init];
    subInline.height = 40;
    subInline.width = 40;
    subInline.marginTop = 10;
    subInline.marginLeft = 10;
    subInline.marginRight = 10;
    subInline.marginBottom = 10;
    subInline.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return subInline;
}
- (ALBaseView *) createInlineBox2: (CGFloat) alpha
{
    ALBaseView * subInline = [[ALBaseView alloc] init];
    subInline.height = 50;
    subInline.width = 80;
    subInline.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return subInline;
}

- (void) initLayout
{
    ALBaseView * body = [[ALBaseView alloc] init];
    [body addTo:self.view];
    
    ALBaseView * header = [[ALBaseView alloc] init];
    header.height = 120;
    header.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    [header addTo:body];
    
    ALBaseView * container = [[ALBaseView alloc] init];
    [container addTo:body];
    
    [[self createInlineBox2:0.1] addTo:container];
    [[self createInlineBox2:0.2] addTo:container];
    [[self createInlineBox2:0.3] addTo:container];
    [[self createInlineBox2:0.4] addTo:container];
    [[self createInlineBox2:0.5] addTo:container];
    [[self createInlineBox2:0.6] addTo:container];
    [[self createInlineBox2:0.7] addTo:container];
    [[self createInlineBox2:0.8] addTo:container];
    
    ALBaseView * footer = [[ALBaseView alloc] init];
    footer.height = 150;
    footer.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    [footer addTo:body];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
