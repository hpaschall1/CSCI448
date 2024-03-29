//
//  CalculatorBrain.h
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University.
//  All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
#import "ViewController.h"
#import "CalculatorBrain.h"

@interface GraphViewController () <GraphViewDataSource, UISplitViewControllerDelegate>

@property (nonatomic, weak) IBOutlet GraphView *graphView;

@end

@implementation GraphViewController

@synthesize program = _program;
@synthesize graphView = _graphView;
@synthesize description = _description;

- (IBAction)backWasPressed {
    // Returns to the former vc if iphone
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
	// Changed this from awakeFromNib - we aren't using a nib

	self.splitViewController.delegate = self;
	self.splitViewController.presentsWithGesture = NO;
    
    _description.text = _program;
    [_description needsUpdateConstraints];
    
    // run the program
    if([_program isEqualToString:@""] == NO){
        
        // Math
        
        // Incorrect usage of NSUserDefaults in iOS 8... But not like that matters to Aarti.
        // Retrieve the scale from storage
        float scale = [[NSUserDefaults standardUserDefaults]
                       floatForKey:@"scale"];
        
        // Retrieve the x axis origin from storage
        float xAxisOrigin = [[NSUserDefaults standardUserDefaults]
                             floatForKey:@"x"];
        
        float lower_bound = -1.0f * xAxisOrigin * scale;
        float upper_bound =  xAxisOrigin * scale;
        
        float distance = upper_bound - lower_bound;
        
        // Changed the dictionary to an array. Why it was a dictionary was beyond me.
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        int frame_size = self.view.frame.size.width;
        
        for(int i = 0; i < frame_size; ++i){
            
            float value = lower_bound + (float)i / (float)frame_size * distance;
            
            [arr addObject:[NSNumber numberWithFloat:value]];
        }
        
        NSMutableArray* values_to_graph = [CalculatorBrain runProgram:_program usingVariableValues:arr];
        
    }
}

- (float)YValueForXValue:(float)xValue inGraphView:(GraphView *)sender {
    // Useless function...
    return 0.0f;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

- (BOOL)splitViewController:(UISplitViewController *)svc 
	shouldHideViewController:(UIViewController *)vc 
				  inOrientation:(UIInterfaceOrientation)orientation {	
	
	// Hide the the master controller in portrait mode
	return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)refreshView {
	
	// Need a program to recall scale and axis origin
	if (! self.program) return;
	
	// Need a graph view to set initial scale and axis origin
	if (! self.graphView) return;

// Useless and Doesn't match project requirements
//	NSString *program = [CalculatorBrain descriptionOfProgram:self.program];
	
	// Retrieve the scale from storage
	float scale = [[NSUserDefaults standardUserDefaults]
						floatForKey:@"scale"];
	
	// Retrieve the x axis origin from storage
	float xAxisOrigin = [[NSUserDefaults standardUserDefaults] 
								floatForKey:@"x"];
	
	// Retrieve the y axis origin from storage
	float yAxisOrigin = [[NSUserDefaults standardUserDefaults]
								floatForKey:@"y"];
	
	// If we have scale in storage, then set this as the scale for the graph view
	if (scale) self.graphView.scale = scale;
	
	// If we have a value for the xAxisOrigin and yAxisOrigin then set it in the graph view
	if (xAxisOrigin && yAxisOrigin) {
		
		CGPoint axisOrigin;
		
		axisOrigin.x = xAxisOrigin;
		axisOrigin.y = yAxisOrigin;
		
		self.graphView.axisOrigin = axisOrigin;
	}
	
	// Refresh the graph View
	[self.graphView setNeedsDisplay];
	
}

- (void) setProgram:(id)program {
	
	_program = program;
	
	// We want to set the title of the controller if the program changes
	self.title = [NSString stringWithFormat:@"y = %@", 
					  [CalculatorBrain descriptionOfProgram:self.program]];
} 


- (void) setGraphView:(GraphView *)graphView {
	_graphView = graphView;
	self.graphView.dataSource = self;
	
	// enable pinch gesture in the GraphView using pinch: handler
	[self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] 
													  initWithTarget:self.graphView 
													  action:@selector(pinch:)]];
	
	// enable pan gesture in the GraphView using pan: handler
	[self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc]
													  initWithTarget:self.graphView
													  action:@selector(pan:)]];
	
	// enable triple tap gesture in the GraphView using tripleTap: handler	
	UITapGestureRecognizer *tapGestureRecognizer = 
	[[UITapGestureRecognizer alloc] initWithTarget:self.graphView 
														 action:@selector(tripleTap:)];	
	tapGestureRecognizer.numberOfTapsRequired = 3;
	[self.graphView addGestureRecognizer:tapGestureRecognizer];	
	
	// We want to update the graphView to set the starting values for the program. In iPad mode 
	// this method is called before a program is set, in which case we don't want to do anything
	[self refreshView];
}

- (void)sendProgram:(NSString *)program {
    _program = program;
}

- (IBAction)drawModeSwitched:(id)sender {
// TODO: for extra credit
}

- (void)storeScale:(float)scale ForGraphView:(GraphView *)sender {
	
	// Store the scale in user defaults
	[[NSUserDefaults standardUserDefaults] 
	 setFloat:scale forKey:[@"scale." stringByAppendingString:
									[CalculatorBrain descriptionOfProgram:self.program]]];	
	
	// Save the scale
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)storeAxisOriginX:(float)x andAxisOriginY:(float)y ForGraphView:(GraphView *)sender {
	
	
	NSString *program = [CalculatorBrain descriptionOfProgram:self.program];
	
	// Store the x axis origin in user defaults
	[[NSUserDefaults standardUserDefaults] setFloat:x 
														  forKey:[@"x." stringByAppendingString:program]];
	
	// Store the y axis origin in user defaults
	[[NSUserDefaults standardUserDefaults] setFloat:y 
														  forKey:[@"y." stringByAppendingString:program]];
	
	// Save the axis origin
	[[NSUserDefaults standardUserDefaults] synchronize];
	
}

- (void)viewDidUnload {
	
	[super viewDidUnload];
}


@end
