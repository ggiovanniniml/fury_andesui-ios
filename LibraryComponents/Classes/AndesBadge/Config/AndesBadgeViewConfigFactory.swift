//
//  AndesBadgeViewConfigFactory.swift
//  AndesUI
//
//  Created by Ignacio Guri on 20/03/2020.
//

import Foundation

internal class AndesBadgeViewConfigFactory {
    static func provideInternalConfig(from badge: AndesBadge) -> AndesBadgeViewConfig {
        let typeIns = AndesBadgeTypeFactory.provide(badge.type)
        let hierarchyIns = AndesBadgeHierarchyFactory.provide(badge.hierarchy, forType: typeIns)

        var config = AndesBadgeViewConfig(backgroundColor: hierarchyIns.backgroundColor)

        if badge.modifier == .pill, let pillText = badge.text {
            config = AndesBadgeViewConfig(backgroundColor: hierarchyIns.backgroundColor, text: pillText, size: badge.size, textColor: hierarchyIns.textColor, border: badge.border)
        }

        return config
    }
}
