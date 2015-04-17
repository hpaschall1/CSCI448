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

int foodCollected;

int snakeLength;

bool gameHasStarted;
bool gameHasEnded;

@interface Game : UIViewController <UIAlertViewDelegate>
{
    IBOutlet UIButton *upButton;
    IBOutlet UIButton *downButton;
    IBOutlet UIButton *rightButton;
    IBOutlet UIButton *leftButton;
    
    UIButton *lastButtonPressed;
    
    IBOutlet UIImageView *foodPellet;
    
    NSTimer *snakeMovementTimer;
}

-(void)SnakeMoving;
-(IBAction)DirectionalButtonPressed:(id)sender;

@end
