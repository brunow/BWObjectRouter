## BWObjectRouter

Small library that generate route with static or dynamic data.

BWObjectRouter is based on top of the great [SOCKit](https://github.com/jverkoey/sockit) library from [Jeff Verkoeyen](https://twitter.com/featherless) and inspired by [RestKit](https://github.com/RestKit/RestKit).

## Examples objects

	User *user = [[User alloc] init];
	user.userID = [NSNumber numberWithInt:1];
    
	Post *post = [[Post alloc] init];
	post.user = user;
	post.postID = [NSNumber numberWithInt:222];

## Routes

	[[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users" forMethod:BWObjectRouterMethodINDEX];
	[[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users/:userID" forMethod:BWObjectRouterMethodAllExceptPOST];
	[[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users/" forMethod:BWObjectRouterMethodPOST];
    
	[[BWObjectRouter shared] routeObjectClass:[Post class] toResourcePath:@"/users/:userID/posts" forMethod:BWObjectRouterMethodINDEX];
	[[BWObjectRouter shared] routeObjectClass:[Post class] toResourcePath:@"/users/:user.userID/posts/:postID" forMethod:BWObjectRouterMethodAllExceptPOST];

## Getting routes

	NSString *path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodINDEX withObjectClass:[User class]];

Result **/users**

	NSString *path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodPUT withObject:user];

Result **/users/1**

	NSString *path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodINDEX withObjectClass:[Post class] valueObject:user];

Result **/users/1/posts**

	NSString *path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodGET withObject:post];

Result **/users/1/posts/222**

## Installation

**Copy BWObjectRouter dir** into your **project**. Because BWObjectRouter depend on **SOCKit** you must **install** it to. So **copy** the **SOCKit** dir to your Xcode project and add **-fno-objc-arc** flag to disable arc for SOCKit.

Or with **Cocoapods**

	pod 'BWObjectRouter', :git => "https://github.com/brunow/BWObjectRouter.git", :tag => "0.1.1"

## ARC

BWObjectRouter is ARC only.

## Contact

Bruno Wernimont

- Twitter - [@brunowernimont](http://twitter.com/brunowernimont)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/brunow/bwobjectrouter/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

