#import "OQGLViewController.h"
#import <OpenGLES/ES3/gl.h>

@interface OQGLViewController ()

@end

// 네이티브 플러그인으로 사용할 경우 GPU정보를 읽어오기 위해 임시 생성하는 ViewController.
// 생성 즉시 바로 제거한다.
@implementation OQGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EAGLContext *context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES3];
    [EAGLContext setCurrentContext: context];
    self.graphicsDeviceName = [NSString stringWithFormat: @"%s", glGetString(GL_RENDERER)];
    self.graphicsShaderLevel = [NSString stringWithFormat: @"%s", glGetString(GL_VERSION)];
}

@end
