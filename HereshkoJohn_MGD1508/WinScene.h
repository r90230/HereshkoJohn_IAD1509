//
//  WinScene.h
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/27/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface WinScene : SKScene
{
    AVAudioPlayer *musicPlayer;
    SKLabelNode* tryAgain;
    SKLabelNode* mainMenu;
}

@end
