//
//  ViewController.m
//  autolayout
//
//  Created by 陈小雅 on 16/10/14.
//  Copyright © 2016年 陈小雅. All rights reserved.
//

#import "ViewController.h"
#import "ALView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initLayoutWithMargin];
//    [self initLayout];
    [self initLayoutWithAbsolute];
    
    // Do any additional setup after loading the view, typically from a nib.
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

- (ALView *) createInlineBox1: (CGFloat) alpha
{
    ALView * subInline = [[ALView alloc] init];
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
