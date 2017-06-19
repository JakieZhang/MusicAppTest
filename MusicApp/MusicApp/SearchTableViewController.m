//
//  SearchTableViewController.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SongsInfo.h"
@interface SearchTableViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong) NSArray *songs;
@end

@implementation SearchTableViewController


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSString *str = [NSString stringWithFormat:kSearchSongsPath,searchText];
    
    [NetWorking getObjFromNetWorkWithPagram:nil andURL:str andCompletion:^(id obj) {
        NSLog(@"输出内容%@",obj);
        NSArray *songs = [SongsInfo arrayOfModelsFromDictionaries:obj[@"song"] error:nil];
        self.songs = songs;
        [self.tableView reloadData];
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    SongsInfo *si = self.songs[indexPath.row];
    cell.textLabel.text = si.songname;
    cell.detailTextLabel.text = si.artistname;
    return cell;
}




@end
