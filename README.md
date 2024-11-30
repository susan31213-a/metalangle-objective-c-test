# Overview
This is an example about using metalangle to replace a OpenGL ES2 Xcode iOS project into metal Xcode iOS project.

# Get Started
1. Run `sh setup.sh`.
2. Open `ios/HelloTriangle/HelloTriangle.xcodeproj`.
3. Build metalangle by choose the target `MetalANGLE`.
![スクリーンショット 2024-11-30 20 40 56](https://github.com/user-attachments/assets/7a3fc076-b465-43fd-9e0b-a1d8e0bdaa8f)
4. Build application by choose the target `HelloTriangle`.
![image](https://github.com/user-attachments/assets/404bbb9e-8d15-4570-b500-dc3d0df41d81)
5. You can see a red screen in simulator.
6. Make change like commit [`011a9b89a56234a5486c41046b1a2e1871029cc7`](https://github.com/susan31213-a/metalangle-objective-c-test/commit/011a9b89a56234a5486c41046b1a2e1871029cc7)
   - Link MetalANGLE.framework to the project.
   - Change OpenGL API to metalangle API. Here is a [table](https://github.com/kakashidinho/metalangle/blob/master/src/libANGLE/renderer/metal/DevSetup.md#porting-from-apples-eagl--glkit-to-mglkit) of equivalent classes.
   - Open the storyboard and remove the `GL View Controller` and add `View Controller` instead.
   - Set added View Controller's custom class name to `ViewController` and the view under View Controller class name to `MGLKView`.
7. Clean build folder and build Application again.
8. You can see a red screen in simulator that is same to step 5.
