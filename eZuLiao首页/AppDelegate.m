
#import "AppDelegate.h"
#import "tabBarVC.h"
#import "LeadVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

//引导页
- (void)creatEdition {
    LeadVC *lead=[[LeadVC alloc]init];
    tabBarVC *root=[[tabBarVC alloc]init];
    //判断是否加载引导页
    _user=[NSUserDefaults standardUserDefaults];
    NSString *lastEdition=[_user objectForKey:@"edition"];
    
    NSDictionary *dic=[[NSBundle mainBundle]infoDictionary];
    NSString *str=dic[@"CFBundleShortVersionString"];
    //如果有新版就加载引导页
    if (lastEdition==nil) {
        self.window.rootViewController=lead;
    }else{
        self.window.rootViewController=root;
    }
    
    [_user setValue:str forKey:@"edition"];
    [_user synchronize];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    [self creatEdition];
    
    
   
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
