//
//  SetCardAppViewController.m
//  CardApp
//
//  Created by Pablo Dimenza on 11/09/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "SetCardAppViewController.h"
#import "SetPlayingCard.h"
#import "SetPlayingCardDeck.h"
#import "GameResult.h"
#import "CardMatchingGame.h"

@interface SetCardAppViewController ()
@property (weak, nonatomic) IBOutlet UILabel *moveDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) GameResult *gameResult;
@property (strong, nonatomic) NSMutableArray *history;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetCardAppViewController

- (IBAction)navigateHistory:(UISlider *)sender {
    if (sender.value > 1){
        self.moveDescriptionLabel.text = self.history[(int)floor(sender.value)-1];
        self.moveDescriptionLabel.alpha = (sender.value == sender.maximumValue) ? 1.0 : 0.3;
    }
}
- (IBAction)changeMode:(UISegmentedControl *)sender {
      self.game.numOfMatchingCards = sender.selectedSegmentIndex + 2;
}
- (IBAction)dealNewGame:(id)sender {
    self.game = nil;
    self.gameResult = nil;
    self.history = nil;
    self.historySlider.maximumValue = 0;
    self.historySlider.value = 0;
    self.flipCount = 0;
    self.modeSelector.enabled = YES;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
    self.modeSelector.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    SetPlayingCard *card = (SetPlayingCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    NSLog(@"Flipped: %@",card);
    [self updateUI];
    self.gameResult.score = self.game.score;
    [self.history addObject: [self.game.descriptionOfLastFlip copy]];
    self.historySlider.maximumValue++;
    self.historySlider.value = self.historySlider.maximumValue;
    self.flipCount++;
}

- (NSMutableArray *) history{
    if(!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

-(GameResult *)gameResult{
    if (!_gameResult) _gameResult = [[GameResult alloc] initForGameType:@"Set Match"];
    return _gameResult;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[SetPlayingCardDeck alloc]init]];
    return _game;
}


- (void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}



- (IBAction)testing:(id)sender {
    SetPlayingCard *testCard = (SetPlayingCard *)[self.game cardAtIndex:(arc4random() % self.cardButtons.count - 1)];
    self.moveDescriptionLabel.attributedText = [testCard formattedContents];
    NSLog(@"Content of testCard: %@",testCard);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) updateUI{
    
    for (UIButton *cardButton in self.cardButtons){
        NSObject *cardToBe = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if ([cardToBe isKindOfClass:[SetPlayingCard class]]){
            SetPlayingCard *card = (SetPlayingCard *)cardToBe;
            [cardButton setAttributedTitle:[card formattedContents] forState:UIControlStateNormal];
            [cardButton setAttributedTitle:[card formattedContents] forState:UIControlStateSelected];
            [cardButton setAttributedTitle:[card formattedContents] forState:UIControlStateSelected|UIControlStateDisabled];
            cardButton.selected = card.isFaceUp;
            cardButton.enabled = !card.isUnplayable;
            cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
            if (!card.isFaceUp){
                [cardButton setBackgroundColor:[UIColor whiteColor]];
            } else {
                [cardButton setBackgroundColor:[UIColor grayColor]];
            }
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.moveDescriptionLabel.text = self.game.descriptionOfLastFlip;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
