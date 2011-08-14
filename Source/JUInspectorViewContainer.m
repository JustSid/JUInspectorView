//
//  JUInspectorViewContainer.m
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

#import "JUInspectorViewContainer.h"
#import "JUInspectorView.h"

@interface JUInspectorView (JUInspectorViewPrivate)
@property (nonatomic, retain) JUInspectorViewContainer *container;
@end

@implementation JUInspectorViewContainer

- (void)arrangeViews
{
    NSRect frame;
    frame.origin.x = 0.0;
    frame.origin.y = 0.0;
    frame.size.width = [self bounds].size.width;
    
    for(NSView *view in inspectorViews)
    {
        frame.size.height = [view frame].size.height;
        
        [view setFrame:frame];
        
        frame.origin.y += frame.size.height;
    }
    
    frame.size.height = frame.origin.y;
    frame.origin = [self frame].origin;
    
    [self setFrame:frame];
}




- (void)addInspectorView:(JUInspectorView *)view
{
    if(![inspectorViews containsObject:view])
    {
        [view setContainer:self];
        
        [inspectorViews addObject:view];
        [self addSubview:view];
        [self arrangeViews];
    }
}

- (void)removeInspectorView:(JUInspectorView *)view
{
    if([inspectorViews containsObject:view])
    {
        [view setContainer:self];
        
        [inspectorViews removeObject:view];
        [view removeFromSuperview];
        [self arrangeViews];
    }
}



- (BOOL)isFlipped
{
    return YES;
}

- (void)setupView
{
    inspectorViews = [[NSMutableArray alloc] init];
}


- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super initWithCoder:decoder]))
    {
        [self setupView];
    }
    
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        [self setupView];
    }
    
    return self;
}

@end
