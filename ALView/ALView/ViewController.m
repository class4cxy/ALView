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
    
    ALView * redBox = [[ALView alloc] init];
    redBox.backgroundColor = [UIColor redColor];
    redBox.height = 100;
    [redBox addTo:self.view];
    
    ALView * greenBox = [[ALView alloc] init];
    greenBox.backgroundColor = [UIColor greenColor];
    greenBox.height = 100;
    greenBox.width = 100;
    [greenBox addTo:self.view];
    
    ALView * blackBox = [[ALView alloc] init];
    blackBox.backgroundColor = [UIColor blackColor];
//    blackBox.height = 30;
    [blackBox addTo:self.view];
    
    ALView * yellowBox = [[ALView alloc] init];
    yellowBox.backgroundColor = [UIColor yellowColor];
    yellowBox.height = 100;
    yellowBox.width = 100;
    yellowBox.display = ALDisplayInlineBlock;
    [yellowBox addTo:blackBox];
    
    ALView * whiteBox = [[ALView alloc] init];
    whiteBox.backgroundColor = [UIColor whiteColor];
    whiteBox.height = 150;
    whiteBox.width = 100;
    whiteBox.display = ALDisplayInlineBlock;
    [whiteBox addTo:blackBox];
    
    ALView * grayBox = [[ALView alloc] init];
    grayBox.backgroundColor = [UIColor grayColor];
    grayBox.height = 100;
    grayBox.width = 100;
    grayBox.display = ALDisplayInlineBlock;
    [grayBox addTo:blackBox];
    
    ALView * blueBox = [[ALView alloc] init];
    blueBox.backgroundColor = [UIColor blueColor];
    blueBox.height = 100;
    blueBox.width = 50;
    blueBox.display = ALDisplayInlineBlock;
    [blueBox addTo:blackBox];
    
    ALView * redBox1 = [[ALView alloc] init];
    redBox1.backgroundColor = [UIColor redColor];
    redBox1.height = 100;
    [redBox1 addTo:self.view];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
