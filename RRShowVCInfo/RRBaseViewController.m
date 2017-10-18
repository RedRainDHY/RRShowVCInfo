//
//  RRBaseViewController.m
//  RRShowVCInfo
//
//  Created by RedRain on 2017/10/18.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "RRBaseViewController.h"

@interface RRBaseViewController ()

@end

@implementation RRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)canBecomeFirstResponder
{
    //让当前controller可以成为firstResponder，这很重要
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (self.navigationController.topViewController != self) {
        return;
    }
    
    if (event.subtype==UIEventSubtypeMotionShake) {
        NSString *vcInferred = [RRBaseViewController controllerInferredString];
        
        NSLog(@"\n%@",vcInferred);

        [self.view makeToast:vcInferred];

    }
}

@end
