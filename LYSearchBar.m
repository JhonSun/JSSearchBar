//
//  LYSearchBar.m
//  LYMail
//
//  Created by drision on 2016/10/31.
//  Copyright © 2016年 Drision. All rights reserved.
//

#import "LYSearchBar.h"

@interface LYSearchBar ()<UISearchBarDelegate>

@property (nonatomic, assign) BOOL hasCentredPlaceholder;//搜索图片位置，默认居中，设置no可以居左

@end

@implementation LYSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.hasCentredPlaceholder = NO;
        [self initCSS];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in [[self.subviews firstObject] subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.backgroundColor = [UIColor whiteColor];
            textField.tintColor = [UIColor blackColor];
            textField.borderStyle = UITextBorderStyleNone;
            textField.layer.cornerRadius = textField.frame.size.height / 2;
            textField.layer.masksToBounds = YES;
            textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
            textField.leftViewMode = UITextFieldViewModeAlways;
        }
    }
}

#pragma mark - set
- (void)setHasCentredPlaceholder:(BOOL)hasCentredPlaceholder {
    _hasCentredPlaceholder = hasCentredPlaceholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&_hasCentredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - pirvate
- (void)initCSS {
    [[[self.subviews firstObject].subviews firstObject] removeFromSuperview];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    UIView *view = [searchBar.subviews firstObject];
    for(id cc in view.subviews) {
        if([cc isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    if (self.searchCancelEvent) self.searchCancelEvent();
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.valueChangeEvent) self.valueChangeEvent(searchBar.text);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    if (self.searchClickEvent) self.searchClickEvent(searchBar.text);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
