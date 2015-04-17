//
//  Game.h
//  SnakeAttack
//
//  Created by Trevor Westphal on 4/16/15.
//  Copyright (c) 2015 Trevor Westphal. All rights reserved.
//

#import <UIKit/UIKit.h>

int snakeX;
int snakeY;

bool gameHasStarted;

@interface Game : UIViewController
{
    IBOutlet UIImageView *snakeBlock1;
    IBOutlet UIButton *upButton;
    IBOutlet UIButton *downButton;
    IBOutlet UIButton *rightButton;
    IBOutlet UIButton *leftButton;
    
    UIButton *lastButtonPressed;
    
    NSTimer *snakeMovementTimer;
}

-(void)SnakeMoving;
-(IBAction)DirectionalButtonPressed:(id)sender;

@end
