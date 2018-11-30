//
//  ViewController.m
//  XXBSahpButtonDemo
//
//  Created by xiaobing5 on 2018/11/30.
//  Copyright © 2018 xiaobing5. All rights reserved.
//

#import "ViewController.h"
#import "XXBShapButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
}

- (void)initView {
    XXBShapButton *shapButton = [XXBShapButton buttonWithType:UIButtonTypeCustom];
    [shapButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    shapButton.frame = CGRectMake(10, 10, 200, 200);
    shapButton.backgroundColor = [UIColor redColor];
    [shapButton addTarget:self action:@selector(shapButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shapButton];
    
}

- (void)shapButtonDidClick:(XXBShapButton *)shapButton {
    NSLog(@"XXB | %s [Line %d] %@",__func__,__LINE__,[NSThread currentThread]);
}
@end
