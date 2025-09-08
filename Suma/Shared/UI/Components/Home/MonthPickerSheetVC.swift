//
//  MonthPickerSheetVC.swift
//  Suma
//
//  Created by Pavel Pavel on 07/09/2025.
//
import UIKit

final class MonthPickerSheetVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private let months: [(String, Int)]
    private let initialIndex: Int
    private let onDone: (Int) -> Void
    
    private let picker = UIPickerView()
    
    init(months: [(String, Int)], selectedIndex: Int, onDone: @escaping (Int) -> Void) {
        self.months = months
        self.initialIndex = selectedIndex
        self.onDone = onDone
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let bar = UIToolbar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let flex = UIBarButtonItem(systemItem: .flexibleSpace)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        bar.items = [cancel, flex, done]

        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(bar)
        view.addSubview(picker)

        NSLayoutConstraint.activate([
            bar.topAnchor.constraint(equalTo: view.topAnchor),
            bar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            picker.topAnchor.constraint(equalTo: bar.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        picker.selectRow(initialIndex, inComponent: 0, animated: false)

        if let sheet = presentationController as? UISheetPresentationController {
            if #available(iOS 16.0, *) {
                let detent = UISheetPresentationController.Detent.custom(identifier: .init("fixed")) { _ in 250 }
                sheet.detents = [detent]
            } else {
                sheet.detents = [.medium(), .large()]
            }
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 16
        }
    }

    @objc private func cancel() { dismiss(animated: true) }
    @objc private func done() {
        onDone(picker.selectedRow(inComponent: 0))
        dismiss(animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { months.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { months[row].0 }
}
