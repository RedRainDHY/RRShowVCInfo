//
//  ViewController.m
//  RRShowVCInfo
//
//  Created by RedRain on 2017/10/18.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "ViewController.h"
#import "RRChildViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startBtnClick:(id)sender {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[RRChildViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
    
}


@end
