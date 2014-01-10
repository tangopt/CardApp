//
//  GameResultsViewController.m
//  CardApp
//
//  Created by Pablo Dimenza on 10/09/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultsViewController

-(void)updateUI{
    NSString *displayText = @"";
    for (GameResult *gameResult in [GameResult allGameResults]){
        displayText = [displayText stringByAppendingFormat:@"Type: %@, Score: %d (%@, %0g)\n", gameResult.gameType, gameResult.score, gameResult.end, round(gameResult.duration)];
    }
    self.display.text = displayText;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)setup{
    //initialization that can't wait until viewDidLoad
}

-(void) awakeFromNib{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
