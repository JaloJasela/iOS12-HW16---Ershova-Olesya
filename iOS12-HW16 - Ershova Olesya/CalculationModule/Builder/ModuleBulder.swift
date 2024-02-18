//
//  Builder.swift
//  iOS12-HW16 - Ershova Olesya
//
//  Created by IMac on 19.02.2024.
//

import UIKit

class ModuleBulder {
    static func mainModule() -> UIViewController {
        let view = MainModuleViewController()
        let model = Model()
        let presenter = MainModulePresenter(view: view, model: model)
        view.presenter = presenter

        return view
    }
}
