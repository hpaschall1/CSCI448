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

@synthesize snakeBody = _snakeBody;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    snakeX = MOVE_DISTANCE;
    snakeY = 0;
    
    lastButtonPressed = nil;
    
    // Create the 5 starting blocks
    _snakeBody = [[NSMutableArray alloc] init];
    snakeLength = 5;
    
    for(int i=0; i < snakeLength; ++i){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(START_X - (i * MOVE_DISTANCE), START_Y, MOVE_DISTANCE, MOVE_DISTANCE)];
        imageView.backgroundColor = [UIColor redColor];
        [_snakeBody addObject:imageView];
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
    
    UIImageView *oldHead = (UIImageView*)[_snakeBody objectAtIndex:0];
    
    // See if we ran into a food. If so, add 3 to length and randomly place a new one
    if(CGPointEqualToPoint(oldHead.center, foodPellet.center)){
        snakeLength += 3;
        [self placeFoodRandomly];
    }
    
    // Take the last place sprite in snakeBody and put it at the new front unless we ate a food.
//    head.center = CGPointMake(head.center.x + snakeX, head.center.y + snakeY);
    if([_snakeBody count] < snakeLength){
        // Create a new head, place it at the front
        UIImageView *newHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MOVE_DISTANCE, MOVE_DISTANCE)];
        newHead.center = CGPointMake(oldHead.center.x + snakeX, oldHead.center.y + snakeY);
        newHead.backgroundColor = [UIColor redColor];
        [_snakeBody insertObject:newHead atIndex:0];
        [self.view addSubview:newHead];
    } else {
        // Put the tail at the new head
        UIImageView *newHead;
        newHead = [_snakeBody lastObject];
        [_snakeBody removeLastObject];
        newHead.center = CGPointMake(oldHead.center.x + snakeX, oldHead.center.y + snakeY);
        [_snakeBody insertObject:newHead atIndex:0];
    }

    
    // See if we ran into a wall, game over
    
    // Run throught the entire thing, changing sprites and detecting collisions
    
    // Loss checking goes here probably
}

-(void)gameOver{
    NSLog(@"GAME OVER...");
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
