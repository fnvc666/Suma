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
    private(set) var totalAmount: Double = 0
    private(set) var currency: String = "USD"
    private var selectedGradient = "GreenGradient"
    
    // Form Section
    var onNameChanged: ((String) -> Void)?
    var onAmountChanged: ((Double) -> Void)?
    var onCurrencyChanged: ((String) -> Void)?
    
    var onGradinetsUpdate: ((String) -> Void)?
    var onClose: (() -> Void)?
    var onAdded: (() -> Void)?
    
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
        if let val = Double(norm) {
            totalAmount = val
            onAmountChanged?(val)
        }
        
    }
    
    func setTotalAmount(_ text: String) {
        if let text = Double(text) {
            totalAmount = text
            onAmountChanged?(text)
        }
    }
    
    func setCurrency(_ newCurrency: String) {
        currency = newCurrency
        onCurrencyChanged?(newCurrency)
    }
    
    // Inputs <- View
    func viewDidLoad() {
    }
    
    func closeTapped() { onClose?() }
    func addTapped() {
        Task {
            do {
                let count = try await categories.listAll().count
                let number = String(format: "%02d", count + 1)

                let model = Category(
                    id: UUID(),
                    number: number,
                    name: name,
                    budget: totalAmount,
                    current: 0,
                    gradient: selectedGradient,
                    currency: currency
                )

                try await categories.create(model)
                await MainActor.run { onAdded?() }
            } catch {
                print("addTapped error:", error)
            }
        }
    }

}
