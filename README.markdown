##Overview
JUInspectorView is a shameless copy of Xcode 4s inspector views. It draws a header with a title and then a custom NSView or NSView subclass as the body. There is a disclosure triangle to open/close the body views and everything is totally like in Xcode 4.

You can insert the JUInspectorViewContainer (the component which contains all the inspector views) into almost any other view hierarchy, although it makes more sense to add it into a NSScrollView which than can be put into whatever you want.

##Tips
If you add a "fullscreen" (read: inspector filling) table view or text view or whatever draws a border, make it borderless! It looks horrible, really.
You should also enable the automatic width autoresize mask flag for body views, setting the height flag has no effect.

##Todo
There are two things which I would like to add which are currently missing:
<br>1) In Xcode 4, clicking anywhere in the header toggles the inspector view 
<br>2) In Xcode 4, the containing scrollview hides its vertical scroller if its not needed.

##License
MIT. Do whatever you want with it.