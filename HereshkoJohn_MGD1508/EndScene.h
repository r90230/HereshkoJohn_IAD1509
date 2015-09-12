//
//  EndScene.h
//  HereshkoJohn_MGD1508
//
//  Created by John Hereshko on 8/22/15.
//  Copyright (c) 2015 John Hereshko. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EndScene : SKScene
{
    AVAudioPlayer *musicPlayer;
    SKLabelNode *tryAgain;
    SKLabelNode *mainMenu;
}


@property (nonatomic)    BOOL playerWon;


@end
