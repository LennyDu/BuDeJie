//
//  DLFileTool.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/11.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLFileTool : NSObject


/**
 计算文件夹的大小

 @param directoryPath 文件夹的路径
 @param completion 计算完成后执行
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void (^)(NSInteger totalSize))completion;

/**
 删除指定文件夹及其内部所有文件

 @param directoryPath 要删除的文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
