#import "RNAudioPlayer.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation RNAudioPlayer

RCT_EXPORT_MODULE()

@synthesize bridge = _bridge;

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory: AVAudioSessionCategoryPlayback error: nil];
        [session setActive: YES error: nil];
    }
    
    return self;
}

RCT_EXPORT_METHOD(play:(NSString *)fileName)
{
    if (fileName) {
//        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:[[fileName lastPathComponent] stringByDeletingPathExtension]
//                                                  withExtension:[fileName pathExtension]];
        
        NSURL *soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], fileName]];
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        self.audioPlayer.delegate = self;
    }
    
    [self.audioPlayer play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self.bridge.eventDispatcher sendAppEventWithName:@"AudioPlayerPlayingFinished" body:nil];
}

@end
