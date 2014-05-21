//
//  HSFoursquareWorker.h
//  HackerSpot
//
//  Created by Kevin Coleman on 5/3/14.
//  Copyright (c) 2014 Kevin Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 The pattern you see below is called a singleton pattern. The specific obj-c pattern is the most current agreed upon pattern in objective-c to safely grab a singleton instance and have it be thread safe. Singletons are in every language / framework. Just differs on how you go about instantiating them. Here’s some reading on singletons in cocoa land:
 https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/Singleton.html
 
 "What are you creating the queue using GCD? Do they take serious resources to create?”
 
 No, they do not take nearly any resources. When you say “GCD” I’m assuming what you’re really asking me is this: “Why are you doing this on another thread”.
 
 The answer is that I’m not. GCD has many functions, all of them have to do with data synchronization; getting onto another thread is just one of those facilities. GCD offers much more than just assessing other threads / queues. GCD in this case is offering a method to ensure that a specific code block is only run once in a given process, regardless of the accessing thread.
 
 Here’s the docs on dispatch_once
 https://developer.apple.com/library/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/Reference/reference.html#jumpTo_43
 
 What I’m doing, translated into english, is this:
 “If there is not already a GAPhotoUploaderQueue, then create one - BUT ONLY DO IT ONCE…. EVER! IN THE LIFE OF THIS PROGRAM. And, if it isn’t present, then use this alloc/init to create it, and while you’re at it, let it’s ivar ‘instance.maxConcurrentOperationCount’ to 5.”
 
 If I were to hit the method again, the static variable 'static GAPhotoUploaderQueue *__instance;’ will have already been populated, and the subsequent init process would not continue to the init block, it would just hand me back the already instantiated queue.
 
 You can probably see why this is needed since I want a GAPhotoUploaderQueue, and only one GAPhotoUploaderQueue ever in the app. And, whenever I access it, I want to make sure that what I’m accessing always is the same reference.
 
 One thing that might still throw you off is the re-declaration of this: 'static GAPhotoUploaderQueue *__instance;’. This is a phone call or a longer conversation, but just take my word that this is not re-initialized every time you call this method. If it’s not initialized, then it will create a blank pointer. If it already has been though, then it will always point to the previous instance due to the ‘static’ declaration.
 */

@interface HSWorkerOperationQueue : NSOperationQueue

+ (id)sharedQueue;

@end
