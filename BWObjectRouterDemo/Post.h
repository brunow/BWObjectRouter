//
//  Post.h
//  BWObjectRouterDemo
//
//  Created by Bruno Wernimont on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface Post : NSObject

@property (nonatomic, strong) NSNumber *postID;
@property (nonatomic, strong) User *user;

@end
