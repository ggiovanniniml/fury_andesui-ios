//
//  AndesMessage.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 1/13/20.
//

import UIKit

@objc public class AndesMessage: UIView {
    internal var contentView: AndesMessageView!
    /// returns the current hierarchy
    public private(set) var hierarchy: AndesMessageHierarchy = .loud

    /// returns the current type
    public private(set) var type: AndesMessageType = .neutral

    /// returns the current title
    public private(set) var title: String?

    /// returns the current message body
    public private(set) var body: String = ""

    /// returns true if the message is dismissable by user
    public private(set) var isDismissable: Bool = false

    /// returns the current primary action text
    public private(set) var primaryActionText: String?

    /// returns the current secondary action text
    public private(set) var secondaryActionText: String?

    private var dismissHandler: ((_ message: AndesMessage) -> Void)?
    private var onPrimaryActionPressed: ((_ message: AndesMessage) -> Void)?
    private var onSecondaryActionPressed: ((_ message: AndesMessage) -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(hierarchy: AndesMessageHierarchy, type: AndesMessageType, title: String, body: String) {
        super.init(frame: .zero)
        self.title = title
        self.body = body
        self.hierarchy = hierarchy
        self.type = type
        setup()
    }

    private func drawContentView(with newView: AndesMessageView) {
        self.contentView = newView
        contentView.delegate = self
        addSubview(contentView)
        leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    /// Check if view needs to be redrawn, and then update it. This method should be called on all modifiers that may need to change which internal view should be rendered
    private func reDrawContentViewIfNeededThenUpdate() {
        let newView = provideView()
        if Swift.type(of: newView) !== Swift.type(of: contentView) {
            contentView.removeFromSuperview()
            drawContentView(with: newView)
        }
        updateContentView()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func updateContentView() {
        let config = AndesMessageViewConfigFactory.provideConfig(for: self)
        contentView.update(withConfig: config)
    }

    /// Sets the title of the AndesMessage
    /// - Parameter title: string
    @objc @discardableResult public func setTitle(_ title: String?) -> AndesMessage {
        self.title = title
        updateContentView()
        return self
    }

    /// Sets the body of the AndesMessage
    /// - Parameter body: message body
    @objc @discardableResult public func setBody(_ body: String) -> AndesMessage {
        self.body = body
        updateContentView()
        return self
    }

    /// Sets the style of the message
    /// - Parameter hierarchy: options defined in AndesMessageHierarchy
    @objc @discardableResult public func setHierarchy(_ hierarchy: AndesMessageHierarchy) -> AndesMessage {
        self.hierarchy = hierarchy
        updateContentView()
        return self
    }

    /// Sets the colors/icon of the message
    /// - Parameter type: defined in AndesMessageType
    @objc @discardableResult public func setType(_ type: AndesMessageType) -> AndesMessage {
        self.type = type
        updateContentView()
        return self
    }

    /// shows or hides the dismiss button
    @objc @discardableResult public func setDismissable(_ dismissable: Bool) -> AndesMessage {
          self.isDismissable = dismissable
          updateContentView()
          return self
      }

    /// handler to trigger when the user dismisses the message
    /// - Parameter handler: dismiss handler
    @objc @discardableResult public func onDismiss(_ callback: ((_ message: AndesMessage) -> Void)?) -> AndesMessage {
        self.dismissHandler = callback
        return self
    }

    /// Primary action, when defined with a title a button will show on the message
    /// - Parameters:
    ///   - title: Button text
    ///   - handler: handler to trigger when button pressed
    @objc @discardableResult public func setPrimaryAction(_ title: String, handler: ((_ message: AndesMessage) -> Void)?) -> AndesMessage {
        self.primaryActionText = title
        self.onPrimaryActionPressed = handler
        reDrawContentViewIfNeededThenUpdate()
        return self
    }

    /// Actions that shows oly if primary action defined.
    /// - Parameters:
    ///   - title: Button text
    ///   - handler: handler to trigger when button pressed
    @objc @discardableResult public func setSecondaryAction(_ title: String, handler: ((_ message: AndesMessage) -> Void)?) -> AndesMessage {
        self.secondaryActionText = title
        self.onSecondaryActionPressed = handler
        reDrawContentViewIfNeededThenUpdate()
        return self
    }

    /// Should return a view depending on which message variant is selected
    private func provideView() -> AndesMessageView {
        let config = AndesMessageViewConfigFactory.provideConfig(for: self)

        if let pText = primaryActionText, !pText.isEmpty {
            return AndesMessageWithActionsView(withConfig: config)
        } else {
            return AndesMessageDefaultView(withConfig: config)
        }
    }
}

extension AndesMessage: AndesMessageViewDelegate {
    func dismissTapped() {
        self.isHidden = true
        dismissHandler?(self)
    }

    func primaryBtnTouchUp() {
        onPrimaryActionPressed?(self)
    }

    func secondaryBtnTouchUp() {
        onSecondaryActionPressed?(self)
    }
}
