//
//  BadgeObjCViewController.m
//  AndesUI-demoapp
//

#import "BadgeObjCViewController.h"

#import <AndesUI-Swift.h>

@interface BadgeObjCViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation BadgeObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    _stackView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self setupPills];
}

- (void)setupPills {
    UILabel* pillTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    pillTitle.text = @"Pill";
    pillTitle.font = [UIFont systemFontOfSize:24];
    [_stackView addArrangedSubview:pillTitle];
    
    UIStackView* pillsStack = [[UIStackView alloc] init];
    pillsStack.axis = UILayoutConstraintAxisHorizontal;
    pillsStack.spacing = 10.0;
    
    UIStackView* loudPills = [[UIStackView alloc] init];
    loudPills.axis = UILayoutConstraintAxisVertical;
    loudPills.alignment = UIStackViewAlignmentCenter;
    loudPills.distribution = UIStackViewDistributionFillProportionally;
    loudPills.spacing = 4.0;
    
    UILabel* loudTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    loudTitle.text = @"Hierarchy: Loud";
    loudTitle.font = [UIFont systemFontOfSize:18];
    [loudPills addArrangedSubview:loudTitle];
    
    [self addPillsWithHierarchy:AndesBadgeHierarchyLoud toStack:loudPills];
    
    [pillsStack addArrangedSubview:loudPills];
    
    UIStackView* quietPills = [[UIStackView alloc] init];
    quietPills.axis = UILayoutConstraintAxisVertical;
    quietPills.alignment = UIStackViewAlignmentCenter;
    quietPills.distribution = UIStackViewDistributionFillProportionally;
    quietPills.spacing = 4.0;
    
    UILabel* quietTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    quietTitle.text = @"Hierarchy: Quiet";
    quietTitle.font = [UIFont systemFontOfSize:18];
    [quietPills addArrangedSubview:quietTitle];
    
    [self addPillsWithHierarchy:AndesBadgeHierarchyQuiet toStack:quietPills];
    
    [pillsStack addArrangedSubview:quietPills];
    
    [_stackView addArrangedSubview:pillsStack];
    
    UIStackView* oddCasesStack = [[UIStackView alloc] init];
    oddCasesStack.axis = UILayoutConstraintAxisVertical;
    oddCasesStack.alignment = UIStackViewAlignmentCenter;
    oddCasesStack.distribution = UIStackViewDistributionFillProportionally;
    oddCasesStack.spacing = 4.0;
    
    UILabel* casesTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    casesTitle.text = @"Other cases";
    casesTitle.font = [UIFont systemFontOfSize:18];
    [oddCasesStack addArrangedSubview:casesTitle];
    
    AndesBadge* oddBadge = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:AndesBadgeHierarchyLoud type:AndesBadgeTypeNeutral border:AndesBadgeBorderStandard size:AndesBadgeSizeSmall text:@"SMALL"];
    [oddCasesStack addArrangedSubview:oddBadge];
    
    oddBadge = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:AndesBadgeHierarchyLoud type:AndesBadgeTypeHighlight border:AndesBadgeBorderCorner size:AndesBadgeSizeLarge text:@"CORNER"];
    [oddCasesStack addArrangedSubview:oddBadge];
    
    oddBadge = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:AndesBadgeHierarchyLoud type:AndesBadgeTypeHighlight border:AndesBadgeBorderRounded size:AndesBadgeSizeLarge text:@"ROUNDED"];
    [oddCasesStack addArrangedSubview:oddBadge];
    
    [_stackView addArrangedSubview:oddCasesStack];
}

- (void)addPillsWithHierarchy:(AndesBadgeHierarchy)hierarchy toStack:(UIStackView*)stack {
    AndesBadge* view = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:hierarchy type:AndesBadgeTypeNeutral border:AndesBadgeBorderStandard size:AndesBadgeSizeLarge text:@"NEUTRAL"];
    [stack addArrangedSubview:view];
    
    view = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:hierarchy type:AndesBadgeTypeHighlight border:AndesBadgeBorderStandard size:AndesBadgeSizeLarge text:@"HIGHLIGHT"];;
    [stack addArrangedSubview:view];
    
    view = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:hierarchy type:AndesBadgeTypeSuccess border:AndesBadgeBorderStandard size:AndesBadgeSizeLarge text:@"SUCCESS"];;
    [stack addArrangedSubview:view];
    
    view = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:hierarchy type:AndesBadgeTypeWarning border:AndesBadgeBorderStandard size:AndesBadgeSizeLarge text:@"WARNING"];;
    [stack addArrangedSubview:view];
    
    view = [[AndesBadge alloc] initWithModifier:AndesBadgeModifierPill hierarchy:hierarchy type:AndesBadgeTypeError border:AndesBadgeBorderStandard size:AndesBadgeSizeLarge text:@"ERROR"];;
    [stack addArrangedSubview:view];
}

@end
