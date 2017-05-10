//
//  ViewController.m
//  OrganizeStructure
//
//  Created by 666gps on 2017/5/3.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import "ViewController.h"
#import "OrganizeController.h"
#import "SYSearchBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SYSearchBar * search  = [[SYSearchBar alloc]initWithFrame:CGRectMake(0, 100, 375, 50)];
    search.showsCancelButton = YES;
    [self.view addSubview:search];
}

- (IBAction)oranizeButton:(id)sender {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"organizeStructureTitleArray"];
    OrganizeController * organize = [[OrganizeController alloc]init];
    [self.navigationController pushViewController:organize animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
