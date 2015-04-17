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
    
    snakeX = 10;
    snakeY = 0;
    
    lastButtonPressed = nil;
}

-(void)SnakeMoving
{
    snakeBlock1.center = CGPointMake(snakeBlock1.center.x + snakeX, snakeBlock1.center.y + snakeY);
    
    // Loss checking goes here probably
}

-(IBAction)DirectionalButtonPressed:(id)sender
{
    if(gameHasStarted == NO){
        
        gameHasStarted = YES;
        
        snakeMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(SnakeMoving) userInfo:nil repeats:YES];
        
        
    } else {
        
        if((sender == upButton && lastButtonPressed == downButton)
           || (sender == downButton && lastButtonPressed == upButton)
           || (sender == leftButton && lastButtonPressed == rightButton)
           || (sender == rightButton && lastButtonPressed == leftButton)){
            return;
        }
        
        
        if(sender == upButton){
            snakeX = 0;
            snakeY = -10;
        } else if(sender == downButton){
            snakeX = 0;
            snakeY = 10;
        } else if (sender == rightButton){
            snakeX = 10;
            snakeY = 0;
        } else if (sender == leftButton){
            snakeX = -10;
            snakeY = 0;
        }
    }
        
    lastButtonPressed = sender;
}

@end
