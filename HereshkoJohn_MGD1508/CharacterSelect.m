//
//  CharacterSelect.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 9/13/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "CharacterSelect.h"
#import "MenuScene.h"

@implementation CharacterSelect

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
        
        titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        titleLabel.zPosition = 1;
        titleLabel.fontSize = 35;
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.position = CGPointMake(screenWidth/2, screenHeight/2+200);
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [titleLabel setText:@"Character Select"];
        [self addChild:titleLabel];
        
        alienK = [SKSpriteNode spriteNodeWithImageNamed:@"alienBlue_front"];
        alienK.zPosition = 1;
        alienK.position = CGPointMake(screenWidth/2, screenHeight/2+50);
        alienK.xScale = .5;
        alienK.yScale = .5;
        [self addChild:alienK];
        
        alienSlime = [SKSpriteNode spriteNodeWithImageNamed:@"alien2_front"];
        alienSlime.zPosition = 1;
        alienSlime.position = CGPointMake(screenWidth/2, screenHeight/2-50);
        alienSlime.xScale = .6;
        alienSlime.yScale = .6;
        NSString *challengeDone = [[NSUserDefaults standardUserDefaults]valueForKey:@"challenge"];
        if ([challengeDone  isEqual: @"Complete2"]) {
            alienSlime.hidden = NO;
        } else {
            alienSlime.hidden = YES;
        }
        [self addChild:alienSlime];
        
        returnButton = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        returnButton.zPosition = 1;
        returnButton.fontSize = 25;
        returnButton.fontColor = [SKColor blackColor];
        returnButton.position = CGPointMake(screenWidth/2, screenHeight/2-200);
        returnButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [returnButton setText:@"Return to Menu"];
        [self addChild:returnButton];
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
    if ([alienK containsPoint:location]) {
        NSString *alienPicked = @"alienK";
        [[NSUserDefaults standardUserDefaults]setObject:alienPicked forKey:@"alienPicked"];

    } else if ([alienSlime containsPoint:location])
        //if Instructions is touched
    {
        NSString *alienPicked = @"alienSlime";
        [[NSUserDefaults standardUserDefaults]setObject:alienPicked forKey:@"alienPicked"];
    }
    SKScene *gameScene = [[MenuScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:gameScene transition:reveal];
}

@end
