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
    private(set) var draft: Category
    
    var category: Category?
    
    var onFetch: ((Category) -> Void)?
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    init(categoryId: UUID, categories: CategoriesRepositoryProtocol, initial: Category?) {
        self.categoryId = categoryId
        self.categories = categories
        self.draft = initial ?? Category(id: categoryId, number: "00", name: "", budget: 0, current: 0, gradient: "GreenGradient", currency: "test")
    }
    
    @MainActor
    func viewDidLoad() {
        fetchCategory()
    }
    
    private func fetchCategory() {
        Task {
            if let actual = try? await categories.get(by: categoryId), actual != category {
                category = actual
                onFetch?(actual)
            }
        }
    }
    
    func closeTapped() { onClose?() }
    
    func saveTapped() {
        Task {
            do {
                let model = Category(
                    id: categoryId,
                    number: draft.number,
                    name: draft.name,
                    budget: draft.budget,
                    current: draft.current,
                    gradient: draft.gradient,
                    currency: draft.currency)
                
                try await categories.update(model)
                await MainActor.run { onSaved?() }
            } catch {
                print("saveTapped error:", error)
            }
        }
    }
    
    func setName(_ name: String)          { draft.name = name }
    func setBudgetString(_ text: String)  {
        let norm = text.replacingOccurrences(of: ",", with: ".")
        if let val = Double(norm) { draft.budget = val }
    }
    func setCurrency(_ c: String)         { draft.currency = c }
    func setGradient(_ g: String)         { draft.gradient = g }
}
