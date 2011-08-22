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

- (void)updateBounds
{
    CGFloat height = 0.0;
    for(JUInspectorView *view in inspectorViews)
    {
        height += [view frame].size.height;
    }
    
    NSRect frame;
    frame.origin = [self frame].origin;
    frame.size.width  = [self bounds].size.width;
    frame.size.height = height;
    
    NSClipView *clipView = [[self enclosingScrollView] contentView];
    if(clipView)
    {
        frame.size.width = [clipView documentRect].size.width;
    }
    
    [super setFrame:frame];
}

- (void)arrangeViews
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [inspectorViews sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [self updateBounds];
    
    
    BOOL collapsed = NO;
    NSRect frame = NSMakeRect(0.0, 0.0, [self bounds].size.width, 0.0);
    
    for(JUInspectorView *view in inspectorViews)
    {
        if(collapsed)
            frame.origin.y -= 1.0;
        
        frame.size.height = [view frame].size.height;
        
        [view setFrame:frame];
        
        frame.origin.y += frame.size.height;        
        collapsed = ![view isExpanded];
    }
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

- (void)addInspectorView:(JUInspectorView *)view atIndex:(NSInteger)index
{
    [view setIndex:index];
    [self addInspectorView:view];
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




- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    [self arrangeViews];
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

- (void)dealloc
{
    [inspectorViews release];
    [super dealloc];
}

@end
