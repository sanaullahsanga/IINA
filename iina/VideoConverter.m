//
//  VideoConverter.m
//  iina
//
//  Created by mac book on 10/14/20.
//  Copyright © 2020 lhc. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "VideoConverter.h"
#import "IINA-Swift.h"
NSTask *task;
QuickTimeOptionsWindowsController * quicktime;
@implementation VideoConverter

+ (NSString*) runTask:(NSArray *)args :(QuickTimeOptionsWindowsController *)quicktime {
  
  NSString *appPath = [[[[NSBundle mainBundle] bundleURL] URLByDeletingLastPathComponent] path];
  
  NSString *ffmpegPath = [appPath stringByAppendingString:@"/IINA.app/Contents/Resources/ffmpeg"];
  
  task = [NSTask new];
  [task setLaunchPath:ffmpegPath];
  [task setArguments:args];
  
  NSPipe *pipe = [NSPipe pipe];
  [task setStandardOutput:pipe];
  [task setStandardError: [task standardOutput]];
  
  NSFileHandle *output;
  output=[pipe fileHandleForReading];

  
  [[quicktime horizentalprogressbar]setDoubleValue:0.0];
  [[quicktime horizentalprogressbar]startAnimation:(self)];

  dispatch_queue_t mainQueue = dispatch_get_main_queue();
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(queue, ^{
    //
    /*
    [output waitForDataInBackgroundAndNotify];
    [[NSNotificationCenter defaultCenter] addObserverForName:NSFileHandleDataAvailableNotification
                              object:output queue:nil
                              usingBlock:^(NSNotification *note)
    {
         NSData *progressData = [output availableData];
         NSString *progressStr = [[NSString alloc] initWithData:progressData encoding:NSUTF8StringEncoding];
      
         NSLog(@"progress: %@", progressStr);
      NSLog(@"hy i am here: %@", progressStr);

         [output waitForDataInBackgroundAndNotify];
     }];*/
    
    [task launch];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outData:)
   // name:NSFileHandleDataAvailableNotification object:output];

    //[output waitForDataInBackgroundAndNotify];
    
    [task waitUntilExit];
    dispatch_async(mainQueue, ^{
     //
      int status= [task terminationStatus];
      if (status == 0) {
        quicktime.output.stringValue=[NSString stringWithFormat:@"%s","Successfully Converted"];
      } else {
        quicktime.output.stringValue=[NSString stringWithFormat:@"%s","Failed to Convert"];
      }
      [[quicktime circularprogress]stopAnimation:(self)];
      [[quicktime circularprogress] setHidden:YES];
      [[quicktime OK] setHidden:YES];
      
      quicktime.Cancel.title=[NSString stringWithFormat:@"%s","OK"];
      dispatch_suspend(queue);
    });
  });
  [[quicktime circularprogress]startAnimation:(self)];
  return @"Converting";
}

+ (NSString*) cancel_conversion:(NSArray *)args {
  [task suspend];
  int status = [task terminationStatus];
  if (status == 0) {
    return @"Successfully Converted";
  } else {
    return @"Failed to Convert";
  }
}
- (void)outData:(NSNotification *)notification {
NSFileHandle *outputFile = (NSFileHandle *) [notification object];
NSData *data = [outputFile availableData];

if([data length]) {
    NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Here: %@", temp);
}

[outputFile waitForDataInBackgroundAndNotify];
}
 @end
