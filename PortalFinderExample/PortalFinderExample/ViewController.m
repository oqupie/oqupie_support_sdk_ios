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
    [appInfo addInfo: @"2190ffccd8dbb478" forKey: @"access_key"];
    [appInfo addInfo: @"dde1cc31a14524bf903b2b1e71a8afde" forKey: @"secret_key"];
    [appInfo addInfo: @"oqupie" forKey: @"userId"];
    [appInfo addInfo: @"Onion Pie" forKey: @"userName"];
    [appInfo addInfo: @"example@onionfive.io" forKey: @"userEmail"];
    [appInfo addInfo: @"ko" forKey: @"brand_key1"];
    [appInfo addInfo: @"goodgame" forKey: @"brand_key2"];
    [appInfo addInfo: @"asia" forKey: @"brand_key3"];
    [appInfo addInfo: @"VVIP" forKey: @"vipcode"];
    UIColor* color = [UIColor colorWithRed: 127.0 / 255.0 green: 115.0 / 255.0 blue: 231.0 / 255.0 alpha: 1.0];
    
    [[OqupieManager sharedInstance] openWebView: self.textFieldUrl.text appInfo: appInfo showTitleBar: YES title: @"고객센터" color: color];
}

- (IBAction)onAppInfoButtonClicked
{
    OQAppInfo* appInfo = nil;
    
    appInfo = [[OqupieManager sharedInstance] getAppInfo];
    [appInfo addInfo: @"2190ffccd8dbb478" forKey: @"access_key"];
    [appInfo addInfo: @"dde1cc31a14524bf903b2b1e71a8afde" forKey: @"secret_key"];
    [appInfo addInfo: @"oqupie" forKey: @"userId"];
    [appInfo addInfo: @"Onion Pie" forKey: @"userName"];
    [appInfo addInfo: @"example@onionfive.io" forKey: @"userEmail"];
    [appInfo addInfo: @"ko" forKey: @"brand_key1"];
    [appInfo addInfo: @"goodgame" forKey: @"brand_key2"];
    [appInfo addInfo: @"asia" forKey: @"brand_key3"];
    [appInfo addInfo: @"VVIP" forKey: @"vipcode"];
    NSString* host = @"https://oqtest.oqupie.com/portals/finder";
    NSString* queryString = [[appInfo toQueryString] string];
    self.textViewResult.text = [NSString stringWithFormat:@"%@%@", host, queryString];
}

@end
