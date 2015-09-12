//
//  GameScene.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/7/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>
#import "EndScene.h"
#import "WinScene.h"

typedef NS_OPTIONS(uint32_t, CollisionCategory){
    CollisionCategoryPlayer = 0x1 << 0,
    CollisionCategorySlime = 0x1 << 1,
    CollisionCategoryKey = 0x1 << 2,
    CollisionCategoryPlatform = 0x1 << 3,
    CollisionCategorySign = 0x1 << 4,
    CollisionCategoryCoin = 0x1 << 5,
};

@implementation GameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [SKColor colorWithRed:(255.0f/255.0) green:(139.0f/225.0) blue:(248.0f/225.0) alpha:1.0];

        self.physicsWorld.gravity = CGVectorMake(0.0f, -2.0f);
        self.physicsWorld.contactDelegate = self;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            isIpad = YES;
        }
        self.timeWait = (int*) 60;
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.physicsWorld.contactDelegate = self;
    self.size = view.bounds.size;
    worldNode = [SKNode node];

    
    
    //background work
    backgroundNode = [SKNode node];
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    background.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    SKSpriteNode *background2 = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    background2.position = CGPointMake(background.position.x+1024,[UIScreen mainScreen].bounds.size.height/2);
    SKSpriteNode *background3 = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    background3.position = CGPointMake(background2.position.x+1024,[UIScreen mainScreen].bounds.size.height/2);
    
    if (isIpad) {
        background.xScale = 2;
        background.yScale = 2;
        background2.position = CGPointMake(background.position.x+2048,[UIScreen mainScreen].bounds.size.height/2);
        background2.xScale = 2;
        background2.yScale = 2;
        background3.xScale = 2;
        background3.yScale = 2;
    }
    
    [backgroundNode addChild:background];
    [backgroundNode addChild:background2];
    [backgroundNode addChild:background3];
    
    [worldNode addChild:backgroundNode];
    
    midgroundNode = [SKNode node];
    
    SKSpriteNode *tree = [SKSpriteNode spriteNodeWithImageNamed:@"tree31.png"];
    tree.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+30,[UIScreen mainScreen].bounds.size.height/2-80);
    tree.zPosition = 1;
    
    SKSpriteNode *tree2 = [SKSpriteNode spriteNodeWithImageNamed:@"tree31.png"];
    tree2.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+800,[UIScreen mainScreen].bounds.size.height/2-80);
    tree2.zPosition = 1;
    
    [midgroundNode addChild:tree];
    [midgroundNode addChild:tree2];
    [worldNode addChild:midgroundNode];
    
    //midground work
    
    SKNode *platformNode = [SKNode node];
    
    SKSpriteNode *platform = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    platform.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize = CGSizeMake(platform.size.width, platform.size.height * 1.2);
    platform.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize];
    platform.physicsBody.dynamic = NO;
    platform.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform.zPosition = 2;

    
    SKSpriteNode *platform2 = [SKSpriteNode spriteNodeWithImageNamed:@"grassRight"];
    platform2.position = CGPointMake([UIScreen mainScreen].bounds.size.width/1.3,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize2 = CGSizeMake(platform.size.width, platform2.size.height * 1.2);
    platform2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize2];
    platform2.physicsBody.dynamic = NO;
    platform2.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform2.zPosition = 2;

    
    SKSpriteNode *platform3 = [SKSpriteNode spriteNodeWithImageNamed:@"grassLeft"];
    platform3.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+375,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize3 = CGSizeMake(platform3.size.width, platform3.size.height * 1.2);
    platform3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize3];
    platform3.physicsBody.dynamic = NO;
    platform3.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform3.zPosition = 2;

    
    SKSpriteNode *platform4 = [SKSpriteNode spriteNodeWithImageNamed:@"grassMid"];
    platform4.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+500,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize4 = CGSizeMake(platform4.size.width, platform4.size.height * 1.2);
    platform4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize4];
    platform4.physicsBody.dynamic = NO;
    platform4.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform4.zPosition = 2;

    SKSpriteNode *platform5 = [SKSpriteNode spriteNodeWithImageNamed:@"grassRight"];
    platform5.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+625,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize5 = CGSizeMake(platform5.size.width, platform5.size.height * 1.2);
    platform5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize5];
    platform5.physicsBody.dynamic = NO;
    platform5.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform5.zPosition = 2;

    SKSpriteNode *platform6 = [SKSpriteNode spriteNodeWithImageNamed:@"grassLeft"];
    platform6.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+825,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize6 = CGSizeMake(platform6.size.width, platform6.size.height * 1.2);
    platform6.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize6];
    platform6.physicsBody.dynamic = NO;
    platform6.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform6.zPosition = 2;

    SKSpriteNode *platform7 = [SKSpriteNode spriteNodeWithImageNamed:@"grassMid"];
    platform7.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+950,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize7 = CGSizeMake(platform7.size.width, platform7.size.height * 1.2);
    platform7.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize7];
    platform7.physicsBody.dynamic = NO;
    platform7.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform7.zPosition = 2;

    SKSpriteNode *platform8 = [SKSpriteNode spriteNodeWithImageNamed:@"grassRight"];
    platform8.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1075,[UIScreen mainScreen].bounds.size.height/4);
    CGSize platformSize8 = CGSizeMake(platform8.size.width, platform8.size.height * 1.2);
    platform8.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize8];
    platform8.physicsBody.dynamic = NO;
    platform8.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform8.zPosition = 2;

    if (isIpad) {
        platform.xScale = 1.4;
        platform.yScale = 1.4;
        platform2.xScale = 1.4;
        platform2.yScale = 1.4;
        platform3.xScale = 1.4;
        platform3.yScale = 1.4;
        platform4.xScale = 1.4;
        platform4.yScale = 1.4;
        platform5.xScale = 1.4;
        platform5.yScale = 1.4;
        platform6.xScale = 1.4;
        platform6.yScale = 1.4;
        platform7.xScale = 1.4;
        platform7.yScale = 1.4;
        platform8.xScale = 1.4;
        platform8.yScale = 1.4;
        
        platform2.position = CGPointMake(platform.position.x + 120,[UIScreen mainScreen].bounds.size.height/4);
        
        platform6.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+925,[UIScreen mainScreen].bounds.size.height/4);
        platform7.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1050,[UIScreen mainScreen].bounds.size.height/4);
        platform8.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1175,[UIScreen mainScreen].bounds.size.height/4);
    }



    [platformNode addChild:platform];
    [platformNode addChild:platform2];
    [platformNode addChild:platform3];
    [platformNode addChild:platform4];
    [platformNode addChild:platform5];
    [platformNode addChild:platform6];
    [platformNode addChild:platform7];
    [platformNode addChild:platform8];


    
    [worldNode addChild:platformNode];
    
    //player work
    
    player = [SKSpriteNode spriteNodeWithImageNamed:@"alienBlue_front"];
    player.xScale = 0.5;
    player.yScale = 0.5;
    player.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/1.25);
    player.name = @"player";
    player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:player.size.width/2];
    player.physicsBody.dynamic = YES;
    player.physicsBody.usesPreciseCollisionDetection = YES;
    player.physicsBody.contactTestBitMask = CollisionCategorySlime|CollisionCategoryKey|CollisionCategorySign|CollisionCategoryPlatform|CollisionCategoryCoin;
    player.physicsBody.categoryBitMask = CollisionCategoryPlayer;
    player.physicsBody.collisionBitMask = CollisionCategoryPlatform|CollisionCategorySlime|CollisionCategorySign;
    player.physicsBody.allowsRotation = NO;
    player.physicsBody.mass = 4;
    self.health = 6;
    player.zPosition = 2;

    
    [worldNode addChild:player];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"walk"];
    SKTexture *walk1 = [atlas textureNamed:@"alienBlue_walk1.png"];
    SKTexture *walk2 = [atlas textureNamed:@"alienBlue_walk2.png"];
    walkTextures = @[walk1, walk2];
    
    hitAction = [SKAction playSoundFileNamed:@"creature3.mp3" waitForCompletion:YES];
    //enemy work
    
    SKNode *enemyNode = [SKNode node];
    
    enemy = [SKSpriteNode spriteNodeWithImageNamed:@"slimePurple"];
    enemy.xScale = .6;
    enemy.yScale = .6;
    enemy.position = CGPointMake([UIScreen mainScreen].bounds.size.width/1.3,[UIScreen mainScreen].bounds.size.height/1.5);
    enemy.name = @"slime";
    CGSize enemySize = CGSizeMake(enemy.size.width/2, enemy.size.height/1.85);
    enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemySize];
    enemy.physicsBody.categoryBitMask = CollisionCategorySlime;
    enemy.physicsBody.collisionBitMask = CollisionCategoryPlatform|CollisionCategoryPlayer;
    enemy.physicsBody.dynamic = YES;
    enemy.physicsBody.mass = 1;
    enemy.physicsBody.allowsRotation = NO;
    enemy.zPosition = 2;

    
    SKTextureAtlas *enemyAtlas = [SKTextureAtlas atlasNamed:@"slimePurple"];
    SKTexture *slime1 = [enemyAtlas textureNamed:@"slimePurple_move.png"];
    SKTexture *slime2 = [enemyAtlas textureNamed:@"slimePurple.png"];
    enemyTextures = @[slime1, slime2];
    
    enemyMovement = [SKAction moveByX:-60.0f y:0.0f duration:5];
    
    [enemyNode addChild:enemy];
    
    [worldNode addChild:enemyNode];
    
    [enemy runAction:[SKAction repeatAction:enemyMovement count:5] withKey:@"movement"];
    
    //key and signs
    key = [SKSpriteNode spriteNodeWithImageNamed:@"keyBlue.png"];
    key.xScale = .5;
    key.yScale = .5;
    key.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+500,[UIScreen mainScreen].bounds.size.height/4 + 140);
    key.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:key.size.width/2.3];
    key.physicsBody.usesPreciseCollisionDetection = YES;
    key.physicsBody.dynamic = NO;
    key.physicsBody.categoryBitMask = CollisionCategoryKey;
    key.zPosition = 2;
    
    if (isIpad)
    {
        key.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+500,[UIScreen mainScreen].bounds.size.height/4 + 160);
        key.xScale = .75;
        key.yScale = .75;
    }
    
    keyDing = [SKAction playSoundFileNamed:@"bell.m4a" waitForCompletion:YES];
    
    keyNoti = [SKSpriteNode spriteNodeWithImageNamed:@"hudKey_blue_empty.png"];
    keyNoti.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1085,[UIScreen mainScreen].bounds.size.height/4 + 200);
    keyNoti.xScale = .75;
    keyNoti.yScale = .75;
    keyNoti.zPosition = 2;
    
    if (isIpad)
    {
        keyNoti.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1195,[UIScreen mainScreen].bounds.size.height/4 + 220);
    }
    
    SKSpriteNode *rightSign = [SKSpriteNode spriteNodeWithImageNamed:@"signRight.png"];
    rightSign.position = CGPointMake([UIScreen mainScreen].bounds.size.width/1.3+30,[UIScreen mainScreen].bounds.size.height/4+90);
    rightSign.xScale = .75;
    rightSign.yScale = .75;
    
    if (isIpad) {
        rightSign.position = CGPointMake([UIScreen mainScreen].bounds.size.width/1.3-20,[UIScreen mainScreen].bounds.size.height/4+160);
        rightSign.xScale = 1;
        rightSign.yScale = 1;
    }
    
    SKSpriteNode *exitSign = [SKSpriteNode spriteNodeWithImageNamed:@"signExit.png"];
    exitSign.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1085,[UIScreen mainScreen].bounds.size.height/4 + 100);
    exitSign.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:exitSign.size.width/2];
    exitSign.physicsBody.dynamic = NO;
    exitSign.xScale = .8;
    exitSign.yScale = .8;
    exitSign.physicsBody.categoryBitMask = CollisionCategorySign;
    exitSign.zPosition = 2;
    
    if (isIpad) {
        exitSign.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1195,[UIScreen mainScreen].bounds.size.height/4 + 130);
    }
    
    [worldNode addChild:key];
    [worldNode addChild:keyNoti];
    [worldNode addChild:rightSign];
    [worldNode addChild:exitSign];
    
    //COIN
    
    
    coin = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coin.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2 + 100,[UIScreen mainScreen].bounds.size.height/4+100);
    coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin.physicsBody.dynamic = NO;
    coin.xScale = .5;
    coin.yScale = .5;
    coin.physicsBody.usesPreciseCollisionDetection = YES;
    coin.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coin.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coin.zPosition = 2;
    
    coin2 = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coin2.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2 + 420,[UIScreen mainScreen].bounds.size.height/4+100);
    coin2.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin2.physicsBody.dynamic = NO;
    coin2.xScale = .5;
    coin2.yScale = .5;
    coin2.physicsBody.usesPreciseCollisionDetection = YES;
    coin2.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coin2.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coin2.zPosition = 2;
    
    coin3 = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coin3.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2 + 570,[UIScreen mainScreen].bounds.size.height/4+100);
    coin3.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin3.physicsBody.dynamic = NO;
    coin3.xScale = .5;
    coin3.yScale = .5;
    coin3.physicsBody.usesPreciseCollisionDetection = YES;
    coin3.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coin3.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coin3.zPosition = 2;
    
    coinGet = [SKAction playSoundFileNamed:@"powerUp2.m4a" waitForCompletion:YES];
    
    [worldNode addChild:coin];
    [worldNode addChild:coin2];
    [worldNode addChild:coin3];
    
    //hud
    HUDNode = [SKNode node];
    HUDNode.zPosition = 1000;
    
    SKSpriteNode *alienHUD = [SKSpriteNode spriteNodeWithImageNamed:@"hudPlayer_blue.png"];
    alienHUD.position = CGPointMake(40, [UIScreen mainScreen].bounds.size.height-40);
    alienHUD.xScale = .75;
    alienHUD.yScale = .75;
    alienHUD.name = @"alienPause";
    
    heart1 = [SKSpriteNode spriteNodeWithImageNamed:@"hudHeart_full.png"];
    heart1.position = CGPointMake(160,[UIScreen mainScreen].bounds.size.height-40);
    heart1.xScale = .75;
    heart1.yScale = .75;
    
    heart2 = [SKSpriteNode spriteNodeWithImageNamed:@"hudHeart_full.png"];
    heart2.position = CGPointMake(heart1.position.x+60,heart1.position.y);
    heart2.xScale = .75;
    heart2.yScale = .75;
    
    heart3 = [SKSpriteNode spriteNodeWithImageNamed:@"hudHeart_full.png"];
    heart3.position = CGPointMake(heart2.position.x+60,heart1.position.y);
    heart3.xScale = .75;
    heart3.yScale = .75;
    
    keyHUD = [SKSpriteNode spriteNodeWithImageNamed:@"hudKey_blue_empty.png"];
    keyHUD.position = CGPointMake(40,[UIScreen mainScreen].bounds.size.height-120);
    keyHUD.xScale = .75;
    keyHUD.yScale = .75;
    
    score = [SKLabelNode labelNodeWithFontNamed:@"KenVector Bold"];
    score.fontSize = 20;
    score.fontColor = [SKColor colorWithRed:(88.0f/255.0) green:(123.0f/225.0) blue:(165.0f/225.0) alpha:1.0];
    score.position = CGPointMake(heart2.position.x+60, heart1.position.y-80);
    score.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [score setText:[NSString stringWithFormat:@"%i",self.scoreNumber]];
    
    [HUDNode addChild:alienHUD];
    [HUDNode addChild:heart1];
    [HUDNode addChild:heart2];
    [HUDNode addChild:heart3];
    [HUDNode addChild:keyHUD];
    [HUDNode addChild:score];
    
    reduceHeart = [SKAction setTexture:[SKTexture textureWithImageNamed:@"hudHeart_half.png"]];
    emptyHeart = [SKAction setTexture:[SKTexture textureWithImageNamed:@"hudHeart_empty.png"]];
    keyGot = [SKAction setTexture:[SKTexture textureWithImageNamed:@"hudKey_blue.png"]];

    [self addChild:HUDNode];
    
    
    //music
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RetroBeat" ofType:@"m4a"]];
    musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    musicPlayer.numberOfLoops = -1;
    [musicPlayer play];
    
    self.anchorPoint = CGPointMake (0,0);
    
    [self addChild:worldNode];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *touchedSprite = (SKSpriteNode*)[self nodeAtPoint:location];

        walkAnimationLoop = [SKAction repeatActionForever:[SKAction animateWithTextures:walkTextures timePerFrame:0.2 resize:true restore:false]];
        flipPlayer = [SKAction scaleXBy:-1 y:0 duration:0.0];

        soundEffect = [SKAction playSoundFileNamed:@"jump1.mp3" waitForCompletion:YES];
        
        slimeAnimation = [SKAction animateWithTextures:enemyTextures timePerFrame:0.2];
        squishEffect = [SKAction playSoundFileNamed:@"squish.m4a" waitForCompletion:YES];
        jumpAction = [SKAction setTexture:[SKTexture textureWithImageNamed:@"alienBlue_jump.png"] resize:YES];
        
        
        if (location.x > self.size.width/2) {
            isRunningRight = true;
            isRunningLeft = false;
            if (flipped) {
                player.xScale = .5;
                flipped = false;
            }
            [player runAction:walkAnimationLoop withKey:@"walkRightKey"];
        } else if (location.x < self.size.width/2) {
            isRunningLeft = true;
            isRunningRight = false;
            if (!flipped) {
                player.xScale = -0.5;
                flipped = true;
            }
            [player runAction:walkAnimationLoop withKey:@"walkRightKey"];
        }
     
        if (location.y < self.size.height/5 && isTouchingPlatform) {
            isJumping = true;
        }
        
        if ([[touchedSprite name] isEqualToString:@"alienPause"])
        {
            if (self.isPaused)
            {
                self.paused = NO;
                [musicPlayer play];
            }
            else if (!self.isPaused)
            {
                self.paused = YES;
                [musicPlayer pause];
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isRunningRight = false;
    isRunningLeft = false;
    [player removeActionForKey:@"walkRightKey"];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (gameIsOver) return;
    
    if (player.physicsBody.velocity.dy != 0) {
        isTouchingPlatform = false;
    } else{
        isTouchingPlatform = true;
    }
    if (isRunningRight) {
        [player.physicsBody applyImpulse:CGVectorMake(25.0f, 0.0f)];
    } else if (isRunningLeft)
    {
        [player.physicsBody applyImpulse:CGVectorMake(-25.0f, 0.0f)];
    }
    if (isJumping) {
        player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 300.0f);
        [player runAction:soundEffect];
        isJumping = false;
    }
    
    if (player.physicsBody.velocity.dy > 20)
    {
        [player runAction:jumpAction];
    }
    
    
    if (self.health == 5) {
        [heart3 runAction:reduceHeart];
    } else if (self.health == 4) {
        [heart3 runAction:emptyHeart];
    } else if (self.health == 3) {
        [heart2 runAction:reduceHeart];
    } else if (self.health == 2) {
        [heart2 runAction:emptyHeart];
    } else if (self.health == 1) {
        [heart1 runAction:reduceHeart];
    } else if (self.health == 0) {
        [heart1 runAction:emptyHeart];
        [self endGame];
    }
    
    score.text = [NSString stringWithFormat:@"%i",self.scoreNumber];
    
    backgroundNode.position = CGPointMake(-((player.position.x - 300.0f)/10), -((player.position.y - 25.0f)/10));
    midgroundNode.position = CGPointMake(-((player.position.x - 300.0f)/4), midgroundNode.position.y);


    
    if (self.didWin) {
        endScene.playerWon = YES;
        [self endGame];
    }
    
    if (isIpad) {
        if (player.position.y < -500) {
            [self endGame];
        }
    } else
        
        if (player.position.y < -300) {
        [self endGame];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{

    if ((contact.bodyA.categoryBitMask == CollisionCategorySlime) && (contact.bodyB.categoryBitMask == CollisionCategoryPlayer))
    {
        if (player.position.y > enemy.position.y+30)
        {
            [self runAction:squishEffect];
            [enemy runAction:slimeAnimation];
            [enemy runAction:[SKAction waitForDuration:5]];
            self.scoreNumber = self.scoreNumber + 150;
            [enemy removeFromParent];
        } else
        {
        self.health--;
        [player runAction:hitAction];
            [enemy removeActionForKey:@"movement"];
            [enemy runAction:[SKAction repeatAction:enemyMovement count:5] withKey:@"movement"];
        }
    }
    
    
    if ((contact.bodyB.categoryBitMask == CollisionCategoryKey))
    {
        [keyHUD runAction:keyGot];
        [keyHUD runAction:keyDing];
        [keyNoti runAction:keyGot];
        isKeyGrabbed = YES;
        [key removeFromParent];
    }
    
    if ((contact.bodyB.categoryBitMask == CollisionCategorySign))
    {
        if (isKeyGrabbed) {
            self.didWin = YES;
            endScene.playerWon = YES;
        };
    }
    
    if ((contact.bodyB.categoryBitMask == CollisionCategoryCoin))
    {
        [self runAction:coinGet];
        SKNode *coinToDelete = contact.bodyB.node;
        self.scoreNumber = self.scoreNumber + 100;
        [coinToDelete removeFromParent];
    }

}

-(void)didSimulatePhysics
{
    worldNode.position = CGPointMake(-(player.position.x-(self.size.width/2)), -(player.position.y-(self.size.height/2)));
}

-(void) endGame
{
    //ends game, transition to EndGameScene
    gameIsOver = YES;
    
    NSString *levelString = @"Level 1";
    [[NSUserDefaults standardUserDefaults] setObject:levelString forKey:@"level"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (self.didWin) {
        WinScene *winScene = [[WinScene alloc]initWithSize:self.size];
        SKTransition *reveal = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.5];
        [self.view presentScene:winScene transition:reveal];
    } else if (!self.didWin)
    {
        endScene = [[EndScene alloc] initWithSize:self.size];
        SKTransition *reveal = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.5];
        [self.view presentScene:endScene transition:reveal];
    }

}


@end
