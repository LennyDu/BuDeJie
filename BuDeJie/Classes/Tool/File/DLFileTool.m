//
//  DLFileTool.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/11.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLFileTool.h"

@implementation DLFileTool
+ (void)getFileSize:(NSString *)directoryPath completion:(void (^)(NSInteger totalSize))completion {
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    //判断文件是否存在,并判断这个文件是否是文件夹
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"传入的参数只能是文件夹的路径, 并且此文件夹必须存在" userInfo:nil];
        [exception raise];
    }
    
    //由于文件夹层数过多或者文件过大的原因,可能造成计算时间过长,此时程序会卡住,所以要用异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        for (NSString *subPath in subPaths) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            if ([filePath containsString:@".DS"]) continue;
            //判断是否是文件夹
            BOOL isDirectory;
            //判断文件是否存在,并判断这个文件是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            NSDictionary *attrDict = [mgr attributesOfItemAtPath:filePath error:nil];
            
            NSInteger fileSize = [attrDict fileSize];
            
            totalSize += fileSize;
        }
        //计算完成后在主线程中回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
    
    
    
//    return totalSize;
}


+ (void)removeDirectoryPath:(NSString *)directoryPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    //判断文件是否存在,并判断这个文件是否是文件夹
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"传入的参数只能是文件夹的路径, 并且此文件夹必须存在" userInfo:nil];
        [exception raise];
    }
    
    //获取cache文件夹下所有文件, 不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:filePath error:nil];
    }
}
@end
