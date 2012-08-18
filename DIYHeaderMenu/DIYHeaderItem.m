//
//  DIYHeaderItem.m
//  DIYHeaderMenu
//
//  Created by Jonathan Beilin on 8/13/12.
//  Copyright (c) 2012 DIY. All rights reserved.
//

#import "DIYHeaderItem.h"
#import "DIYHeaderOptions.h"

#import "UIView+Noise.h"

@interface DIYHeaderItem ()

@end

@implementation DIYHeaderItem

@synthesize delegate = _delegate;
@synthesize noise = _noise;

@synthesize name = _name;
@synthesize icon = _icon;
@synthesize isSelected = _isSelected;
@synthesize isSelectable = _isSelectable;

#pragma mark - Init & Setup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _delegate = nil;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.autoresizesSubviews = true;
        _noise = nil;
        
        _shadingView = [[UIView alloc] initWithFrame:self.bounds];
        self.shadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.shadingView.backgroundColor = [UIColor blackColor];
        self.shadingView.userInteractionEnabled = false;
        self.shadingView.alpha = 0.0f;
        [self addSubview:self.shadingView];
        
        _isSelectable = true;
    }
    return self;
}

- (void)setName:(NSString *)name withIcon:(UIImage *)image withColor:(UIColor *)color
{    
    CGRect labelFrame = CGRectMake(2*ICONPADDING + ICONSIZE, ICONPADDING, self.frame.size.width, ICONSIZE);
    _name = [[UILabel alloc] initWithFrame:labelFrame];
    self.name.backgroundColor = [UIColor clearColor];
    self.name.textColor = [UIColor whiteColor];
    self.name.font = [UIFont fontWithName:FONT_FAMILY size:FONT_SIZE];
    self.name.text = name;
    [self addSubview:self.name];
    
    _icon = [[UIImageView alloc] initWithImage:image];
    self.icon.frame = CGRectMake(ICONPADDING, ICONPADDING, ICONSIZE, ICONSIZE);
    [self addSubview:self.icon];
        
    self.backgroundColor = color;
    [self refreshNoise];
}

#pragma mark - Drawing

- (void)refreshNoise
{
    if (self.noise != nil) {
        [self.noise removeFromSuperlayer];
    }
    self.noise = [self applyNoise];
}

- (void)depictSelected
{
    if (!self.isSelected) {
//        self.center = CGPointMake(self.center.x + 2.0f, self.center.y + 2.0f);
        self.shadingView.alpha = 0.5f;
        [self bringSubviewToFront:self.shadingView];
        self.isSelected = true;
    }
}

- (void)depictUnselected
{
    if (self.isSelected) {
//        self.center = CGPointMake(self.center.x - 2.0f, self.center.y - 2.0f);
        self.shadingView.alpha = 0.0f;
        self.isSelected = false;
    }
}

#pragma mark - Touching

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (!self.isSelectable)
        return;
    
    [self depictSelected];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

    if (!self.isSelectable)
        return;

    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        [self depictSelected];
    }
    else {
        [self depictUnselected];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if (!self.isSelectable)
        return;
    
    [self depictUnselected];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (!self.isSelectable)
        return;
    
    [self depictUnselected];
    
    // Call delegate if touch ended in view
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        [self.delegate diyMenuAction:self.name.text];
    }
}

#pragma mark - Dealloc

- (void)releaseObjects
{
    _delegate = nil;
    [_name release], _name = nil;
    [_icon release], _icon = nil;
    [_shadingView release], _shadingView = nil;
}

- (void)dealloc
{
    [self releaseObjects];
    [super dealloc];
}

@end
