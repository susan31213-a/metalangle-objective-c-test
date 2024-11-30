#import "ViewController.h"
#import <MetalANGLE/GLES2/gl2.h>
#import <MetalANGLE/GLES2/gl2ext.h>

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface ViewController () {
}
@property (strong, nonatomic) MGLContext *context;

- (void)setupGL;
- (void)tearDownGL;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    /* OpenGL ES 2.0コンテキストを生成 */
    self.context = [[MGLContext alloc] initWithAPI:kMGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        DBGMSG(@"Failed to create ES context");
    }
    
    MGLKView *view = (MGLKView *)self.view;
    view.context = self.context;
    
    [self setupGL];
}

- (void)dealloc
{
    [self tearDownGL];
    
    if ([MGLContext currentContext] == self.context) {
        [MGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([MGLContext currentContext] == self.context) {
            [MGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
}

- (void)setupGL
{
    [MGLContext setCurrentContext:self.context];
}

- (void)tearDownGL
{
    [MGLContext setCurrentContext:self.context];
}

/* 今回は動かないので空。 */
- (void)update
{
}

/* 描画。GLKViewデリゲートのメソッド。 */
- (void)mglkView:(MGLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
}


@end

/* End Of File */
