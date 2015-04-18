//
//  Game.m
//  SnakeAttack
//
//  Created by Trevor Westphal on 4/16/15.
//  Copyright (c) 2015 Trevor Westphal. All rights reserved.
//

#import "Game.h"

const int MOVE_DISTANCE = 37;
const int START_X = 185;
const int START_Y = 185;

@interface Game ()
@property (strong, nonatomic) NSMutableArray *snakeBody;
@end

@implementation Game

@synthesize snakeBody = _snakeBody;

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setupGame{
    snakeX = MOVE_DISTANCE;
    snakeY = 0;
    
    foodCollected = 0;
    
    lastButtonPressed = rightButton;
    
    gameHasStarted = NO;
    gameHasEnded = NO;
    
    snakeMovementTimer = nil;
    
    // Create the 5 starting blocks
    _snakeBody = [[NSMutableArray alloc] init];
    snakeLength = 3;
    
    for(int i=0; i < snakeLength; ++i){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(START_X - (i * MOVE_DISTANCE), START_Y, MOVE_DISTANCE, MOVE_DISTANCE)];
        imageView.backgroundColor = [UIColor clearColor];
        [_snakeBody addObject:imageView];
        [self.view addSubview:imageView];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self setupGame];
    [self fixSnakeBodySprites];
    [self placeFoodRandomly];
}

-(void)placeFoodRandomly{
    // Randomly place a food
    int randX = arc4random() % 8;
    int randY = arc4random() % 8;
    foodPellet.frame = CGRectMake(randX * MOVE_DISTANCE + MOVE_DISTANCE, randY * MOVE_DISTANCE + MOVE_DISTANCE, MOVE_DISTANCE, MOVE_DISTANCE);
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)SnakeMoving
{
    if(gameHasEnded || [_snakeBody count] == 0){
        return;
    }
    
    UIImageView *oldHead = (UIImageView*)[_snakeBody objectAtIndex:0];
    
    // See if we ran into a food. If so, add 3 to length and randomly place a new one
    if(CGPointEqualToPoint(oldHead.center, foodPellet.center)){
        snakeLength += 3;
        foodCollected++;
        [self placeFoodRandomly];
    }
    
    // Take the last place sprite in snakeBody and put it at the new front unless we ate a food.
    UIImageView *newHead;
    
    if([_snakeBody count] < snakeLength){
        // Create a new head, place it at the front
        newHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MOVE_DISTANCE, MOVE_DISTANCE)];
        newHead.center = CGPointMake(oldHead.center.x + snakeX, oldHead.center.y + snakeY);
        newHead.backgroundColor = [UIColor clearColor];
        [_snakeBody insertObject:newHead atIndex:0];
        [self.view addSubview:newHead];
    } else {
        // Put the tail at the new head
        newHead = [_snakeBody lastObject];
        [_snakeBody removeLastObject];
        newHead.center = CGPointMake(oldHead.center.x + snakeX, oldHead.center.y + snakeY);
        [_snakeBody insertObject:newHead atIndex:0];
    }

    // See if we ran into a wall, game over
    if(newHead.center.x < 37 || newHead.center.y < 37 || newHead.center.x > 338 || newHead.center.y > 338){
        [self gameOver];
    }
    
    // Run through the entire thing, changing sprites and detecting collisions
    if([self isThereACollision] == NO){
        // Fix the sprites
        [self fixSnakeBodySprites];
    } else {
        [self gameOver];
    }
}

-(void)fixSnakeBodySprites{
    // First, get the head pointing the right way
    UIImageView *snakeHead = (UIImageView*)[_snakeBody objectAtIndex:0];
    
    if(lastButtonPressed == upButton){
        [snakeHead setImage:[UIImage imageNamed:@"snake_head_up.png"]];
    } else if (lastButtonPressed == downButton){
        [snakeHead setImage:[UIImage imageNamed:@"snake_head_down.png"]];
    } else if (lastButtonPressed == leftButton){
        [snakeHead setImage:[UIImage imageNamed:@"snake_head_left.png"]];
    } else if (lastButtonPressed == rightButton){
        [snakeHead setImage:[UIImage imageNamed:@"snake_head_right.png"]];
    }
    
    UIImageView *previous;
    UIImageView *current;
    UIImageView *next;
    
    
    // Next, get the body sprites all set up
    for(int i = 1; i < [_snakeBody count] - 1; ++i){
        previous = [_snakeBody objectAtIndex:i-1];
        current = [_snakeBody objectAtIndex:i];
        next = [_snakeBody objectAtIndex:i+1];
        
        if(previous.center.y == current.center.y && current.center.y == next.center.y){
            [current setImage:[UIImage imageNamed:@"snake_body_horizontal.png"]];
        } else if (previous.center.x == current.center.x && current.center.x == next.center.x){
            [current setImage:[UIImage imageNamed:@"snake_body_vertical.png"]];
        } else {
            if((previous.center.x < current.center.x && current.center.y < next.center.y)
               || (previous.center.y > current.center.y && current.center.x > next.center.x)){
                [current setImage:[UIImage imageNamed:@"snake_body_left_down.png"]];
            } else if ((previous.center.x > current.center.x && current.center.y > next.center.y)
                       || (previous.center.y < current.center.y && current.center.x < next.center.x)){
                [current setImage:[UIImage imageNamed:@"snake_body_up_right.png"]];
            } else if ((previous.center.y < current.center.y && current.center.x > next.center.x)
                       || (previous.center.x < current.center.x && current.center.y > next.center.y)){
                [current setImage:[UIImage imageNamed:@"snake_body_up_left.png"]];
            } else {
                [current setImage:[UIImage imageNamed:@"snake_body_right_down.png"]];
            }
        }
    }
    
    // Finally, fix the tail
    if(current.center.x == next.center.x && current.center.y < next.center.y){
        [next setImage:[UIImage imageNamed:@"snake_tail_up.png"]];
    } else if (current.center.x == next.center.x && current.center.y > next.center.y){
        [next setImage:[UIImage imageNamed:@"snake_tail_down.png"]];
    } else if (current.center.y == next.center.y && current.center.x > next.center.x){
        [next setImage:[UIImage imageNamed:@"snake_tail_right.png"]];
    } else {
        [next setImage:[UIImage imageNamed:@"snake_tail_left.png"]];
    }
}

-(BOOL)isThereACollision{
    for(int i=0; i < [_snakeBody count]; ++i){
        for(int j=0; j < [_snakeBody count]; ++j){
            
            UIImageView *one = (UIImageView*)[_snakeBody objectAtIndex:i];
            UIImageView *two = (UIImageView*)[_snakeBody objectAtIndex:j];
            
            if(CGPointEqualToPoint(one.center, two.center) && i != j){
                return YES;
            }
        }
    }
    
    return NO;
}

-(void)gameOver{
    gameHasEnded = YES;
    snakeMovementTimer = nil;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've lost!" message:[NSString stringWithFormat:@"You collected %d pellets of food!", foodCollected] delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [_snakeBody removeAllObjects];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)DirectionalButtonPressed:(id)sender
{
    if(gameHasStarted == NO){
        
        gameHasStarted = YES;
        
        snakeMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(SnakeMoving) userInfo:nil repeats:YES];
        
        
    } else {
        
        lastButtonPressed = sender;
        
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
}

@end
