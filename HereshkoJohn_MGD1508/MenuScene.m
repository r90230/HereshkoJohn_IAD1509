//
//  MenuScene.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/26/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "MenuScene.h"
#import "Level1.h"
#import "LearningScene.h"
#import "LevelSelect.h"
#import "CharacterSelect.h"
#import <GameKit/GameKit.h>

@implementation MenuScene

-(id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self authenticateLocalPlayer];
        int screenWidth = [UIScreen mainScreen].bounds.size.width;
        int screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        //create ending labels
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass.png"];
        background.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [self addChild:background];
        //score label
        
        titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        titleLabel.zPosition = 1;
        titleLabel.fontSize = 40;
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.position = CGPointMake(screenWidth/2, screenHeight/2+200);
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [titleLabel setText:@"Kenney's Trip"];
        [self addChild:titleLabel];
        
        playButton = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        playButton.zPosition = 1;
        playButton.fontSize = 25;
        playButton.fontColor = [SKColor blackColor];
        playButton.position = CGPointMake(screenWidth/2, screenHeight/2+50);
        playButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [playButton setText:@"Play Game"];
        [self addChild:playButton];
        
        
        //label to describe method to restart
        learningButton = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        learningButton.zPosition = 1;
        learningButton.fontSize = 25;
        learningButton.fontColor = [SKColor blackColor];
        learningButton.position = CGPointMake(screenWidth/2, screenHeight/2-75);
        learningButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [learningButton setText:@"Learn to Play"];
        [self addChild:learningButton];
        
        selectButton = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        selectButton.zPosition = 1;
        selectButton.fontSize = 25;
        selectButton.fontColor = [SKColor blackColor];
        selectButton.position = CGPointMake(screenWidth/2, screenHeight/2-200);
        selectButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [selectButton setText:@"Level Select"];
        [self addChild:selectButton];
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
        
    //if Play Game is touched
    if ([playButton containsPoint:location]) {
        [musicPlayer pause];
        SKScene *gameScene = [[Level1 alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:reveal];
            
    } else if ([selectButton containsPoint:location])
        //if Level Select is touched
    {
        SKScene *gameScene = [[LevelSelect alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:reveal];
    } else if ([learningButton containsPoint:location])
        //if Instructions is touched
    {
        SKScene *gameScene = [[LearningScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:reveal];
    } else if ([titleLabel containsPoint:location])
    {
        SKScene *gameScene = [[CharacterSelect alloc] initWithSize:[UIScreen mainScreen].bounds.size];
        SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:reveal];
    }
}

-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                isGameCenterEnabled = YES;

            }
            
            else{
                isGameCenterEnabled = NO;
            }
        }
    };
}

-(void)presentViewController: (UIViewController*)viewController{
    
    [self.view.window.rootViewController presentViewController:viewController animated:YES completion:nil];
}


@end
