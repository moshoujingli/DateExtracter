//
//  ViewController.m
//  DateExtracter
//
//  Created by BiXiaopeng on 15/3/16.
//  Copyright (c) 2015年 BiXiaopeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BNPDateExtracter getSystemLanguageType];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
