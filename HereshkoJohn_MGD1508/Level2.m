//
//  Level2.m
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 9/10/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import "Level2.h"
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

@implementation Level2

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
    SKSpriteNode *background4 = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    background4.position = CGPointMake(background3.position.x+1024,[UIScreen mainScreen].bounds.size.height/2);
    SKSpriteNode *background5 = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    background5.position = CGPointMake(background4.position.x+1024,[UIScreen mainScreen].bounds.size.height/2);
    SKSpriteNode *background6 = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    background6.position = CGPointMake(background5.position.x+1024,[UIScreen mainScreen].bounds.size.height/2);

    
    if (isIpad) {
        background.xScale = 2;
        background.yScale = 2;
        background2.position = CGPointMake(background.position.x+2048,[UIScreen mainScreen].bounds.size.height/2);
        background2.xScale = 2;
        background2.yScale = 2;
        background3.xScale = 2;
        background3.yScale = 2;
        background4.xScale = 2;
        background4.yScale = 2;
        background5.xScale = 2;
        background5.yScale = 2;
        background6.xScale = 2;
        background6.yScale = 2;
    }
    
    [backgroundNode addChild:background];
    [backgroundNode addChild:background2];
    [backgroundNode addChild:background3];
    [backgroundNode addChild:background4];
    [backgroundNode addChild:background5];
    [backgroundNode addChild:background6];
    
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
    
    SKSpriteNode *platformHalf = [SKSpriteNode spriteNodeWithImageNamed:@"grassHalf"];
    platformHalf.position = CGPointMake([UIScreen mainScreen].bounds.size.width/1.3+200,[UIScreen mainScreen].bounds.size.height/4-20);
    CGSize platformSizeHalf = CGSizeMake(platformHalf.size.width, platformHalf.size.height * 1.2);
    platformHalf.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSizeHalf];
    platformHalf.physicsBody.dynamic = NO;
    platformHalf.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platformHalf.zPosition = 2;
    
    
    SKSpriteNode *platform3 = [SKSpriteNode spriteNodeWithImageNamed:@"grassLeft"];
    platform3.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+435,[UIScreen mainScreen].bounds.size.height/4-50);
    CGSize platformSize3 = CGSizeMake(platform3.size.width, platform3.size.height * 1.2);
    platform3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize3];
    platform3.physicsBody.dynamic = NO;
    platform3.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform3.zPosition = 2;
    
    
    SKSpriteNode *platform4 = [SKSpriteNode spriteNodeWithImageNamed:@"grassRight"];
    platform4.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+560,[UIScreen mainScreen].bounds.size.height/4-50);
    CGSize platformSize4 = CGSizeMake(platform4.size.width, platform4.size.height * 1.2);
    platform4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize4];
    platform4.physicsBody.dynamic = NO;
    platform4.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform4.zPosition = 2;
    
    SKSpriteNode *platformHill = [SKSpriteNode spriteNodeWithImageNamed:@"grassHill_right"];
    platformHill.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+670,[UIScreen mainScreen].bounds.size.height/4+50);
    platformHill.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"grassHill_right"] size:platformHill.size];
    platformHill.physicsBody.dynamic = NO;
    platformHill.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platformHill.zPosition = 2;
    platformHill.physicsBody.friction = 0.0;
    SKAction *rotate = [SKAction rotateByAngle:-.28 duration:0];
    [platformHill runAction:rotate];
    
    SKSpriteNode *platform5 = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    platform5.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+760,[UIScreen mainScreen].bounds.size.height/4-300);
    CGSize platformSize5 = CGSizeMake(platform5.size.width, platform5.size.height * 1.2);
    platform5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSize5];
    platform5.physicsBody.dynamic = NO;
    platform5.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platform5.zPosition = 2;
    
    SKSpriteNode *platform6 = [SKSpriteNode spriteNodeWithImageNamed:@"grassLeft"];
    platform6.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+900,[UIScreen mainScreen].bounds.size.height/4);
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
    
    SKSpriteNode *platformChallenge1 = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    platformChallenge1.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+960,[UIScreen mainScreen].bounds.size.height/4-300);
    CGSize platformSizeChallenge1 = CGSizeMake(platform5.size.width, platform5.size.height * 1.2);
    platformChallenge1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSizeChallenge1];
    platformChallenge1.physicsBody.dynamic = NO;
    platformChallenge1.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platformChallenge1.zPosition = 2;
    
    SKSpriteNode *platformChallenge2 = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    platformChallenge2.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1160,[UIScreen mainScreen].bounds.size.height/4-300);
    CGSize platformSizeChallenge2 = CGSizeMake(platform5.size.width, platform5.size.height * 1.2);
    platformChallenge2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSizeChallenge2];
    platformChallenge2.physicsBody.dynamic = NO;
    platformChallenge2.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platformChallenge2.zPosition = 2;
    
    SKSpriteNode *platformChallenge3 = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    platformChallenge3.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1420,[UIScreen mainScreen].bounds.size.height/4-300);
    CGSize platformSizeChallenge3 = CGSizeMake(platform5.size.width, platform5.size.height * 1.2);
    platformChallenge3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSizeChallenge3];
    platformChallenge3.physicsBody.dynamic = NO;
    platformChallenge3.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platformChallenge3.zPosition = 2;
    
    SKSpriteNode *platformChallenge4 = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    platformChallenge4.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1600,[UIScreen mainScreen].bounds.size.height/4-300);
    CGSize platformSizeChallenge4 = CGSizeMake(platform5.size.width, platform5.size.height * 1.2);
    platformChallenge4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platformSizeChallenge4];
    platformChallenge4.physicsBody.dynamic = NO;
    platformChallenge4.physicsBody.collisionBitMask = CollisionCategoryPlatform;
    platformChallenge4.zPosition = 2;
    
    
    if (isIpad) {
        platformNode.xScale = 1.4;
        platformNode.yScale = 1.4;
        
        platform2.position = CGPointMake(platform.position.x + 120,[UIScreen mainScreen].bounds.size.height/4);
        
        platform6.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+925,[UIScreen mainScreen].bounds.size.height/4);
        platform7.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1050,[UIScreen mainScreen].bounds.size.height/4);
        platform8.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1175,[UIScreen mainScreen].bounds.size.height/4);
    }
    
    
    
    [platformNode addChild:platform];
    [platformNode addChild:platform2];
    [platformNode addChild:platformHalf];
    [platformNode addChild:platform3];
    [platformNode addChild:platform4];
    [platformNode addChild:platformHill];
    [platformNode addChild:platform5];
    [platformNode addChild:platform6];
    [platformNode addChild:platform7];
    [platformNode addChild:platform8];
    [platformNode addChild:platformChallenge1];
    [platformNode addChild:platformChallenge2];
    [platformNode addChild:platformChallenge3];
    [platformNode addChild:platformChallenge4];
    
    [worldNode addChild:platformNode];
    
    //player work
    
    alienPicked = [[NSUserDefaults standardUserDefaults]valueForKey:@"alienPicked"];
    
    if ([alienPicked isEqual:@"alienK"]) {
        player = [SKSpriteNode spriteNodeWithImageNamed:@"alienBlue_front"];
        player.xScale = 0.5;
        player.yScale = 0.5;
    } else if ([alienPicked isEqual:@"alienSlime"]) {
        player = [SKSpriteNode spriteNodeWithImageNamed:@"alien2_front"];
        player.xScale = 0.55;
        player.yScale = 0.55;
    } else if (alienPicked == NULL)
    {
        player = [SKSpriteNode spriteNodeWithImageNamed:@"alienBlue_front"];
        player.xScale = 0.5;
        player.yScale = 0.5;
    }

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
    
    if ([alienPicked isEqual:@"alienK"]) {
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"walk"];
        SKTexture *walk1 = [atlas textureNamed:@"alienBlue_walk1.png"];
        SKTexture *walk2 = [atlas textureNamed:@"alienBlue_walk2.png"];
        walkTextures = @[walk1, walk2];
    } else if ([alienPicked isEqual:@"alienSlime"]) {
        
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"walk2"];
        SKTexture *walk1 = [atlas textureNamed:@"alien2_Walk1.png"];
        SKTexture *walk2 = [atlas textureNamed:@"alien2_walk2.png"];
        walkTextures = @[walk1, walk2];
    } else if (alienPicked == NULL)
    {
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"walk"];
        SKTexture *walk1 = [atlas textureNamed:@"alienBlue_walk1.png"];
        SKTexture *walk2 = [atlas textureNamed:@"alienBlue_walk2.png"];
        walkTextures = @[walk1, walk2];
    }
    
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
    
    keyDing = [SKAction playSoundFileNamed:@"threeTone2.m4a" waitForCompletion:YES];
    
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
    
    SKSpriteNode *exitSignChallenge = [SKSpriteNode spriteNodeWithImageNamed:@"signExit.png"];
    exitSignChallenge.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1600,[UIScreen mainScreen].bounds.size.height/4-200);
    exitSignChallenge.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:exitSign.size.width/2];
    exitSignChallenge.physicsBody.dynamic = NO;
    exitSignChallenge.xScale = .8;
    exitSignChallenge.yScale = .8;
    exitSignChallenge.physicsBody.categoryBitMask = CollisionCategorySign;
    exitSignChallenge.zPosition = 2;
    exitSignChallenge.name = @"ChallengeSign";
    
    if (isIpad) {
        exitSign.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2+1195,[UIScreen mainScreen].bounds.size.height/4 + 130);
    }
    
    [worldNode addChild:key];
    [worldNode addChild:keyNoti];
    [worldNode addChild:rightSign];
    [worldNode addChild:exitSign];
    [worldNode addChild:exitSignChallenge];
    
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
    
    coin4 = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coin4.position =  CGPointMake([UIScreen mainScreen].bounds.size.width/2+1400,[UIScreen mainScreen].bounds.size.height/4-170);
    coin4.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin4.physicsBody.dynamic = NO;
    coin4.xScale = .5;
    coin4.yScale = .5;
    coin4.physicsBody.usesPreciseCollisionDetection = YES;
    coin4.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coin4.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coin4.zPosition = 2;
    
    coin5 = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coin5.position =  CGPointMake([UIScreen mainScreen].bounds.size.width/2+1440,[UIScreen mainScreen].bounds.size.height/4-170);
    coin5.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin5.physicsBody.dynamic = NO;
    coin5.xScale = .5;
    coin5.yScale = .5;
    coin5.physicsBody.usesPreciseCollisionDetection = YES;
    coin5.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coin5.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coin5.zPosition = 2;
    
    coin6 = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coin6.position =  CGPointMake([UIScreen mainScreen].bounds.size.width/2+1400,[UIScreen mainScreen].bounds.size.height/4-215);
    coin6.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin6.physicsBody.dynamic = NO;
    coin6.xScale = .5;
    coin6.yScale = .5;
    coin6.physicsBody.usesPreciseCollisionDetection = YES;
    coin6.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coin6.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coin6.zPosition = 2;
    
    coin7 = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coin7.position =  CGPointMake([UIScreen mainScreen].bounds.size.width/2+1440,[UIScreen mainScreen].bounds.size.height/4-215);
    coin7.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin7.physicsBody.dynamic = NO;
    coin7.xScale = .5;
    coin7.yScale = .5;
    coin7.physicsBody.usesPreciseCollisionDetection = YES;
    coin7.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coin7.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coin7.zPosition = 2;
    
    SKSpriteNode *coinHint = [SKSpriteNode spriteNodeWithImageNamed:@"coinGold.png"];
    coinHint.position =  CGPointMake([UIScreen mainScreen].bounds.size.width/2+760,[UIScreen mainScreen].bounds.size.height/4-100);
    coinHint.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coinHint.physicsBody.dynamic = NO;
    coinHint.xScale = .5;
    coinHint.yScale = .5;
    coinHint.physicsBody.usesPreciseCollisionDetection = YES;
    coinHint.physicsBody.categoryBitMask = CollisionCategoryCoin;
    coinHint.physicsBody.collisionBitMask = CollisionCategoryPlayer|CollisionCategorySlime;
    coinHint.zPosition = 2;

    
    coinGet = [SKAction playSoundFileNamed:@"powerUp2.m4a" waitForCompletion:YES];
    
    [worldNode addChild:coin];
    [worldNode addChild:coin2];
    [worldNode addChild:coin3];
    [worldNode addChild:coin4];
    [worldNode addChild:coin5];
    [worldNode addChild:coin6];
    [worldNode addChild:coin7];
    [worldNode addChild:coinHint];

    
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
        
        if ([alienPicked isEqual:@"alienK"]) {
            walkAnimationLoop = [SKAction repeatActionForever:[SKAction animateWithTextures:walkTextures timePerFrame:0.2 resize:true restore:false]];
        } else if ([alienPicked isEqual:@"alienSlime"]) {
            walkAnimationLoop = [SKAction repeatActionForever:[SKAction animateWithTextures:walkTextures timePerFrame:0.2 resize:false restore:false]];
        } else if (alienPicked == NULL)
        {
            walkAnimationLoop = [SKAction repeatActionForever:[SKAction animateWithTextures:walkTextures timePerFrame:0.2 resize:true restore:false]];
        }
        flipPlayer = [SKAction scaleXBy:-1 y:0 duration:0.0];
        
        soundEffect = [SKAction playSoundFileNamed:@"jump1.mp3" waitForCompletion:YES];
        
        slimeAnimation = [SKAction animateWithTextures:enemyTextures timePerFrame:0.2];
        squishEffect = [SKAction playSoundFileNamed:@"phaseJump1.m4a" waitForCompletion:YES];
        if ([alienPicked isEqual:@"alienK"]) {
            jumpAction = [SKAction setTexture:[SKTexture textureWithImageNamed:@"alienBlue_jump.png"] resize:YES];
            
        } else if ([alienPicked isEqual:@"alienSlime"]) {
            jumpAction = [SKAction setTexture:[SKTexture textureWithImageNamed:@"alien2_jump.png"] resize:YES];
            
        } else if (alienPicked == NULL)
        {
            jumpAction = [SKAction setTexture:[SKTexture textureWithImageNamed:@"alienBlue_jump.png"] resize:YES];
            
        }
        if (location.x > self.size.width/2) {
            isRunningRight = true;
            isRunningLeft = false;
            if (flipped) {
                if ([alienPicked isEqual:@"alienK"]) {
                    player.xScale = 0.5;
                    
                } else if ([alienPicked isEqual:@"alienSlime"]) {
                    player.xScale = 0.55;
                    
                } else if (alienPicked == NULL)
                {
                    player.xScale = 0.5;
                }
                flipped = false;
            }
            [player runAction:walkAnimationLoop withKey:@"walkRightKey"];
        } else if (location.x < self.size.width/2) {
            isRunningLeft = true;
            isRunningRight = false;
            if (!flipped) {
                if ([alienPicked isEqual:@"alienK"]) {
                    player.xScale = -0.5;
                    
                } else if ([alienPicked isEqual:@"alienSlime"]) {
                    player.xScale = -0.55;
                    
                } else if (alienPicked == NULL)
                {
                    player.xScale = -0.5;
                }
                
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
            if ([alienPicked isEqual:@"alienSlime"])
            {
                self.scoreNumber = self.scoreNumber - 200;
            } else {
                self.scoreNumber = self.scoreNumber + 150;
            }
            [enemy removeFromParent];
        } else
        {
            if ([alienPicked isEqual:@"alienSlime"]) return;
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
        if ((contact.bodyB.node.name = @"ChallengeSign"))
        {
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"challenge"] isEqual:@"Complete2"]) return;
                
            NSString *challengeComplete2 = @"Complete2";
            [[NSUserDefaults standardUserDefaults] setObject:challengeComplete2 forKey:@"challenge"];
            [self runAction:keyDing];
            
        }
    
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
    
    NSString *levelString = @"Level 2";
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
