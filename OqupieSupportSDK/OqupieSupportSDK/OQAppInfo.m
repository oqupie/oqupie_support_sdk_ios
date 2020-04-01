#import "OQAppInfo.h"

// 앱 정보를 담아서 전송하는 데이터 클래스
@implementation OQAppInfo

- (id)init
{
    self = [super init];
    if (self)
    {
        self.endPoint = @"";
        self.additionalInfo = [NSMutableDictionary new];
    }
    return self;
}

- (NSURLComponents*)toQueryString
{
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in self.additionalInfo) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:self.additionalInfo[key]]];
    }
    NSURLComponents *components = [NSURLComponents componentsWithString:self.endPoint];
    components.queryItems = queryItems;
    return components;
}

- (void)addInfo: (NSString*)value forKey: (NSString*)key
{
    [self.additionalInfo setValue: value forKey: key];
}

// QueryString을 Deserialize한다.
+ (OQAppInfo*)fromQueryString: (NSString*)queryString
{

    @try
    {
        OQAppInfo* appInfo = [OQAppInfo new];
        NSArray *urlComponents = [queryString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents)
        {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
            NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];

            [appInfo addInfo: value forKey: key];
        }
        
        return appInfo;
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception.reason);
        return nil;
    }
}

@end
