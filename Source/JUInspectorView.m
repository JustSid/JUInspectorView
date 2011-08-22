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

@interface JUInspectorViewHeader (JUInspectorViewHeaderPrivate)
@property (nonatomic, readonly) NSButton *disclosureTriangle;
@end

@interface JUInspectorView ()
@property (nonatomic, retain) JUInspectorViewContainer *container;
@end

@implementation JUInspectorView
@synthesize name, index, body, expanded, container;

- (void)expand
{
    if(!expanded)
    {
        expanded = YES;
        
        NSRect frame = [body bounds];
        frame.origin = [self frame].origin;
        frame.size.height += [header bounds].size.height;
        
        [body setHidden:NO];
        
        [self setFrame:frame];
        [header setState:NSOnState];
        [container arrangeViews];
    }
}

- (void)collapse
{
    if(expanded)
    {
        expanded = NO;
        
        NSRect frame;
        frame.origin = [self frame].origin;
        frame.size = [header frame].size;

        [body setHidden:YES];
        
        [self setFrame:frame];
        [header setState:NSOffState];
        [container arrangeViews];
    }
}

- (void)setExpanded:(BOOL)texpanded
{
    if(texpanded)
    {
        [self expand];
    }
    else
    {
        [self collapse];
    }
}

- (void)toggleExpandation
{
    [self setExpanded:!expanded];
}




- (void)setName:(NSString *)newName
{
    [name autorelease];
    name = [newName retain];
    
    [header setTitle:name];
}

- (void)setBody:(NSView *)pbody
{
    [body removeFromSuperview];
    [body autorelease];
    
    body = [pbody retain];
    
    if([body isFlipped])
    {
        NSRect bodyFrame = [body bounds];
        bodyFrame.origin.y = [header bounds].size.height + 1.0;
        
        [body setFrame:bodyFrame];
    }
    else
    {
        NSRect bodyFrame = [body bounds];
        bodyFrame.origin.y = -bodyFrame.size.height + [header bounds].size.height;
        
        [body setFrame:bodyFrame];
    }
    
    [self addSubview:body];
    
    expanded = !expanded;
    [self setExpanded:!expanded];
}

- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    
    NSRect bodyRect = [body frame];
    bodyRect.size.width = frameRect.size.width;
    [body setFrame:bodyRect];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"JUCollectionView \"%@\", expanded: %@", name, expanded ? @"YES" : @"NO"];
}


- (NSComparisonResult)compare:(JUInspectorView *)otherView
{
    if(otherView.index > index)
        return NSGreaterThanComparison;
    
    if(otherView.index < index)
        return NSLessThanComparison;
    
    return NSEqualToComparison;
}


- (BOOL)isFlipped
{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if(expanded)
    {
        [[header dashColor] set];
        
        NSRect dashRect = [self bounds];
        dashRect.origin.x -= 1.0;
        dashRect.size.width += 2.0;
        
        NSBezierPath *path = [NSBezierPath bezierPathWithRect:dashRect];
        [path setLineWidth:1.0];
        [path stroke];
    }
}

- (void)setupViews
{
    header = [[JUInspectorViewHeader alloc] initWithFrame:NSZeroRect];
    [header setAutoresizingMask:NSViewWidthSizable];
    [[header disclosureTriangle] setAction:@selector(toggleExpandation)];
    [[header disclosureTriangle] setTarget:self];
    
    [self addSubview:header];
    [self setExpanded:YES];
}

- (id)initWithFrame:(NSRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        [self setupViews];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super initWithCoder:decoder]))
    {
        [self setupViews];
    }
    
    return self;
}

- (void)dealloc
{
    [header release];
    [body release];
    [name release];
    
    [super dealloc];
}

@end
