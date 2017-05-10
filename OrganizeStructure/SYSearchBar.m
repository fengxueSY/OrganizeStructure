//
//  SYSearchBar.m
//  OrganizeStructure
//
//  Created by 666gps on 2017/5/5.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import "SYSearchBar.h"

@implementation SYSearchBar{
    UITextField * textField;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        for (UIView * subView in self.subviews)
        {
            NSLog(@"找到了这个人button");
            if ([subView isEqual:[UIButton class]]) {
                NSLog(@"找到了这个人button");
            }
            if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                NSLog(@"找到了这个人button");
            }

            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subView removeFromSuperview];
            }
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                textField = (UITextField *)subView;
                [textField setBorderStyle:UITextBorderStyleNone];
                textField.background = nil;
                textField.frame = CGRectMake(8, 8, [UIScreen mainScreen].bounds.size.width - 2* 8,[UIScreen mainScreen].bounds.size.height - 2* 8);
                textField.layer.cornerRadius = 6;
                textField.clipsToBounds = YES;
                textField.backgroundColor = [UIColor redColor];;
                self.backgroundColor = [UIColor blackColor];
            }
            for (UIView *searchbuttons in self.subviews)
            {
                if ([searchbuttons isKindOfClass:[UIButton class]])
                {
                    UIButton * cancelButton = (UIButton*)searchbuttons;
                    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
                    break;
                }
            }
        }

    }
    return self;
}
@end
