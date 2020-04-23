//
//  BadgeViewController.swift
//  AndesUI-demoapp
//

import UIKit
import AndesUI

protocol BadgeView: NSObject {

}

class BadgeViewController: UIViewController, BadgeView {

    @IBOutlet weak var badgeView: AndesBadge!
    @IBOutlet weak var updateButton: AndesButton!

    @IBOutlet weak var modifierField: UITextField!
    var modifierPicker: UIPickerView = UIPickerView()
    var modifier: AndesBadgeModifier = .pill

    @IBOutlet weak var hierarchyField: UITextField!
    var hierarchyPicker: UIPickerView = UIPickerView()
    var hierarchy: AndesBadgeHierarchy = .loud

    @IBOutlet weak var typeField: UITextField!
    var typePicker: UIPickerView = UIPickerView()
    var type: AndesBadgeType = .neutral

    @IBOutlet weak var sizeField: UITextField!
    var sizePicker: UIPickerView = UIPickerView()
    var size: AndesBadgeSize = .small

    @IBOutlet weak var borderField: UITextField!
    var borderPicker: UIPickerView = UIPickerView()
    var border: AndesBadgeBorder = .standard

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.text = "DEMO"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBaseBadge()
        setupUpdateButton()
        createPickerViews()
    }

    func setupBaseBadge() {
        badgeView.text = self.textField.text
        badgeView.hierarchy = self.hierarchy
        badgeView.type = self.type
        badgeView.size = self.size
        badgeView.border = self.border
    }

    func setupUpdateButton() {
        updateButton.setSize(.large)
        updateButton.setHierarchy(.loud)
        updateButton.setText("badge.button.updateConfig".localized)
    }

    func createPickerViews() {
        modifierField.inputView = modifierPicker
        modifierField.text = self.modifier.toString()
        modifierPicker.delegate = self
        modifierPicker.dataSource = self

        hierarchyField.inputView = hierarchyPicker
        hierarchyField.text = self.hierarchy.toString()
        hierarchyPicker.delegate = self
        hierarchyPicker.dataSource = self

        typeField.inputView = typePicker
        typeField.text = self.type.toString()
        typePicker.delegate = self
        typePicker.dataSource = self

        sizeField.inputView = sizePicker
        sizeField.text = self.size.toString()
        sizePicker.delegate = self
        sizePicker.dataSource = self

        borderField.inputView = borderPicker
        borderField.text = self.border.toString()
        borderPicker.delegate = self
        borderPicker.dataSource = self
    }

    @IBAction func updateButtonTouched(_ sender: Any) {
        setupBaseBadge()
    }

}

extension BadgeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case modifierPicker:
            modifierField.resignFirstResponder()
            self.modifier = AndesBadgeModifier.init(rawValue: row)!
            modifierField.text = modifier.toString()
        case hierarchyPicker:
            hierarchyField.resignFirstResponder()
            self.hierarchy = AndesBadgeHierarchy.init(rawValue: row)!
            hierarchyField.text = hierarchy.toString()
        case typePicker:
            typeField.resignFirstResponder()
            self.type = AndesBadgeType.init(rawValue: row)!
            typeField.text = type.toString()
        case sizePicker:
            sizeField.resignFirstResponder()
            self.size = AndesBadgeSize.init(rawValue: row)!
            sizeField.text = size.toString()
        case borderPicker:
            borderField.resignFirstResponder()
            self.border = AndesBadgeBorder.init(rawValue: row)!
            borderField.text = border.toString()
        default:
            return
        }
    }
}

extension BadgeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case modifierPicker:
            return 1
        case hierarchyPicker:
            return 2
        case typePicker:
            return 5
        case sizePicker:
            return 2
        case borderPicker:
            return 3
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case modifierPicker:
            return AndesBadgeModifier.init(rawValue: row)!.toString()
        case hierarchyPicker:
            return AndesBadgeHierarchy.init(rawValue: row)!.toString()
        case typePicker:
            return AndesBadgeType.init(rawValue: row)!.toString()
        case sizePicker:
            return AndesBadgeSize.init(rawValue: row)!.toString()
        case borderPicker:
            return AndesBadgeBorder.init(rawValue: row)!.toString()
        default:
            return ""
        }
    }
}

extension AndesBadgeModifier {
    func toString() -> String {
        switch self {
        case .pill:
            return "Pill"
        }
    }
}

extension AndesBadgeHierarchy {
    func toString() -> String {
        switch self {
        case .loud:
            return "Loud"
        case .quiet:
            return "Quiet"
        }
    }
}

extension AndesBadgeType {
    func toString() -> String {
        switch self {
        case .neutral:
            return "Neutral"
        case .success:
            return "Success"
        case .error:
            return "Error"
        case .warning:
            return "Warning"
        case .highlight:
            return "Highlight"
        }
    }
}

extension AndesBadgeSize {
    func toString() -> String {
        switch self {
        case .large:
            return "Large"
        case .small:
            return "Small"
        }
    }
}

extension AndesBadgeBorder {
    func toString() -> String {
        switch self {
        case .standard:
            return "Standard"
        case .corner:
            return "Corner"
        case .rounded:
            return "Rounded"
        }
    }
}
