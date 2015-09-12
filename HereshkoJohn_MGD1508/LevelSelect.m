//
//  LevelSelect.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 9/12/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "LevelSelect.h"
#import "GameScene.h"
#import "Level2.h"
#import "MenuScene.h"

@implementation LevelSelect

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
        
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        titleLabel.zPosition = 1;
        titleLabel.fontSize = 40;
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.position = CGPointMake(screenWidth/2, screenHeight/2+200);
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [titleLabel setText:@"Level Select"];
        [self addChild:titleLabel];
        
        level1 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        level1.zPosition = 1;
        level1.fontSize = 20;
        level1.fontColor = [SKColor blackColor];
        level1.position = CGPointMake(screenWidth/2, screenHeight/2+70);
        level1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [level1 setText:@"Level 1"];
        [self addChild:level1];
        
        
        //label to describe method to restart
        level2 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        level2.zPosition = 1;
        level2.fontSize = 20;
        level2.fontColor = [SKColor blackColor];
        level2.position = CGPointMake(screenWidth/2, screenHeight/2-35);
        level2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [level2 setText:@"Level 2"];
        [self addChild:level2];
        
        returnToLevel = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        returnToLevel.zPosition = 1;
        returnToLevel.fontSize = 20;
        returnToLevel.fontColor = [SKColor blackColor];
        returnToLevel.position = CGPointMake(screenWidth/2, screenHeight/2-130);
        returnToLevel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [returnToLevel setText:@"Return to Level"];
        [self addChild:returnToLevel];
        
        returnToMenu = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        returnToMenu.zPosition = 1;
        returnToMenu.fontSize = 20;
        returnToMenu.fontColor = [SKColor blackColor];
        returnToMenu.position = CGPointMake(screenWidth/2, screenHeight/2-235);
        returnToMenu.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [returnToMenu setText:@"Return to Menu"];
        [self addChild:returnToMenu];
    }
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Retro_Mystic" ofType:@"m4a"]];
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
    
    //if Level 1 is touched
    if ([level1 containsPoint:location]) {
        [musicPlayer pause];
        SKScene *gameScene = [[GameScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:reveal];
        
    } else if ([level2 containsPoint:location])
        //if Level 2 is touched
    {
        SKScene *gameScene = [[Level2 alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:reveal];
    } else if ([returnToLevel containsPoint:location])
        //if return is touched
    {
        NSString *thisLevel = [[NSUserDefaults standardUserDefaults]valueForKey:@"level"];
        if ([thisLevel  isEqual: @"Level 1"]) {
            SKScene *gameScene = [[GameScene alloc] initWithSize:self.size];
            gameScene.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5];
            [self.view presentScene:gameScene transition:reveal];
        } else if ([thisLevel isEqual:@"Level 2"]) {
            SKScene *gameScene = [[Level2 alloc] initWithSize:self.size];
            gameScene.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5];
            [self.view presentScene:gameScene transition:reveal];
        }

    } else if ([returnToMenu containsPoint:location])
        //if Level 2 is touched
    {
        SKScene *gameScene = [[MenuScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:reveal];
    }
}


@end