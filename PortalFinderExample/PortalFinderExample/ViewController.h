#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

- (BOOL)textFieldShouldBeginEditing: (UITextField*)textField;
- (BOOL)textFieldShouldReturn: (UITextField*)textField;

@end

