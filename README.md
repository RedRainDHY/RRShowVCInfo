### 1.背景
调试时, 往往需要确认当前页面所在控制器(Controller), 一般可以通过打断点确认, 也可以使用Facebook提供的工具[Chisel](https://github.com/facebook/chisel) 在控制台打印vc的信息(利用pvc命令)信息. 但是这些需要xCode才可以, 不方便及时使用. 

### 2.诉求

如何通过简单的方式, 触发Action, 打印或显示VC的信息呢? 使用利用`摇一摇功能 显示当前导航控制器栈信息`

- 一般义务页面是不需要摇一摇功能的, 使用不会导致业务功能冲突. 
- 事件触发简单, 可以提取到控制器公共父类里,不会影响其他逻辑代码.


### 3.实施

只需要三个步骤完成上述的功能

- 1.收集控制器信息
- 2.实现摇一摇功能
- 3.在页面中显示


### 3.1 收集控制器信息

首先要拿到当前显示的控制器.

[GitHub可以找到](https://github.com/openshopio/openshop.io-ios/blob/444a9fa0259e4c1a900d039fffe7ed21c56dcea8/OpenShop/UIViewController%2BBFUtils.m)

- 第一步 拿到当前显示的控制器

```
+ (UIViewController *)findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

+ (UIViewController*)currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

```

- 第二步 当前控制器是不是嵌套在导航控制器当中, 打印下对应信息

```
+ (NSString *)controllerInferredString{
    NSMutableString *finalString = [NSMutableString string];
    if ([self currentViewController].navigationController) {
        for (UIViewController *vc in [self currentViewController].navigationController.viewControllers) {
            [finalString appendFormat:@"%@->\n",NSStringFromClass(vc.class)];
        }
    }else{
        [finalString appendFormat:@"%@->\n",NSStringFromClass(self.class)];
    }
    return finalString;
}

```


### 3.2 实现摇一摇功能

摇一摇功能是iOS系统提供的功能, 可以快速实现


```
//ViewController 加入以下两方法

- (BOOL)canBecomeFirstResponder {
	
	//让当前controller可以成为firstResponder，这很重要
	return YES;

}

- (void)motionEnded:(UIEventSubtype)motionwithEvent:(UIEvent*)event {

    if(event.subtype==UIEventSubtypeMotionShake) {
      //做你想做的事

    }
}

```

在这个事件里, 获取对应控制器信息

```
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
    	 // 获取的到的信息
        NSString *vcInferred = [UIViewController controllerInferredString];
        
        // 在控制台打印
        NSLog(@"\n%@",vcInferred);
    }
}

```

### 3.3 在页面中显示
[利用Toast显示到页面中, https://github.com/scalessec/Toast](https://github.com/scalessec/Toast)

```

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{    
    if (self.navigationController.topViewController != self) {
        return;
    }
    
    if (event.subtype==UIEventSubtypeMotionShake) {
    	 // 获取的到的信息
        NSString *vcInferred = [UIViewController controllerInferredString];
        
        // 在控制台打印
        NSLog(@"\n%@",vcInferred);
        
        // 显示到页面中
        [self.view makeToast:vcInferred];
    }
}

```
