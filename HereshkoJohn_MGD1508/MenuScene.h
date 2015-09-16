//
//  MenuScene.h
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/26/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

@interface MenuScene : SKScene
{
    SKLabelNode *playButton;
    SKLabelNode *learningButton;
    SKLabelNode *selectButton;
    SKLabelNode *titleLabel;
    AVAudioPlayer *musicPlayer;
    BOOL isGameCenterEnabled;
}


@end
