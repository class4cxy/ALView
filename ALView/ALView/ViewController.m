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
    
    [self initLayoutWithMargin];
//    [self initLayout];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) initLayoutWithMargin
{
//    ALView * article1 = [[ALView alloc] init];
//    [article1 addTo:self.view];
//    
//    ALView * subBox1 = [[ALView alloc] init];
//    subBox1.height = 120;
//    subBox1.marginTop = 20;
//    subBox1.marginLeft = 20;
//    subBox1.marginRight = 20;
//    subBox1.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
//    [subBox1 addTo:article1];
//    
//    ALView * subBox2 = [[ALView alloc] init];
//    subBox2.height = 120;
//    subBox2.marginTop = 20;
//    subBox2.marginLeft = 20;
//    subBox2.marginRight = 20;
//    subBox2.marginBottom = 20;
//    subBox2.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
//    [subBox2 addTo:article1];
    
    ALView * article2 = [[ALView alloc] init];
    article2.marginLeft = 20;
    article2.marginRight = 20;
    [article2 addTo:self.view];
    
    [[self createInlineBox1:0.1] addTo:article2];
    [[self createInlineBox1:0.2] addTo:article2];
    [[self createInlineBox1:0.3] addTo:article2];
    [[self createInlineBox1:0.4] addTo:article2];
    [[self createInlineBox1:0.5] addTo:article2];
    [[self createInlineBox1:0.6] addTo:article2];
    [[self createInlineBox1:0.7] addTo:article2];
    [[self createInlineBox1:0.8] addTo:article2];
    [[self createInlineBox1:0.9] addTo:article2];
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
    subInline.display = ALDisplayInlineBlock;
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
    
    ALView * inlineSub1 = [[ALView alloc] init];
    inlineSub1.height = 50;
    inlineSub1.width = 80;
    inlineSub1.display = ALDisplayInlineBlock;
    inlineSub1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [inlineSub1 addTo:container];
    
    ALView * inlineSub2 = [[ALView alloc] init];
    inlineSub2.height = 50;
    inlineSub2.width = 80;
    inlineSub2.display = ALDisplayInlineBlock;
    inlineSub2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [inlineSub2 addTo:container];
    
    ALView * inlineSub3 = [[ALView alloc] init];
    inlineSub3.height = 50;
    inlineSub3.width = 80;
    inlineSub3.display = ALDisplayInlineBlock;
    inlineSub3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [inlineSub3 addTo:container];
    
    ALView * inlineSub4 = [[ALView alloc] init];
    inlineSub4.height = 50;
    inlineSub4.width = 80;
    inlineSub4.display = ALDisplayInlineBlock;
    inlineSub4.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [inlineSub4 addTo:container];
    
    ALView * inlineSub5 = [[ALView alloc] init];
    inlineSub5.height = 50;
    inlineSub5.width = 80;
    inlineSub5.display = ALDisplayInlineBlock;
    inlineSub5.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [inlineSub5 addTo:container];
    
    ALView * inlineSub6 = [[ALView alloc] init];
    inlineSub6.height = 50;
    inlineSub6.width = 80;
    inlineSub6.display = ALDisplayInlineBlock;
    inlineSub6.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [inlineSub6 addTo:container];
    
    ALView * inlineSub7 = [[ALView alloc] init];
    inlineSub7.height = 50;
    inlineSub7.width = 80;
    inlineSub7.display = ALDisplayInlineBlock;
    inlineSub7.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [inlineSub7 addTo:container];
    
    ALView * inlineSub8 = [[ALView alloc] init];
    inlineSub8.height = 50;
    inlineSub8.width = 80;
    inlineSub8.display = ALDisplayInlineBlock;
    inlineSub8.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [inlineSub8 addTo:container];
    
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
