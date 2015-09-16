//
//  CharacterSelect.h
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 9/13/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CharacterSelect : SKScene
{
    SKLabelNode *titleLabel;
    SKSpriteNode *alienK;
    SKSpriteNode *alienSlime;
    SKLabelNode *returnButton;
    AVAudioPlayer *musicPlayer;
}

@end
