//
//  AppDelegate.m
//  Todo
//
//  Created by Adnan Joraid on 2022-06-19.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = UIWindow.new;
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:ViewController.new];
    
    return YES;
}

@end
