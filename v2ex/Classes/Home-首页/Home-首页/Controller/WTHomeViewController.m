//
//  LBBHomeViewController.m
//  v2ex
//
//  Created by 无头骑士 GJ on 16/1/14.
//  Copyright © 2016年 无头骑士 GJ. All rights reserved.
//  首页控制器

#import "WTHomeViewController.h"
#import "WTTopicDetailViewController.h"
#import "WTGoogleSearchController.h"
#import "WTPublishTopicViewController.h"

#import "WTURLConst.h"
#import "UIBarButtonItem+Extension.h"
#import "UIViewController+Extension.h"

#import "MJExtension.h"

@interface WTHomeViewController ()  
/** WTNode数组*/
@property (nonatomic, strong) NSArray<WTNode *>             *nodes;
@end

@implementation WTHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化导航栏
    [self setupNav];
    
    // 添加子控制器
    [self setupAllChildViewControllers];
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(UITableViewBackgroundColor);
    
    
    
    // 设置导航栏的View
//    [self setTempNavImageView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [self.navigationController setNavigationBarHidden: YES animated: YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden: NO animated: YES];
}

#pragma mark - Lazy method
#pragma mark nodes
- (NSArray<WTNode *> *)nodes
{
    if (_nodes == nil)
    {
        _nodes = [WTNode mj_objectArrayWithFilename: @"nodes.plist"];
    }
    return _nodes;
}

#pragma mark - 初始化导航栏
- (void)setupNav
{
    self.navigationItem.title = @"v2ex";

    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem setupBarButtonItemWithImage: [UIImage imageNamed: @"nav_search"] frame: CGRectMake(0, 0, 20, 20) addTarget: self action: @selector(leftBarButtonItemClick)];
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem setupBarButtonItemWithImage: [UIImage imageNamed: @"nav_write"] frame: CGRectMake(0, 0, 20, 20) addTarget: self action: @selector(rightBarButtonItemClick)];
}

#pragma mark 添加子控制器
- (void)setupAllChildViewControllers
{
    for (WTNode *node in self.nodes)
    {
        WTTopicViewController *topicVC = [WTTopicViewController new];
        topicVC.title = node.name;
        topicVC.urlString = [WTHTTPBaseUrl stringByAppendingString: node.nodeURL];
        [self addChildViewController: topicVC];
    }
}

#pragma mark - 事件
- (void)leftBarButtonItemClick
{
    [self presentViewController: [WTGoogleSearchController new] animated: YES completion: nil];
}

- (void)rightBarButtonItemClick
{
    
    
    [self presentViewController: [WTPublishTopicViewController new] animated: YES completion: nil];
}

@end

