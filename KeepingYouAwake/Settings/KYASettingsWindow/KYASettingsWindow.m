//
//  KYASettingsWindow.m
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 18.06.23.
//  Copyright © 2023 Marcel Dierkes. All rights reserved.
//

#import "KYASettingsWindow.h"
#import <KYACommon/KYACommon.h>
#import "KYASettingsLocalizedStrings.h"
#import "KYAGeneralSettingsViewController.h"
#import "KYADurationSettingsViewController.h"
#import "KYABatterySettingsViewController.h"
#import "KYAAdvancedSettingsViewController.h"
#import "KYAAboutSettingsViewController.h"

@interface KYASettingsWindow ()
@end

@implementation KYASettingsWindow

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    return [self initWithAdditionalTabViewItems:nil];
}

- (instancetype)initWithAdditionalTabViewItems:(NSArray<NSTabViewItem *> *)tabViewItems
{
    Auto mutableTabViewItems = [NSMutableArray<NSTabViewItem *> arrayWithArray:@[
        KYAGeneralSettingsViewController.preferredTabViewItem,
        KYADurationSettingsViewController.preferredTabViewItem,
        KYABatterySettingsViewController.preferredTabViewItem,
        KYAAdvancedSettingsViewController.preferredTabViewItem,
    ]];
    if(tabViewItems != nil)
    {
        [mutableTabViewItems addObjectsFromArray:tabViewItems];
    }
    [mutableTabViewItems addObject:KYAAboutSettingsViewController.preferredTabViewItem];
    
    Auto tabViewController = [NSTabViewController new];
    tabViewController.tabStyle = NSTabViewControllerTabStyleToolbar;
    tabViewController.transitionOptions = NSViewControllerTransitionNone;
    tabViewController.tabViewItems = [mutableTabViewItems copy];
    
    CGRect frame = CGRectMake(150.0f, 430.0f, 480.0f, 320.0f);
    NSWindowStyleMask styleMask = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable;
    NSWindowCollectionBehavior behavior = NSWindowCollectionBehaviorManaged | NSWindowCollectionBehaviorParticipatesInCycle | NSWindowCollectionBehaviorFullScreenNone;
    
    self = [[self class] windowWithContentViewController:tabViewController];
    if(self)
    {
        self.styleMask = styleMask;
        self.collectionBehavior = behavior;
        self.title = KYA_SETTINGS_L10N_TITLE;
        
        [self setFrame:frame display:NO];
        self.frameAutosaveName = @"PreferencesWindow";
    }
    return self;
}
#pragma clang diagnostic pop

#pragma mark - NSResponder

- (void)keyDown:(NSEvent *)event
{
    if(event.type != NSEventTypeKeyDown) { return; }
    if((event.modifierFlags & NSEventModifierFlagCommand) == 0) { return; }
    
    if([event.characters isEqualToString:@"q"])
    {
        [NSApplication.sharedApplication terminate:self];
    }
    if([event.characters isEqualToString:@"w"])
    {
        [self close];
    }
}

@end
