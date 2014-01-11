//
//  JUInspectoView.m
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

#import "JUInspectorView.h"

const CGFloat JUInspectorViewDashInset = 18.0;
const CGFloat JUInspectorViewContentInset = 36.0;

@implementation JUInspectorView

#pragma mark - Init/Dealloc

- (void)setupView
{
    self.dashColor = [NSColor lightGrayColor];

    self.header = [[JUInspectorViewHeader alloc] initWithFrame:NSZeroRect];
    [self.header setAutoresizingMask:NSViewWidthSizable];
    self.header.delegate=self;
    
    [self addSubview:self.header];
    [self setExpanded:YES];
}


#pragma mark - Properties

- (void)setExpanded:(BOOL)value
{
    if (_expanded==value)
        return;
    
    _expanded=value;
 
    NSRect frame;
    
    if (_expanded)
    {
        frame = [self.body bounds];
        frame.origin = [self frame].origin;
        frame.size.height += [self.header bounds].size.height;
        
        [self.body setHidden:NO];
        [self.header setState:NSOnState];
        [self.container arrangeViews];
    }
    else
    {
        frame.origin = [self frame].origin;
        frame.size = [self.header frame].size;
        
        [self.body setHidden:YES];
        [self.header setState:NSOffState];
    }
    
    [self setFrame:frame];
    [self.container arrangeViews];
}

-(NSString *)name
{
    return [self.header title];
}

- (void)setName:(NSString *)value
{
    [self.header setTitle:value];
}

- (void)setBody:(NSView *)pbody
{
    [_body removeFromSuperview];
    
    _body = pbody;
    
    if([_body isFlipped])
    {
        NSRect bodyFrame = [_body bounds];
        bodyFrame.origin.y = [self.header bounds].size.height + 1.0;
        
        [_body setFrame:bodyFrame];
    }
    else
    {
        NSRect bodyFrame = [_body bounds];
        bodyFrame.origin.y = -bodyFrame.size.height + [self.header bounds].size.height - 1.0;
        
        [_body setFrame:bodyFrame];
    }
    
    [self addSubview:_body];
    
    self.expanded = !self.expanded;
}

#pragma mark - NSView Overrides

- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    
    NSRect bodyRect = [self.body frame];
    bodyRect.origin.x = JUInspectorViewContentInset;
    bodyRect.size.width = frameRect.size.width - (JUInspectorViewContentInset * 2.0);
    [self.body setFrame:bodyRect];
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self.dashColor set];

    NSBezierPath *bottomOfFramePath = [NSBezierPath bezierPath];
    [bottomOfFramePath moveToPoint:CGPointMake(CGRectGetMinX(self.bounds) + JUInspectorViewDashInset, CGRectGetHeight(self.bounds))];
    [bottomOfFramePath lineToPoint:CGPointMake(CGRectGetMaxX(self.bounds) - JUInspectorViewDashInset, CGRectGetHeight(self.bounds))];

    [bottomOfFramePath setLineWidth:1.0];
    [bottomOfFramePath stroke];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"JUCollectionView \"%@\", expanded: %@", self.name, self.expanded ? @"YES" : @"NO"];
}

- (NSComparisonResult)compare:(JUInspectorView *)otherView
{
    if(otherView.index > self.index)
        return NSGreaterThanComparison;
    
    if(otherView.index < self.index)
        return NSLessThanComparison;
    
    return NSEqualToComparison;
}

#pragma mark - JUInspectorViewHeaderDelegate

-(void)headerClicked:(JUInspectorViewHeader *)headerView
{
    self.expanded=!self.expanded;
}


@end
