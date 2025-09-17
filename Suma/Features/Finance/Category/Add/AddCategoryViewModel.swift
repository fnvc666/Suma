//
//  AddCategoryViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

final class AddCategoryViewModel {
    private let categories: CategoriesRepositoryProtocol
    
    var onGradinetsUpdate: ((String) -> Void)?
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    private var selectedGradient = "GreenGradient"
    private let name = ""
    private let totalAmount = 0
    
    init(categories: CategoriesRepositoryProtocol) {
        self.categories = categories
    }
    
    func setGradient(_ gradient: String) {
        selectedGradient = gradient
    }
    
    
    // Inputs <- View
    func viewDidLoad() {}
    
    func closeTapped() { onClose?() }
    func saveTapped() { onSaved?() }
}
