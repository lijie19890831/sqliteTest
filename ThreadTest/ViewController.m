//
//  ViewController.m
//  ThreadTest
//
//  Created by admin on 16/7/30.
//  Copyright © 2016年 oo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //创建主队列 主线程中执行的队列任务
    dispatch_queue_t queue = dispatch_get_main_queue();
    //自己创建队列 串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("wtfee", DISPATCH_QUEUE_SERIAL);
    //自己创建队列 并行队列
    dispatch_queue_t queue2 = dispatch_queue_create("wtfeek", DISPATCH_QUEUE_CONCURRENT);
    //创建全局并行队列 并行任务一般加入这个队列
    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建同步任务 还在主线程中执行,这个例子会造成线程锁死的现象
    /*NSLog(@"线程执行之前%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"线程执行中%@", [NSThread currentThread]);
        //[self.view setBackgroundColor:[UIColor yellowColor]];
    });
    NSLog(@"线程执行中%@", [NSThread currentThread]);*/
    //创建异步任务 在分线程中执行,多线程执行的任务，系统会自己定时去查看，发现执行完了以后会去执行主线程的任务，这样就会造成一定时间的延迟
    /*dispatch_async(queue3, ^{
        NSLog(@"%@", [NSThread currentThread]);
        [self.view setBackgroundColor:[UIColor cyanColor]];
    });*/
    
    //1.创建NSBlockOperation对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    //添加多个Block
    for (NSInteger i = 0; i < 5; i++) {
        [operation addExecutionBlock:^{
            NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
        }];
    }
    
    //2.开始任务
    [operation start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
