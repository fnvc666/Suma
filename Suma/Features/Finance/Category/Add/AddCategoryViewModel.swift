//
//  AddCategoryViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

final class AddCategoryViewModel {
    private let categories: CategoriesRepositoryProtocol
    
    init(categories: CategoriesRepositoryProtocol) {
        self.categories = categories
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    // Inputs <- View
    func viewDidLoad() {}
    
    func closeTapped() { onClose?() }
    func saveTapped() { onSaved?() }
}
