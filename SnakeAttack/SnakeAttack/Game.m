//
//  Game.m
//  SnakeAttack
//
//  Created by Trevor Westphal on 4/16/15.
//  Copyright (c) 2015 Trevor Westphal. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)SnakeMoving
{
    
}

-(IBAction)DirectionalButtonPressed:(id)sender
{
    if(gameHasStarted == NO){
        
        gameHasStarted = YES;
        
        snakeMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(SnakeMoving) userInfo:nil repeats:YES];
        
        
    } else {
        // Treat the buttons like directional buttons
    }
}

@end
