//
//  JUInspectorView.h
//  JUInspectorView
//
//  Copyright (c) 2011 by Sidney Just
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
//  and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Cocoa/Cocoa.h>

@interface JUInspectorViewHeader : NSView
{    
@private
    NSButton *disclosureTriangle;
    NSTextField *nameField;
    
    NSColor *dashColor;
    NSColor *gradientStartColor;
    NSColor *gradientEndColor;
}

@property (nonatomic, retain) NSColor *dashColor;
@property (nonatomic, retain) NSColor *gradientStartColor;
@property (nonatomic, retain) NSColor *gradientEndColor;

- (void)setState:(NSInteger)state;
- (void)setTitle:(NSString *)title;

@end
