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

#define kSERVICE 3

////////////////////////////////////////////////////////////////////////////////////////////////////////

#define API_URL @"https://api.getchute.com/v1/"
#define SERVER_URL @"https://getchute.com"

////////////////////////////////////////////////////////////////////////////////////////////////////////

//#define kUDID               [[UIDevice currentDevice] uniqueIdentifier]
#define kDEVICE_NAME        [[UIDevice currentDevice] name]
#define kDEVICE_OS          [[UIDevice currentDevice] systemName]
#define kDEVICE_VERSION     [[UIDevice currentDevice] systemVersion]

/////////////
// FOR GROUPPIC
/////////////
//replace the following setting with your own client info
#define kOAuthCallbackURL               @"http://getchute.com/oauth/callback"
#define kOAuthCallbackRelativeURL       @"/oauth/callback"
#define kOAuthAppID                     @"50f5ad8b018d161441000802"
#define kOAuthAppSecret                 @"5bacbbcde02e3b30e20799e5c4cf28550cbaf048492bf11db902d7fed2aff9b7"
#define kOAuthToken                     @"57289627e33c1499ebaa55facd727a6f7504a713a1643a9fd8b3965a05546e32"

#define kOAuthPermissions               @"all_resources manage_resources profile resources"

#define kOAuthTokenURL                  @"https://getchute.com/oauth/access_token"