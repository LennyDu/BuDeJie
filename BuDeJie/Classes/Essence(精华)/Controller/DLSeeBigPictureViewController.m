//
//  DLSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLSeeBigPictureViewController.h"
#import "DLTopicItem.h"
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface DLSeeBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
/** scrollView */
@property (nonatomic,weak) UIScrollView *scrollView;
/** imageView */
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation DLSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        self.saveButton.enabled = YES;
    }];
    imageView.dl_width = scrollView.dl_width;
    imageView.dl_height = imageView.dl_width * self.topic.height / self.topic.width;
    imageView.dl_x = 0;
    if (imageView.dl_height > DLScreenH) {
        imageView.dl_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.dl_height);
    } else {
        imageView.dl_centerY = scrollView.dl_height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat maxScale = self.topic.width / imageView.dl_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - 获得当前App对应的自定义相册
- (PHAssetCollection *)createdCollection {
    //获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    //抓取所有自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 */
    //创建
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败!"];
        return nil;
    }
    
    //根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}

- (PHFetchResult<PHAsset *> *)createdAssets {
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    //保存图片到[相机胶卷]
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    //获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}

#pragma mark 监听
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)save {
//    [self createdCollection];
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    NSLog(@"提醒用户打开开关");
                }
            } else if (status == PHAuthorizationStatusAuthorized) {
                [self saveImageIntoAlbum];
            } else if (status == PHAuthorizationStatusRestricted) {
                [SVProgressHUD showErrorWithStatus:@"系统原因,无法访问相册"];
            }
        });
    }];
}

- (void)saveImageIntoAlbum {
    //获得相片
    PHFetchResult<PHAsset *> *createdAssets = [self createdAssets];
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        return;
    }
    
    //获得相册
    PHAssetCollection *createdCollection = [self createdCollection];
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败"];
        return;
    }
    
    //添加刚才保存的图片到[自定义相册]
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    //最后判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
