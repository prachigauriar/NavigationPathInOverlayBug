# NavigationPathBug

This repo demonstrates what seems to be a bug with SwiftUI’s `NavigationPath` and `NavigationStack`
in iOS 26 beta 5. Filed as FB19748977.


## Summary

If you have a single SwiftUI view that has two navigation stacks, one in the body of the main view,
and one in the body of an overlay, displaying the second appears to corrupt the navigation path of
the first.


## Steps to reproduce

  1. Launch the NavigationPathBug app
  2. Tap on the color names in the _Buttons_ or _Navigation Links_ section and observe that they
     work.
  3. Tap on the _Show Overlay_ button in the _Actions_ section.
  4. Close the overlay.
  5. Tap on the color names in the _Buttons_ section. Observe that they navigate, but the resulting
     view doesn’t display valid colors anymore.

     In the console, you can see that the navigation path isn’t removing values when the back button
     is pressed.
  6. Tap on the color names in the _Navigation Links_ section. Observe that they don’t work at all
     on iOS. On macOS, they exhibit the same behavior as the buttons in step 5.

## Notes

The issue occurs on iOS devices, in the Xcode Simulator, and on macOS 26 beta 6.
