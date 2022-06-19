//
//  ViewController.m
//  Todo
//
//  Created by Adnan Joraid on 2022-06-19.
//
#import "ViewController.h"
#import "Quote.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Quote *> *quotes;

@end

@implementation ViewController

NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupQuotes];
    
    self.navigationItem.title = @"Quotes";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
}

- (void)setupQuotes{
    self.quotes = NSMutableArray.new;
    
    Quote *quote = Quote.new;
    quote.author = @"Thomas Edison";
    quote.quote = @"Genius is one percent inspiration and ninety-nine percent perspiration.";
    [self.quotes addObject:quote];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.quotes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 5;
    Quote *quote = self.quotes[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -%@", quote.quote, quote.author];

    return cell;
}


@end
