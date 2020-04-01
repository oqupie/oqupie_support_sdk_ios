#import "OqupieWebView.h"
#import "OQGLViewController.h"

// 앱 정보를 검색하거나 웹뷰를 호출하는 매니저 클래스
@implementation OqupieWebView

// 웹뷰를 생성하여 루트 뷰에 붙이고, 앱 정보를 전송하면서 페이지를 로딩한다.
- (void)createWebView: (NSString*)url appInfo: (OQAppInfo*)appInfo showTitleBar: (BOOL)showTitleBar title: (NSString*)title color: (UIColor*)color
{
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat titleBarHeight = 0;
    
    if(showTitleBar)
        titleBarHeight = 48;
    
    UIView* topMostView = [OqupieWebView getTopMostViewController].view;
    CGRect rectTopMostView = topMostView.frame; // 상태바 표시 여부와 무관하게 전체 크기를 가져온다.
    
    // 웹뷰 생성
    CGRect rectWebView = CGRectMake(0, statusBarHeight + titleBarHeight, rectTopMostView.size.width, rectTopMostView.size.height - statusBarHeight - titleBarHeight);
    WKWebView* webView = [[WKWebView alloc] initWithFrame: rectWebView];
    [topMostView addSubview: webView];
    self.webView = webView;

    appInfo.endPoint = url;
    NSURLComponents* urlComponent = [appInfo toQueryString];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL: urlComponent.URL];
    // 안드로이드와의 일관성을 위해 그냥 application/x-www-form-urlencoded 로 보낸다. (안드로이드에서는 헤더 수정 불가)
    [urlRequest setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];

    [webView loadRequest: urlRequest];
    
    if(!showTitleBar)
        return;
    
    // 타이틀 바
    UIView* titleBar = [[UIView alloc] initWithFrame: CGRectMake(0, statusBarHeight, rectTopMostView.size.width, titleBarHeight)];
    [titleBar setBackgroundColor: color];
    [topMostView addSubview: titleBar];
    self.titleBar = titleBar;
    
    // 타이틀
    UILabel* labelTitle = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, rectTopMostView.size.width, titleBarHeight)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = UIColor.whiteColor;
    labelTitle.font = [labelTitle.font fontWithSize: 18];
    labelTitle.text = title;
    [titleBar addSubview: labelTitle];
    self.labelTitle = labelTitle;
    
    // 닫기 버튼
    UIImage* imageClose = [self loadImage: @"Images/ButtonClose" ofType: @"png"];
    UIImage* imageCloseScaled = [self resize: imageClose size: CGSizeMake(titleBarHeight, titleBarHeight)];
    UIButton* buttonClose = [UIButton new];
    buttonClose.frame = CGRectMake(rectTopMostView.size.width - titleBarHeight, 0, titleBarHeight, titleBarHeight);
    [buttonClose addTarget: self action: @selector(closeWebView) forControlEvents: UIControlEventTouchUpInside];
    [buttonClose setImage: imageCloseScaled forState: UIControlStateNormal];
    [titleBar addSubview: buttonClose];
    self.buttonClose = buttonClose;
    
    // 뒤로가기 버튼
    UIImage* imageBack = [self loadImage: @"Images/ButtonBack" ofType: @"png"];
    UIImage* imageBackScaled = [self resize: imageBack size: CGSizeMake(titleBarHeight, titleBarHeight)];
    UIButton* buttonBack = [UIButton new];
    buttonBack.frame = CGRectMake(0, 0, titleBarHeight, titleBarHeight);
    [buttonBack addTarget: self action: @selector(goBack) forControlEvents: UIControlEventTouchUpInside];
    [buttonBack setImage: imageBackScaled forState: UIControlStateNormal];
    [titleBar addSubview: buttonBack];
    self.buttonBack = buttonBack;
}

// 루트 뷰를 얻는다
+ (UIViewController*)getTopMostViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        
        //added this block of code for iOS 8 which puts a UITransitionView in between the UIWindow and the UILayoutContainerView
        if ([responder isEqual:window])
        {
            //this is a UITransitionView
            if ([[subView subviews] count])
            {
                UIView *subSubView = [subView subviews][0]; //this should be the UILayoutContainerView
                responder = [subSubView nextResponder];
            }
        }
        
        if([responder isKindOfClass:[UIViewController class]]) {
            return [OqupieWebView getTopMostViewController: (UIViewController *) responder];
        }
    }
    
    return window.rootViewController;
}

+ (UIViewController*)getTopMostViewController: (UIViewController*)controller
{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}


- (void)changeRotation: (BOOL)landscape
{
}

// 패키징된 버튼 이미지를 로딩한다.
- (UIImage*)loadImage: (NSString*)pathForResource ofType: (NSString*)ofType;
{
    NSBundle* frameworkBundle = [NSBundle bundleForClass:[self class]];
    NSString* imagePath = [frameworkBundle pathForResource: pathForResource ofType: ofType];
    return [UIImage imageWithContentsOfFile: imagePath];
}

// 이미지를 리사이즈한다.
- (UIImage*)resize: (UIImage*)sourceImage size: (CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, size.width, size.height), [sourceImage CGImage]);
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 웹뷰를 닫는다.
- (void)closeWebView
{
    if (self.titleBar != nil)
        [self.titleBar removeFromSuperview];
    
    if (self.webView != nil)
        [self.webView removeFromSuperview];
}

// 뒤로가기를 처리한다.
- (void)goBack
{
    if ([self.webView canGoBack])
        [self.webView goBack];
}

@end
