//
//  EditCategoryViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

final class EditCategoryViewModel {
    private let categoryId: UUID
    private var categories: CategoriesRepositoryProtocol
    
    init(categoryId: UUID, categories: CategoriesRepositoryProtocol) {
        self.categoryId = categoryId
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
