# Unpublished
## Added
- AndesBadge: Pill modifier.
- AndesTextField
- AndesTextArea
- Public enums support string conversion (Swift only)
- Added icons to LocalIcons: [#49](https://github.com/mercadolibre/fury_andesui-ios/pull/49#issue-407571410)

## Optimized
- internal factories don't store anything.

# v2.1.5:
## Changed
- Temporary removal of ios11 color strategy for issue loading bundle with new build system

# v2.1.4:
## Fixed
- AndesIconsProvider loadIcon signature fix. (success callbacks gets a non nullable UIImage instead of nullable)

# Sin Publicar:
## Changed
- How the bundle is loaded.

# v2.1.3:
## Fixed
- Change access level to AndesIconsProvider methods 

# v2.1.2:
## Fixed
- (iOS 10) mp accent colors
- AndesMessage line height in body
## Added 
- Local icons added to assets
## Changed
- CocoaPods URL repo spec in order to use CDN

# v2.1.0:
## Added:
- Missing feedback colors on stylesheet

# v2.0.0:
## Changed
- AndesStylesheet updated to latest definitions
- AndesMessage: fixes in constraints when dismiss is hidden
- AndesMessage: updated button colors to new definition

## Added
- AndesIconsProvider with local strategy to load icons from xcassets

# v1.3.1:
## Changed
- AndesMessage: fixed background quiet color.

# v1.3.0
## Added
- AndesMessage: Support message with actions, primary and secondary.

# v1.2.1
## Changed
- AndesMessage: changed body from semibold to regular.

# v1.2.0
## Changed
- AndesButton now exposes getters for properties
- AndesMessageHierarchy changed highlight to neutral

# v1.1.1
## Fixed
- AndesMessage: when title is nil or empty center the body of the message.
- Fixed compile issues on xcode 10.2.1

# v1.1.0
- AndesMessage basic
- AndesMessage dismissible

# v1.0.0
## Added
- AndesButton
- AndesStylesheet
- Dark mode support
