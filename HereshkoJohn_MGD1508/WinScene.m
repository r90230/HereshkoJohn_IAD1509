//
//  WinScene.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/27/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "WinScene.h"
#import "GameScene.h"
#import "Level2.h"
#import "MenuScene.h"

@implementation WinScene

-(id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        int screenWidth = [UIScreen mainScreen].bounds.size.width;
        int screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        //create ending labels
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass.png"];
        background.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [self addChild:background];
        //score label
        SKLabelNode *endLabel = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        endLabel.fontSize = 12;
        endLabel.fontColor = [SKColor blackColor];
        endLabel.position = CGPointMake(screenWidth/2, screenHeight/2+100);
        endLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            [endLabel setText:@"Congratulations! You win!"];
            [self addChild:endLabel];
        
        
        //label to describe method to restart
        tryAgain = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        tryAgain.fontSize = 15;
        tryAgain.fontColor = [SKColor blackColor];
        tryAgain.position = CGPointMake(screenWidth/2, screenHeight/2-100);
        tryAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [tryAgain setText:@"Next Level!"];
        [self addChild:tryAgain];
        
        mainMenu = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        mainMenu.fontSize = 15;
        mainMenu.fontColor = [SKColor blackColor];
        mainMenu.position = CGPointMake(screenWidth/2, screenHeight/2-200);
        mainMenu.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [mainMenu setText:@"Return to Main Menu"];
        [self addChild:mainMenu];
    }
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Retro_Comedy" ofType:@"m4a"]];
    musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    musicPlayer.numberOfLoops = -1;
    [musicPlayer play];
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    //find out where touch is specifically
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //if Play Game is touched
    if ([tryAgain containsPoint:location]) {
        NSString *thisLevel = [[NSUserDefaults standardUserDefaults]valueForKey:@"level"];
        if ([thisLevel  isEqual: @"Level 1"]) {
            SKScene *gameScene = [[Level2 alloc] initWithSize:self.size];
            gameScene.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5];
            [self.view presentScene:gameScene transition:reveal];
        } else if ([thisLevel isEqual:@"Level 2"]) {
            SKScene *gameScene = [[Level2 alloc] initWithSize:self.size];
            gameScene.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5];
            [self.view presentScene:gameScene transition:reveal];
        }
        
        
    } else if ([mainMenu containsPoint:location])
        //if Credits is touched
    {
        SKScene *gameScene = [[MenuScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5];
        [self.view presentScene:gameScene transition:reveal];
    }

}



@end
