//
//  MainModulePresenter.swift
//  iOS12-HW16 - Ershova Olesya
//
//  Created by IMac on 19.02.2024.
//

import UIKit

protocol MainViewProcotol: AnyObject {
    func setCalcResult(result: Int)
    func divisionByZero(result: String)
}

protocol MainModulePresenterProtocol: AnyObject {
    init(view: MainViewProcotol, model: ModelProtocol)
    func addition(one: String, two: String)
    func subtraction(one: String, two: String)
    func multiplication(one: String, two: String)
    func division(one: String, two: String)
}

final class MainModulePresenter: MainModulePresenterProtocol {
    weak var view: MainViewProcotol?
    var model: ModelProtocol?
    required init(view: MainViewProcotol, model: ModelProtocol) {
        self.view = view
        self.model = model
    }
    
    func addition(one: String, two: String) {
        guard let result = model?.calculation(one: Int(one) ?? 0, two: Int(two) ?? 0, type: .addition) else { return }
        view?.setCalcResult(result: result)
    }
    
    func subtraction(one: String, two: String) {
        guard let result = model?.calculation(one: Int(one) ?? 0, two: Int(two) ?? 0, type: .subtraction) else { return }
        view?.setCalcResult(result: result)
    }
    
    func multiplication(one: String, two: String) {
        guard let result = model?.calculation(one: Int(one) ?? 0, two: Int(two) ?? 0, type: .multiplication) else { return }
        view?.setCalcResult(result: result)
    }
    
    func division(one: String, two: String) {
        if two == "0" {
            view?.divisionByZero(result: "No pasaran!")
        } else {
            guard let result = model?.calculation(one: Int(one) ?? 0, two: Int(two) ?? 0, type: .division) else { return }
            view?.setCalcResult(result: result)
        }
    }
}
