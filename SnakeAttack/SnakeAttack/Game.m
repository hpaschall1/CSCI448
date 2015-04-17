//
//  Game.m
//  SnakeAttack
//
//  Created by Trevor Westphal on 4/16/15.
//  Copyright (c) 2015 Trevor Westphal. All rights reserved.
//

#import "Game.h"

const int MOVE_DISTANCE = 15;
const int START_X = 195;
const int START_Y = 195;

@interface Game ()
@property (strong, nonatomic) NSMutableArray *snakeBody;
@end

@implementation Game

@synthesize snakeBody;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    snakeX = MOVE_DISTANCE;
    snakeY = 0;
    
    snakeLength = 5;
    
    lastButtonPressed = nil;
    
    // Create the 5 starting blocks
    snakeBody = [[NSMutableArray alloc] init];
    
    for(int i=0; i < snakeLength; ++i){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(START_X - (i*MOVE_DISTANCE), START_Y, MOVE_DISTANCE, MOVE_DISTANCE)];
        imageView.backgroundColor = [UIColor redColor];
        [snakeBody addObject:[[UIImageView alloc] init]];
        [self.view addSubview:imageView];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self placeFoodRandomly];
}

-(void)placeFoodRandomly{
    // Randomly place a food
    int randX = arc4random() % 23;
    int randY = arc4random() % 23;
    
    foodPellet.frame = CGRectMake(randX*MOVE_DISTANCE + MOVE_DISTANCE, randY*MOVE_DISTANCE + MOVE_DISTANCE, MOVE_DISTANCE, MOVE_DISTANCE);
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)SnakeMoving
{
    // See if we ran into a food. If so, add 3 to length and randomly place a new one
    
    // Take the last place sprite in snakeBody and put it at the new front unless we ate a food. Then we count to three steps and make a new sprite for each step
    
    // See if we ran into a wall, game over
    
    // Run throught the entire thing, changing sprites and detecting collisions
    
    // Loss checking goes here probably
}

-(IBAction)DirectionalButtonPressed:(id)sender
{
    if(gameHasStarted == NO){
        
        gameHasStarted = YES;
        
        snakeMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(SnakeMoving) userInfo:nil repeats:YES];
        
        
    } else {
        
        if((sender == upButton && lastButtonPressed == downButton)
           || (sender == downButton && lastButtonPressed == upButton)
           || (sender == leftButton && lastButtonPressed == rightButton)
           || (sender == rightButton && lastButtonPressed == leftButton)){
            return;
        }
        
        
        if(sender == upButton){
            snakeX = 0;
            snakeY = -1 * MOVE_DISTANCE;
        } else if(sender == downButton){
            snakeX = 0;
            snakeY = MOVE_DISTANCE;
        } else if (sender == rightButton){
            snakeX = MOVE_DISTANCE;
            snakeY = 0;
        } else if (sender == leftButton){
            snakeX = -1 * MOVE_DISTANCE;
            snakeY = 0;
        }
    }
        
    lastButtonPressed = sender;
}

@end
