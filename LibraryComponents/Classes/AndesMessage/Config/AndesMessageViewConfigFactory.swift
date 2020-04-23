//
//  AndesMessageViewConfigFactory.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 1/22/20.
//

import Foundation
internal class AndesMessageViewConfigFactory {
    static func provideConfig(for message: AndesMessage) -> AndesMessageViewConfig {
        let typeIns = AndesMessageTypeFactory.provide(message.type)
        let hierarchyIns = AndesMessageHierarchyFactory.provide(message.hierarchy, forType: typeIns)

        var config = AndesMessageViewConfig(backgroundColor: hierarchyIns.backgroundColor, pipeColor: hierarchyIns.pipeColor, textColor: hierarchyIns.textColor, titleText: message.title, bodyText: message.body, icon: typeIns.icon, iconBackgroundColor: hierarchyIns.accentColor, isDismissable: message.isDismissable, dismissIconColor: hierarchyIns.textColor)

        if let primaryText = message.primaryActionText {
            config.primaryActionConfig = AndesButtonViewConfigFactory.provide(hierarchy: hierarchyIns.primaryButtonHierarchy, size: AndesButtonSizeMedium(), text: primaryText, icon: nil)
        }

        if let secondaryText = message.secondaryActionText {
            config.secondaryActionConfig = AndesButtonViewConfigFactory.provide(hierarchy: hierarchyIns.secondaryButtonHierarchy, size: AndesButtonSizeMedium(), text: secondaryText, icon: nil)
        }

        return config
    }
}
