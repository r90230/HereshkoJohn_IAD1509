//
//  Level2.h
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 9/10/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "EndScene.h"

@interface Level2 : SKScene <SKPhysicsContactDelegate>
{
    SKSpriteNode *player;
    SKSpriteNode *enemy;
    SKSpriteNode *coin;
    SKSpriteNode *coin2;
    SKSpriteNode *coin3;
    SKSpriteNode *coin4;
    SKSpriteNode *coin5;
    SKSpriteNode *coin6;
    SKSpriteNode *coin7;
    NSArray *walkTextures;
    NSArray *enemyTextures;
    SKNode *worldNode;
    BOOL isRunningRight;
    BOOL isRunningLeft;
    BOOL isJumping;
    SKAction *walkAnimationLoop;
    SKAction *flipPlayer;
    SKAction *leftAnimationLoop;
    BOOL flipped;
    SKAction *jump;
    BOOL isTouchingPlatform;
    SKAction *soundEffect;
    SKAction *enemyMovement;
    SKAction *hitAction;
    SKNode *HUDNode;
    SKAction *reduceHeart;
    SKAction *emptyHeart;
    SKSpriteNode *heart1;
    SKSpriteNode *heart2;
    SKSpriteNode *heart3;
    SKAction *slimeAnimation;
    SKAction *squishEffect;
    BOOL isIpad;
    SKAction *keyGot;
    SKSpriteNode *keyHUD;
    SKSpriteNode *key;
    SKAction *keyDing;
    AVAudioPlayer *musicPlayer;
    BOOL isKeyGrabbed;
    SKSpriteNode *keyNoti;
    BOOL gameIsOver;
    EndScene *endScene;
    SKNode *backgroundNode;
    SKNode *midgroundNode;
    SKAction *coinGet;
    SKLabelNode *score;
    SKAction *jumpAction;
    NSString *alienPicked;
}

@property (nonatomic)int health;
@property (nonatomic)BOOL didWin;
@property (nonatomic)int scoreNumber;
@property (nonatomic)int *timeWait;

@end
