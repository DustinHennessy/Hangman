//
//  ViewController.m
//  Hangman
//
//  Created by Christopher Wehe on 6/4/15.
//  Copyright (c) 2015 wehe development. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *wordArray;
@property (nonatomic, strong) NSString *currentWordString;
@property (nonatomic, strong) NSArray *letterArray;

@end

@implementation ViewController

//Great work

#pragma mark- interactivity methods

- (IBAction)newGameButtonPressed:(id)sender{
    NSLog(@"new game button pressed");
    UIAlertController *newGameAlertController= [UIAlertController alertControllerWithTitle:@"New Game" message:@"Are you sure you want to start a new game? Any unsaved data will be lost." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel= [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *newGame= [UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self startNewGame];
    }];
    [newGameAlertController addAction:cancel];
    [newGameAlertController addAction:newGame];
    [self presentViewController:newGameAlertController animated:YES completion:nil];
    
    _letterArray = [self convertStringToCharArray:_currentWordString];
    
    
}



- (IBAction)letterPressed:(UIButton *) sender {
    
    NSLog(@"%@", sender.titleLabel.text);
}

-(NSArray *)convertStringToCharArray:(NSString *)textstring {
    NSMutableArray *characters= [[NSMutableArray alloc] initWithCapacity:[textstring length]];
    for (int i=0; i < [textstring length]; i++) {
        NSString *ichar =[NSString stringWithFormat:@"%c", [textstring characterAtIndex:i]];
        [characters addObject:ichar];

        
    }
    return characters;
}

#pragma mark - Core Methods

- (NSString *)readBundleFileToString:(NSString *)filename ofType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

- (NSArray *)convertCSVStringToArray:(NSString *)csvString {
    NSString *cleanString = [[csvString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
    return [cleanString componentsSeparatedByCharactersInSet:set];
}

- (void)startNewGame {
    
    int randomWordIndex = arc4random_uniform((uint32_t)_wordArray.count);
    
    _wordArray = [self convertCSVStringToArray:[self readBundleFileToString:@"AppleWordSet2" ofType:@"csv"]];
    
    _currentWordString = _wordArray[randomWordIndex];
    
    NSLog(@"%@", _currentWordString);
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
