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
    [self fetchQuotes];
    
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

- (void)fetchQuotes {
    //URL: https://type.fit/api/quotes
    NSURL *url = [NSURL URLWithString:@"https://type.fit/api/quotes"];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        
        NSArray *quotesJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if (err) {
            NSLog(@"Error: %@", err);
            return;
        }
        NSMutableArray<Quote *> *quotesList = NSMutableArray.new;
        for (NSDictionary *quoteDict in quotesJson) {
            Quote *quoteItem = Quote.new;
            NSString *author = quoteDict[@"author"];
            NSString *quote = quoteDict[@"text"];
            quoteItem.author = author;
            quoteItem.quote = quote;
            NSLog(@"%@ -%@", author, quote);
            
            [quotesList addObject:quoteItem];
        }
        
        self.quotes = quotesList;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }] resume];
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
