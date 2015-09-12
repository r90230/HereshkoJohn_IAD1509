//
//  LearningScene.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/26/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "LearningScene.h"
#import "MenuScene.h"

@implementation LearningScene

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
        
        SKLabelNode *learnLabel1 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        learnLabel1.fontSize = 12;
        learnLabel1.fontColor = [SKColor blackColor];
        learnLabel1.position = CGPointMake(screenWidth/2, screenHeight/2+150);
        learnLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [learnLabel1 setText:@"Hold left or right to move."];
        learnLabel1.zPosition = 1;
        [self addChild:learnLabel1];
        
        
        //label to describe method to restart
        SKLabelNode *learnLabel2 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        learnLabel2.fontSize = 12;
        learnLabel2.fontColor = [SKColor blackColor];
        learnLabel2.position = CGPointMake(screenWidth/2, screenHeight/2+50);
        learnLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [learnLabel2 setText:@"Tap Bottom of the Screen"];
        learnLabel2.zPosition = 1;
        [self addChild:learnLabel2];
        
        SKLabelNode *learnLabel3 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        learnLabel3.fontSize = 12;
        learnLabel3.fontColor = [SKColor blackColor];
        learnLabel3.position = CGPointMake(screenWidth/2, screenHeight/2+10);
        learnLabel3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [learnLabel3 setText:@"to jump."];
        learnLabel3.zPosition = 1;
        [self addChild:learnLabel3];
        
        SKLabelNode *learnLabel4 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        learnLabel4.fontSize = 12;
        learnLabel4.fontColor = [SKColor blackColor];
        learnLabel4.position = CGPointMake(screenWidth/2-30, screenHeight/2-70);
        learnLabel4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [learnLabel4 setText:@"Grab the"];
        learnLabel4.zPosition = 1;
        [self addChild:learnLabel4];
        
        SKLabelNode *learnLabel5 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        learnLabel5.fontSize = 12;
        learnLabel5.fontColor = [SKColor blackColor];
        learnLabel5.position = CGPointMake(screenWidth/2, screenHeight/2-110);
        learnLabel5.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [learnLabel5 setText:@"and get to the goal!"];
        learnLabel5.zPosition = 1;
        [self addChild:learnLabel5];
        
        SKSpriteNode *key = [SKSpriteNode spriteNodeWithImageNamed:@"keyBlue.png"];
        key.xScale = .5;
        key.yScale = .5;
        key.position = CGPointMake(screenWidth/2+50, screenHeight/2-60);
        key.zPosition = 1;
        [self addChild:key];
        
        SKLabelNode *learnLabel6 = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        learnLabel6.fontSize = 12;
        learnLabel6.fontColor = [SKColor blackColor];
        learnLabel6.position = CGPointMake(screenWidth/2-30, screenHeight/2-170);
        learnLabel6.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [learnLabel6 setText:@"Pause with"];
        learnLabel6.zPosition = 1;
        [self addChild:learnLabel6];
        
        SKSpriteNode *pause = [SKSpriteNode spriteNodeWithImageNamed:@"hudPlayer_blue.png"];
        pause.xScale = .5;
        pause.yScale = .5;
        pause.position = CGPointMake(screenWidth/2+60, screenHeight/2-160);
        pause.zPosition = 1;
        [self addChild:pause];
        
        SKLabelNode *tapToReturn = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        tapToReturn.fontSize = 12;
        tapToReturn.fontColor = [SKColor blackColor];
        tapToReturn.position = CGPointMake(screenWidth/2, screenHeight/2-225);
        tapToReturn.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [tapToReturn setText:@"Tap to Return"];
        tapToReturn.zPosition = 1;
        [self addChild:tapToReturn];
    }
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Retro_Mystic" ofType:@"m4a"]];
    musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    musicPlayer.numberOfLoops = -1;
    [musicPlayer play];
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKScene *menuScene = [[MenuScene alloc] initWithSize:self.size];
    menuScene.scaleMode = SKSceneScaleModeAspectFill;
    SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:menuScene transition:reveal];
}


@end
