//
//  ViewController.swift
//  iOS12-HW16 - Ershova Olesya
//
//  Created by IMac on 19.02.2024.
//

import UIKit

class MainModuleViewController: UIViewController {
    
    var presenter: MainModulePresenterProtocol!
    
    // MARK: - Outlets
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var textFieldOne: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 18
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var textFieldTwo: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 18
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var textFieldResult: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 18
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.isEnabled = false
        textField.placeholder = "Результат"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var buttonAddition: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 18
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(additionDidTap), for: .touchUpInside)
        button.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonSubtraction: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 18
        button.setTitle("-", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(subtractionDidTap), for: .touchUpInside)
        button.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonMultiplication: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 18
        button.setTitle("*", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(multiplicationDidTap), for: .touchUpInside)
        button.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonDivision: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 18
        button.setTitle("/", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(divisionDidTap), for: .touchUpInside)
        button.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        registerKeyboard()
    }
    
    deinit {
        removeKeyboard()
    }
    
    // MARK: - Setups
    
    private func registerKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupHierarchy() {[
            scrollView,
            textFieldOne,
            textFieldTwo,
            textFieldResult,
            buttonAddition,
            buttonSubtraction,
            buttonMultiplication,
            buttonDivision,
        ].forEach{view.addSubview($0)}
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            textFieldOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textFieldOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldOne.heightAnchor.constraint(equalToConstant: 40),
            
            textFieldTwo.topAnchor.constraint(equalTo: textFieldOne.bottomAnchor, constant: 10),
            textFieldTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldTwo.heightAnchor.constraint(equalToConstant: 40),
            
            textFieldResult.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldResult.heightAnchor.constraint(equalToConstant: 40),
            textFieldResult.topAnchor.constraint(equalTo: textFieldTwo.bottomAnchor, constant: 10),
            
            buttonAddition.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonAddition.topAnchor.constraint(equalTo: textFieldResult.bottomAnchor, constant: 20),
            buttonAddition.heightAnchor.constraint(equalToConstant: 40),
            
            buttonSubtraction.leadingAnchor.constraint(equalTo: buttonAddition.trailingAnchor, constant: 20),
            buttonSubtraction.topAnchor.constraint(equalTo: textFieldResult.bottomAnchor, constant: 20),
            buttonSubtraction.heightAnchor.constraint(equalToConstant: 40),
            buttonSubtraction.widthAnchor.constraint(equalTo: buttonAddition.widthAnchor),
            
            buttonMultiplication.leadingAnchor.constraint(equalTo: buttonSubtraction.trailingAnchor, constant: 20),
            buttonMultiplication.topAnchor.constraint(equalTo: textFieldResult.bottomAnchor, constant: 20),
            buttonMultiplication.heightAnchor.constraint(equalToConstant: 40),
            buttonMultiplication.widthAnchor.constraint(equalTo: buttonSubtraction.widthAnchor),
            
            buttonDivision.leadingAnchor.constraint(equalTo: buttonMultiplication.trailingAnchor, constant: 20),
            buttonDivision.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonDivision.topAnchor.constraint(equalTo: textFieldResult.bottomAnchor, constant: 20),
            buttonDivision.heightAnchor.constraint(equalToConstant: 40),
            buttonDivision.widthAnchor.constraint(equalTo: buttonMultiplication.widthAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func additionDidTap() {
        self.presenter.addition(one: textFieldOne.text ?? "", two: textFieldTwo.text ?? "")
    }
    
    @objc func subtractionDidTap() {
        self.presenter.subtraction(one: textFieldOne.text ?? "", two: textFieldTwo.text ?? "")
    }
    
    @objc func multiplicationDidTap() {
        self.presenter.multiplication(one: textFieldOne.text ?? "", two: textFieldTwo.text ?? "")
    }
    
    @objc func divisionDidTap() {
        self.presenter.division(one: textFieldOne.text ?? "", two: textFieldTwo.text ?? "")
    }
    
    @objc private func calculateTapped() {
        textFieldOne.resignFirstResponder()
        textFieldTwo.resignFirstResponder()
    }
        
    @objc private func keyboardWillShow(notification: NSNotification) {
            let userInfo = notification.userInfo
            let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame?.height ?? CGFloat())
        }
    
    @objc private func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}

extension MainModuleViewController: MainViewProcotol {
    func divisionByZero(result: String) {
        textFieldResult.text = "\(result)"
    }
    
    func setCalcResult(result: Int) {
        textFieldResult.text = "\(result)"
    }
}


