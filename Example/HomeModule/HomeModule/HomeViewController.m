//
//  HomeViewController.m
//  HomeModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "HomeViewController.h"
#import <BasicModule/BasicModule-umbrella.h>
#import <FileModule/FileModule-Swift.h>
@import CarbonObjC;

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,   copy) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    CGRect frame = self.view.bounds;
    frame.origin.y = 100;
    _tableView.frame = frame;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // MARK: S7: Protocol defined in Swift, registered in Swift, resolved in ObjC
    id<FileManagerProtocol> fileManager = (id)Application.sharedApplication.context[@protocol(FileManagerProtocol)];
    NSArray *recentFileModels = [fileManager recentFileModels];
    self.dataSource = recentFileModels;
    printf("S7: %s, %zd\n", fileManager.description.UTF8String, recentFileModels.count);
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"carbon"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"carbon"];
    }
    id<FileModelProtocol> model = (id<FileModelProtocol>)self.dataSource[indexPath.row];
    cell.textLabel.text = model.fileName;
    cell.detailTextLabel.text = model.filePath;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
