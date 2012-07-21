#import "Kiwi.h"

#import "BWObjectRouter.h"
#import "User.h"
#import "Post.h"

SPEC_BEGIN(BWObjectRouterSpecs)

describe(@"when ", ^{
    __block User *user;
    __block Post *post;
    
    beforeAll(^{
        user = [[User alloc] init];
        user.userID = [NSNumber numberWithInt:1];
        
        post = [[Post alloc] init];
        post.user = user;
        post.postID = [NSNumber numberWithInt:222];
        
        [[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users" forMethod:BWObjectRouterMethodINDEX];
        [[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users/:userID" forMethod:BWObjectRouterMethodAllExceptPOST];
        [[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users" forMethod:BWObjectRouterMethodPOST];        
        
        [[BWObjectRouter shared] routeObjectClass:[Post class] toResourcePath:@"/users/:userID/posts" forMethod:BWObjectRouterMethodINDEX];
        [[BWObjectRouter shared] routeObjectClass:[Post class] toResourcePath:@"/users/:user.userID/posts/:postID" forMethod:BWObjectRouterMethodAllExceptPOST];
    });
    
    it(@"should be users index path", ^{
        NSString *value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodINDEX withObjectClass:[User class]];
        NSString *expected = [NSString stringWithFormat:@"/users"];
        [[value should] equal:expected];
        
        value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodINDEX withObject:user];
        [[value should] equal:expected];
    });
    
    it(@"should be users post path", ^{
        NSString *value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodPOST withObjectClass:[User class]];
        NSString *expected = [NSString stringWithFormat:@"/users"];
        [[value should] equal:expected];
        
        value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodPOST withObject:user];
        [[value should] equal:expected];
    });
    
    it(@"should be users get path", ^{
        NSString *value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodGET withObject:user];
        NSString *expected = [NSString stringWithFormat:@"/users/%d", [user.userID intValue]];
        [[value should] equal:expected];        
    });
    
    it(@"should be users put path", ^{
        NSString *value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodPUT withObject:user];
        NSString *expected = [NSString stringWithFormat:@"/users/%d", [user.userID intValue]];
        [[value should] equal:expected];        
    });
    
    it(@"should be users delete path", ^{
        NSString *value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodDELETE withObject:user];
        NSString *expected = [NSString stringWithFormat:@"/users/%d", [user.userID intValue]];
        [[value should] equal:expected];        
    });
    
    it(@"should be posts delete path", ^{
        NSString *value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodDELETE withObject:post];
        NSString *expected = [NSString stringWithFormat:@"/users/%d/posts/%d", [user.userID intValue], [post.postID intValue]];
        [[value should] equal:expected];        
    });
    
    it(@"should be posts index path", ^{
        NSString *value = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodINDEX withObjectClass:[Post class] valueObject:user];
        NSString *expected = [NSString stringWithFormat:@"/users/%d/posts", [user.userID intValue]];
        [[value should] equal:expected];        
    });
    
});

SPEC_END