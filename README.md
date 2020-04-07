# 오큐파이 포털파인더 iOS SDK

* 이 저장소에는 오큐파이 포털파인더를 사용하기 위한 iOS용 SDK 원본 소스와 빌드된 framework 파일이 포함돼있습니다. 
* 기존 오큐파이에서 제공하던 모바일 SDK 소스코드를 포털파인더를 사용할 수 있게 수정한 것입니다. 
* 본 소스코드는 Xcode 11.4에서 실행 및 테스트되었습니다.

## framework 추가 및 설정

### 1. framework 추가

- 저장소를 clone하거나 다운 받으신 후 `dist`폴더 아래 있는 `OqupieSupportSDK.framework`를 프로잭트에 추가합니다. 
- **Project Navigator**의 **General** 탭에서 **Embedded Binaries** 섹션을 찾아서 위에서 복사한 `OqupieSupportSDK.framework`를 추가합니다.
- **iOS Deployment Target**을 12.0 이상으로 설정합니다.

### 2. 권한 설정

웹뷰에서 파일 첨부 기능을 사용하기 위해서 Project Navigator의 Info 탭에서 다음 퍼미션 관련 사항을 추가합니다.

```
Privacy - Photo Library Usage Description
Privacy - Camera Usage Description
```
(주의: Value값을 빈값으로 두지 마시고 메시지를 입력하세요)

### 3. 포털파인더 연결

SDK를 연결하려는 모바일 앱의 1:1 문의, 고객센터 등의 고객지원 관련 버튼 클릭 시 아래의 코드가 실행될 수 있도록 내용을 추가합니다. 예제 코드는 샘플앱인 `PortalFinderExample`의 `PortalFinderExample/PortalFinderExample/ViewController.m`에 있습니다.

예제 코드
```objective-c
#import <OqupieSupportSDK/OqupieSupportSDK.h>

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
```
1. API를 사용할 소스 파일 상단에 다음 임포트 문을 추가합니다.
    ```objective-c
    #import <OqupieSupportSDK/OqupieSupportSDK.h>
    ```
1. OqupieManager 싱글턴 객체로 기본적인 디바이스 정보를 읽어올 수 있습니다.
    ```objective-c
    OQAppInfo* appInfo = [[OqupieManager sharedInstance] getAppInfo];
    ```
1. 포털파인더를 사용하기 위한 엑세스키, 시크릿키, 브랜드키와 더불어 엔드유저 정보 등 추가적인 정보를 입력할 수 있습니다.
    ```objective-c
    [appInfo addInfo: @"2190ffccd8dbb478" forKey: @"access_key"];
    [appInfo addInfo: @"dde1cc31a14524bf903b2b1e71a8afde" forKey: @"secret_key"];
    [appInfo addInfo: @"oqupie" forKey: @"userId"];
    [appInfo addInfo: @"Onion Pie" forKey: @"userName"];
    [appInfo addInfo: @"example@onionfive.io" forKey: @"userEmail"];
    [appInfo addInfo: @"ko" forKey: @"brand_key1"];
    [appInfo addInfo: @"goodgame" forKey: @"brand_key2"];
    [appInfo addInfo: @"asia" forKey: @"brand_key3"];
    [appInfo addInfo: @"VVIP" forKey: @"vipcode"];
    ```    
1. 액세스키와 시크릿키 및 브랜드키 설정은 [포털파인더 가이드](https://www.notion.so/onionfivecorp/2d67a57c22074cfd9e1d2d68f1a3e84d)에서 다시 확인할 수 있습니다.
    ```objective-c
    [appInfo addInfo: @"2190ffccd8dbb478" forKey: @"access_key"];  // access_key는 필수 입니다.
    [appInfo addInfo: @"dde1cc31a14524bf903b2b1e71a8afde" forKey: @"secret_key"];  // secret_key는 필수 입니다.

    // brand_key1, 2, 3은 포털파인더 설정에 따라 입력해주세요. brand_key1은 필수이지만 나머지는 필수가 아닐 수도 있습니다.
    [appInfo addInfo: @"ko" forKey: @"brand_key1"];
    [appInfo addInfo: @"goodgame" forKey: @"brand_key2"];
    [appInfo addInfo: @"asia" forKey: @"brand_key3"];
    ```
1. 포털파인더 엔드포인트는 `https://{subdomain}.oqupie.com/portals/finder` 입니다. `{subdomain}`부분은 해당 계정의 서브도메인으로 변경하시면 됩니다. 
    ```objective-c
    // self.textFieldUrl.text 부분에 엔드포인트입력 
    [[OqupieManager sharedInstance] openWebView: self.textFieldUrl.text appInfo: appInfo showTitleBar: YES title: @"고객센터" color: color];
    ```
