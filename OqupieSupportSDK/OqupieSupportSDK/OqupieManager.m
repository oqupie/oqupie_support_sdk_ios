#import <UIKit/UIKit.h>
#import "OqupieManager.h"
#import "OQGLViewController.h"

@implementation OqupieManager

// 싱글톤 객체
+ (id)sharedInstance
{
    static OqupieManager* sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [OqupieManager new];
    });
    return sharedMyManager;
}

// 기본적인 디바이스 정보를 검색한다.
- (OQAppInfo*)getAppInfo
{
    OQAppInfo* appInfo = [OQAppInfo new];
    return appInfo;
}

// 앱 정보를 전송한 후 웹뷰를 띄운다.
- (void)openWebView: (NSString*)url appInfo: (OQAppInfo*)appInfo showTitleBar: (BOOL)showTitleBar title: (NSString*)title color: (UIColor*)color
{
    [self preOpenWebView: url appInfo: appInfo showTitleBar: showTitleBar title: title color: color];
}

// 앱 정보를 전송한 후 웹뷰를 띄운다. (GPU 검색 여부를 선택할 수 있다)
- (void)preOpenWebView: (NSString*)url appInfo: (OQAppInfo*)appInfo showTitleBar: (BOOL)showTitleBar title: (NSString*)title color: (UIColor*)color
{
    self.oqupieWebView = [OqupieWebView new];
    [self.oqupieWebView createWebView: url appInfo: appInfo showTitleBar: showTitleBar title: title color: color];
}

// 웹뷰를 닫는다
- (void)closeWebView
{
    if (self.oqupieWebView != nil)
        [self.oqupieWebView closeWebView];
}

@end
