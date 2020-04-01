#import <UIKit/UIKit.h>
#import "OqupieManager.h"
#import "OqupieBridge.h"
#import "OQAppInfo.h"

// C 계열 게임 엔진 (Unity, Cocos2dx) 바인딩하기 위한 로직

// 웹뷰 열기
void oqupieOpenWebView(const char* url, const char* appInfoQueryString, bool showTitleBar, const char* title, int red, int green, int blue)
{
    NSString* url1 = [NSString stringWithUTF8String: url];
    
    OQAppInfo* appInfo = nil;
    NSString* appInfoQS1 = [NSString stringWithUTF8String: appInfoQueryString];
    appInfo = [OQAppInfo fromQueryString: appInfoQS1];
    
    NSString* title1 = nil;
    if(title)
        title1 = [NSString stringWithUTF8String: title];
    UIColor* color = [UIColor colorWithRed: (CGFloat)red / 255 green: (CGFloat)green / 255 blue: (CGFloat)blue / 255 alpha: 1];
    
    [[OqupieManager sharedInstance] openWebView: url1 appInfo: appInfo showTitleBar: showTitleBar title: title1 color: color];
}

