#import "ViewController.h"
#import <MetalANGLE/GLES2/gl2.h>
#import <MetalANGLE/GLES2/gl2ext.h>

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

float vertices[] = {
    0.0,  0.5, 0.0,  // Top vertex
   -0.5, -0.5, 0.0,  // Bottom-left vertex
    0.5, -0.5, 0.0   // Bottom-right vertex
};

@interface ViewController () {
}
@property (strong, nonatomic) MGLContext *context;
@property (nonatomic) GLuint shaderProgram;

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
    view.drawableColorFormat = MGLDrawableColorFormatRGBA8888;

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

        glViewport(0, 0, 960, 1800);

        NSString *vertexShaderSource = @"attribute vec4 position;"
                                       "void main() {"
                                       "    gl_Position = position;"
                                       "}";

        NSString *fragmentShaderSource = @"void main() {"
                                         "    gl_FragColor = vec4(0.137, 0.412, 0.208, 1.0);"
                                         "}";

        self.shaderProgram = [self createProgramWithVertexShader:vertexShaderSource fragmentShader:fragmentShaderSource];
        glUseProgram(self.shaderProgram);

        // Set up vertex attributes
        GLuint positionAttribute = glGetAttribLocation(self.shaderProgram, "position");
        glEnableVertexAttribArray(positionAttribute);
        glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, GL_FALSE, 0, vertices);
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
}

- (GLuint)compileShader:(NSString *)shaderString withType:(GLenum)shaderType {
    GLuint shader = glCreateShader(shaderType);
    const char *shaderSource = [shaderString UTF8String];
    glShaderSource(shader, 1, &shaderSource, NULL);
    glCompileShader(shader);

    GLint compileSuccess;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shader, sizeof(messages), NULL, messages);
        NSLog(@"Shader compile error: %s", messages);
        exit(1);
    }

    return shader;
}

- (GLuint)createProgramWithVertexShader:(NSString *)vertexShaderString fragmentShader:(NSString *)fragmentShaderString {
    GLuint vertexShader = [self compileShader:vertexShaderString withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:fragmentShaderString withType:GL_FRAGMENT_SHADER];

    GLuint program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);

    GLint linkSuccess;
    glGetProgramiv(program, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(program, sizeof(messages), NULL, messages);
        NSLog(@"Program link error: %s", messages);
        exit(1);
    }

    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    return program;
}

- (void)mglkView:(MGLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0, 1.0, 1.0, 1.0); // Black background
    glClear(GL_COLOR_BUFFER_BIT);

    glDrawArrays(GL_TRIANGLES, 0, 3); // Draw the triangle
    GLenum error = glGetError();
    if (error != GL_NO_ERROR) {
        NSLog(@"OpenGL error: %x", error);
    }
}


@end

