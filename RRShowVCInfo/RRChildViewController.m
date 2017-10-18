//
//  RRChildViewController.m
//  RRShowVCInfo
//
//  Created by RedRain on 2017/10/18.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "RRChildViewController.h"

@interface RRChildViewController ()

@end

@implementation RRChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)pushNextPage:(id)sender {
    
    [self.navigationController pushViewController:[RRChildViewController new] animated:YES];
    
}

@end
