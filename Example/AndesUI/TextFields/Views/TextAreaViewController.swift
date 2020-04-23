//
//  TextAreaViewController.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 4/15/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

class TextAreaViewController: UIViewController {
    @IBOutlet weak var textField: AndesTextArea!
    @IBOutlet weak var configToggleButton: AndesButton!
    @IBOutlet weak var stateTField: UITextField!
    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var placeholderField: UITextField!
    @IBOutlet weak var helperField: UITextField!
    @IBOutlet weak var counterField: UITextField!
    @IBOutlet weak var configView: UIView!
    @IBOutlet weak var updateButton: AndesButton!

    var statePicker: UIPickerView = UIPickerView()
    var typePicker: UIPickerView = UIPickerView()
    var state: AndesTextFieldState = .idle

    var rightComponents: [String: () -> AndesTextFieldRightComponent?] {
        return [
            "None": { return nil },
            "Sufijo": { return AndesTextFieldComponentLabel(text: "Sufix")},
            "Icon": { return AndesTextFieldComponentIcon(andesIconName: "andes_ui_feedback_info_16", tintColor: UIColor.red)},
            "Clear": { return AndesTextFieldComponentClear() },
            "Action": { return AndesTextFieldComponentAction("Action A") }
        ]
    }

    var textTriggers: [String: () -> Void] {
        return [
            "ERROR": { [weak self] in self?.textField.state = .error },
            "ERRO": { [weak self] in self?.textField.state = .idle },
            "DISABLED": { [weak self] in self?.textField.state = .disabled },
            "DISABL": { [weak self] in self?.textField.state = .idle },
            "READ": { [weak self] in self?.textField.state = .readOnly },
            "REA": { [weak self] in self?.textField.state = .idle }
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        createPickerViews()
        createTextViews()
        setupUI()
    }

    func setupUI() {
        configView.isHidden = true
        textField.delegate = self
    }

    fileprivate func setupButtons() {
        updateButton.setText("message.button.updateConfig".localized)
        .setHierarchy(.loud)
        .setSize(.large)
        configToggleButton.setText("message.button.changeConfig".localized)
        .setHierarchy(.quiet)
        .setSize(.medium)
    }

    func createPickerViews() {
        stateTField.inputView = statePicker
        statePicker.delegate = self
        statePicker.dataSource = self
    }

    func createTextViews() {
        counterField.delegate = self
    }

    @IBAction func updateBtnTapped(_ sender: Any) {
        let counter: UInt16 = UInt16(counterField.text!) ?? 0
           textField.counter = counter
           textField.label = self.labelField.text
           textField.placeholder = self.placeholderField.text
           textField.helper = self.helperField.text
           textField.state = self.state
    }

    @IBAction func toggleConfigTapped(_ sender: Any) {
        if !self.configView.isHidden {
            self.configToggleButton.setText("message.button.changeConfig".localized)
                .setHierarchy(.quiet)

        } else {
            self.configToggleButton.setText("message.button.hideConfig".localized)
                .setHierarchy(.transparent)

        }

        UIView.transition(with: configView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.configView.isHidden = !self.configView.isHidden
        }, completion: nil)
    }
}

extension TextAreaViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            self.stateTField.resignFirstResponder()
            self.state = AndesTextFieldState.init(rawValue: row)!
            stateTField.text = state.toString()
        }
    }
}

extension TextAreaViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return 4
        }
        if pickerView == typePicker {
            return 2
        }
        return 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == statePicker {
            let state = AndesTextFieldState.init(rawValue: row)!
            return state.toString()
        }
        return ""
    }
}

extension TextAreaViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
          -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension TextAreaViewController: AndesTextAreaDelegate {
    func andesTextAreaDidChange(_ textField: AndesTextArea) {
        let str = textField.text.uppercased()
        textTriggers[str]?()
    }
}
