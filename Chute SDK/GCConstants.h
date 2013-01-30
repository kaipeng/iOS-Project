//
//  GCConstants.h
//
//  Copyright 2011 Chute Corporation. All rights reserved.
//

//////////////////////////////////////////////////////////
//                                                      //
//                   VERSION 1.0.8                      //
//                                                      //
//////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set which service is to be used
// 0 - Facebook
// 1 - Evernote
// 2 - Chute
// 3 - Twitter
// 4 - Foursquare

#define kSERVICE 0

////////////////////////////////////////////////////////////////////////////////////////////////////////

#define API_URL @"https://api.getchute.com/v1/"
#define SERVER_URL @"https://getchute.com"

////////////////////////////////////////////////////////////////////////////////////////////////////////

//#define kUDID               [[UIDevice currentDevice] uniqueIdentifier]
#define kDEVICE_NAME        [[UIDevice currentDevice] name]
#define kDEVICE_OS          [[UIDevice currentDevice] systemName]
#define kDEVICE_VERSION     [[UIDevice currentDevice] systemVersion]

/////////////
// FOR FamilyLeaf Account - Secrets on SlideChute
/////////////
//replace the following setting with your own client info
#define kOAuthCallbackURL               @"http://getchute.com/oauth/callback"
#define kOAuthCallbackRelativeURL       @"/oauth/callback"
#define kOAuthAppID                     @"510869818a9eb04b6b000194"
#define kOAuthAppSecret                 @"4741390829fa5452c0ff32b4f2d71c20979736f948247de6ee1c20a8d111fce3"
#define kOAuthToken                     @"79cf0a4579853c4d169345306e61f84f62e42e80e43752e514e062c35ccd2ad3"

#define kOAuthPermissions               @"all_resources manage_resources profile resources"

#define kOAuthTokenURL                  @"https://getchute.com/oauth/access_token"