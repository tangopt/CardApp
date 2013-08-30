//
//  CardAppViewController.m
//  CardApp
//
//  Created by Pablo Dimenza on 28/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "CardAppViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardAppViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *moveDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSMutableArray *history;


@end

@implementation CardAppViewController

- (IBAction)changeMode:(UISegmentedControl *)sender {
    self.game.numOfMatchingCards = sender.selectedSegmentIndex + 2;    
}

- (IBAction)navigateHistory:(UISlider *)sender {
    if (sender.value > 1){
        self.moveDescriptionLabel.text = self.history[(int)floor(sender.value)-1];
        self.moveDescriptionLabel.alpha = (sender.value == sender.maximumValue) ? 1.0 : 0.3;
    }
}

- (IBAction)dealNewGame:(id)sender {
    self.game = nil;
    self.history = nil;
    self.historySlider.maximumValue = 0;
    self.historySlider.value = 0;
    self.flipCount = 0;
    self.modeSelector.enabled = YES;
    [self updateUI];

}

- (NSMutableArray *) history{
    if(!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) updateUI{
    
    UIImage *backCard = [UIImage imageNamed:@"CardBackRed.png"];
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        if (!card.isFaceUp){
            [cardButton setImage:backCard forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.moveDescriptionLabel.text = self.game.descriptionOfLastFlip;
}

- (void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    self.modeSelector.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
    [self.history addObject: [self.game.descriptionOfLastFlip copy]];
    self.historySlider.maximumValue++;
    self.historySlider.value = self.historySlider.maximumValue;
    self.flipCount++; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
