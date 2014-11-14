/*
 OLEContainerScrollView
 
 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

@import UIKit;

#import "OLEContainerScrollView+Swizzling.h"
#import "OLESwizzling.h"
#import "OLEContainerScrollView.h"
#import "OLEContainerScrollViewContentView.h"

void swizzleUICollectionViewLayoutFinalizeCollectionViewUpdates()
{
    Class classToSwizzle = [UICollectionViewLayout class];
    SEL selectorToSwizzle = @selector(finalizeCollectionViewUpdates);
    
    __block IMP originalIMP = NULL;
    originalIMP = OLEReplaceMethodWithBlock(classToSwizzle, selectorToSwizzle, ^(UICollectionViewLayout *_self) {
        // Call original implementation
        ((void ( *)(id, SEL))originalIMP)(_self, selectorToSwizzle);
        
        // Manually set the collection view's contentSize to its new size (after the updates have been performed) to cause
        // a relayout of all views in the container scroll view.
        // We do this to animate the resizing of the collection view and its adjacent views in the container scroll view
        // in sync with the cell update animations (finalizeCollectionViewUpdates is called inside the animation block).
        // If we don't do this, the collection view will set its new content size only after the cell update animations
        // have finished, which is too late for us.
        UICollectionView *collectionView = _self.collectionView;
        BOOL collectionViewIsInsideOLEContainerScrollView = [collectionView.superview isKindOfClass:[OLEContainerScrollViewContentView class]];
        if (collectionViewIsInsideOLEContainerScrollView) {
            collectionView.contentSize = _self.collectionViewContentSize;
        }
    });
}
