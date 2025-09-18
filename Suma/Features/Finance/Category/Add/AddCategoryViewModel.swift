//
//  AddCategoryViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

final class AddCategoryViewModel {
    private let categories: CategoriesRepositoryProtocol
    
    private(set) var name: String = ""
    private(set) var totalAmount: Decimal = 0
    private var selectedGradient = "GreenGradient"
    
    // Form Section
    var onNameChanged: ((String) -> Void)?
    var onAmountChanged: ((Decimal) -> Void)?
    
    var onGradinetsUpdate: ((String) -> Void)?
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    init(categories: CategoriesRepositoryProtocol) {
        self.categories = categories
    }
    
    func setGradient(_ gradient: String) {
        selectedGradient = gradient
    }
    
    func setName(_ newName: String) {
        name = newName
        onNameChanged?(newName)
    }
    
    func setAmount(_ newAmount: String) {
        let norm = newAmount.replacingOccurrences(of: ",", with: ".")
        if let val = Decimal(string: norm) {
            totalAmount = val
            onAmountChanged?(val)
        }
        
    }
    
    func setTotalAmount(_ text: String) {
        if let text = Decimal(string: text) {
            totalAmount = text
            onAmountChanged?(text)
        }
    }
    
    // Inputs <- View
    func viewDidLoad() {}
    
    func closeTapped() { onClose?() }
    func saveTapped() { onSaved?() }
}
