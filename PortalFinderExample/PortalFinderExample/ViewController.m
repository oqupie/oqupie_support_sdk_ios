#import "ViewController.h"
#import <OqupieSupportSDK/OqupieSupportSDK.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField* textFieldUrl;
@property (strong, nonatomic) IBOutlet UISwitch* switchGpu;
@property (strong, nonatomic) IBOutlet UITextView* textViewResult;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textFieldUrl.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing: (UITextField*)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn: (UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)onOpenWebViewButtonClicked
{
    OQAppInfo* appInfo = [[OqupieManager sharedInstance] getAppInfo];
    [appInfo addInfo: @"234" forKey: @"userId"];
    [appInfo addInfo: @"홍길동" forKey: @"userName"];
    [appInfo addInfo: @"bbaram12@naver.com" forKey: @"userEmail"];
    [appInfo addInfo: @"5f945ba071e7e66f" forKey: @"access_key"];
    [appInfo addInfo: @"4267f442114f7efcf24a51c4a88e007b" forKey: @"secret_key"];
    [appInfo addInfo: @"a" forKey: @"brand_key1"];
    [appInfo addInfo: @"b" forKey: @"brand_key2"];
    [appInfo addInfo: @"iOS 네이티브" forKey: @"게임엔진"];
    UIColor* color = [UIColor colorWithRed: 127.0 / 255.0 green: 115.0 / 255.0 blue: 231.0 / 255.0 alpha: 1.0];
    
    [[OqupieManager sharedInstance] openWebView: self.textFieldUrl.text appInfo: appInfo showTitleBar: YES title: @"고객센터" color: color];
}

- (IBAction)onAppInfoButtonClicked
{
    OQAppInfo* appInfo = nil;
    
    appInfo = [[OqupieManager sharedInstance] getAppInfo];
    
    // appInfo.userId = @"1234";
    // appInfo.userName = @"홍길동";
    // appInfo.applicationLanguage = @"Korean";
    // appInfo.operatingSystem = @"IOS100";
    // [appInfo putExtra: @"iOS 네이티브" forKey: @"게임엔진"];
    self.textViewResult.text = @"";
}

@end
