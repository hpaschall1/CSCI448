//
//  CalculatorBrain.h
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University.
//  All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;

@protocol GraphViewDataSource
- (float)YValueForXValue:(float)xValue inGraphView:(GraphView *)sender;
- (void)storeScale:(float)scale ForGraphView: (GraphView *)sender;
- (void)storeAxisOriginX:(float)x andAxisOriginY:(float)y ForGraphView: (GraphView *)sender;

@end

@interface GraphView : UIView

// No idea why this exists, or where the fuck it's supposed to be hooked up
@property(nonatomic, weak) IBOutlet id <GraphViewDataSource> dataSource;

@property(nonatomic) CGFloat scale;
@property(nonatomic) CGPoint axisOrigin;


@end
