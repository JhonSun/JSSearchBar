//
//  LYSearchBar.h
//  LYMail
//
//  Created by drision on 2016/10/31.
//  Copyright © 2016年 Drision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSearchBar : UISearchBar

@property (nonatomic, copy) void (^searchClickEvent)(NSString *searchKey);
@property (nonatomic, copy) void (^valueChangeEvent)(NSString *searchKey);
@property (nonatomic, copy) void (^searchCancelEvent)();

@end
