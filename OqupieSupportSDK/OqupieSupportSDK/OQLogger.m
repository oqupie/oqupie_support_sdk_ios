#import "OQLogger.h"

// 로거 클래스
@implementation OQLogger

+ (void)trace:(NSString *)message
{
    NSLog(@"%@", message);
}

@end
