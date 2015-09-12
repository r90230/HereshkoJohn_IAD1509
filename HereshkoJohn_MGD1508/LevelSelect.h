//
//  LevelSelect.h
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 9/12/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LevelSelect : SKScene
{
    SKLabelNode *returnToLevel;
    SKLabelNode *level1;
    SKLabelNode *level2;
    SKLabelNode *mainMenu;
    SKLabelNode *returnToMenu;
    AVAudioPlayer *musicPlayer;

}

@end
