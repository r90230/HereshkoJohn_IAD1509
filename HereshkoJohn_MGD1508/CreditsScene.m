//
//  CreditsScene.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/26/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "CreditsScene.h"
#import "MenuScene.h"

@implementation CreditsScene

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
        
        SKLabelNode *developerCredits = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        developerCredits.fontSize = 12;
        developerCredits.fontColor = [SKColor blackColor];
        developerCredits.position = CGPointMake(screenWidth/2, screenHeight/2+100);
        developerCredits.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [developerCredits setText:@"Developer: John Hereshko"];
        [self addChild:developerCredits];
        
        
        //label to describe method to restart
        SKLabelNode *artCredits = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        artCredits.fontSize = 12;
        artCredits.fontColor = [SKColor blackColor];
        artCredits.position = CGPointMake(screenWidth/2, screenHeight/2);
        artCredits.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [artCredits setText:@"Art: Kenney Game Assets"];
        [self addChild:artCredits];
        
        SKLabelNode *soundCredits = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        soundCredits.fontSize = 12;
        soundCredits.fontColor = [SKColor blackColor];
        soundCredits.position = CGPointMake(screenWidth/2, screenHeight/2-100);
        soundCredits.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [soundCredits setText:@"Music/Sound: Westar Music"];
        [self addChild:soundCredits];
        
        SKLabelNode *tapToReturn = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
        tapToReturn.fontSize = 12;
        tapToReturn.fontColor = [SKColor blackColor];
        tapToReturn.position = CGPointMake(screenWidth/2, screenHeight/2-200);
        tapToReturn.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [tapToReturn setText:@"Tap to Return"];
        [self addChild:tapToReturn];
        
    }
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
