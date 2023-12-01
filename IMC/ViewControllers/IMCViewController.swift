//
//  IMCViewController.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 19/11/21.
//

import UIKit

class IMCViewController: UIViewController{
    enum TextFieldTags: Int, CaseIterable {
        case massTextfield, heightTextfield
    }
    
    // MARK: - PUBLIC PROPERTIES
    
    var viewModel: IMCViewModelProtocol
    
    // MARK: - UI
    
    @TemplateView var IMCtitle: UILabel
    @TemplateView var massTextField: UITextField
    @TemplateView var heightTextField: UITextField
    @TemplateView var calculateButton: UIButton
    @TemplateView var vc2Button: UIButton
    @TemplateView var subtitleResultLabel: UILabel
    @TemplateView var imageResult: UIImageView
    @TemplateView var verticalScrollView: UIScrollView
    @TemplateView var containerView: UIView
    
    // MARK: - LIFE CYCLE
    
    init(_ viewModel: IMCViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupContraints()
        setupUIConfiguration()
        dismissKeyboard()
    }
    
    // MARK: - SETUP
    
    func addSubViews(){
        view.addSubview(verticalScrollView)
        
        verticalScrollView.addSubview(containerView)
        
        containerView.addSubview(IMCtitle)
        containerView.addSubview(massTextField)
        containerView.addSubview(heightTextField)
        containerView.addSubview(calculateButton)
        containerView.addSubview(vc2Button)
        containerView.addSubview(subtitleResultLabel)
        containerView.addSubview(imageResult)
        
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            
            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor),
            
            IMCtitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 64),
            IMCtitle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            massTextField.topAnchor.constraint(equalTo: IMCtitle.bottomAnchor, constant: 32),
            massTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            massTextField.widthAnchor.constraint(equalToConstant: 152),
            massTextField.heightAnchor.constraint(equalToConstant: 40),
            
            heightTextField.topAnchor.constraint(equalTo: massTextField.bottomAnchor,constant: 16),
            heightTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightTextField.widthAnchor.constraint(equalToConstant: 152),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            
            calculateButton.topAnchor.constraint(equalTo: heightTextField.bottomAnchor,constant: 32),
            calculateButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            calculateButton.widthAnchor.constraint(equalToConstant: 128),
            calculateButton.heightAnchor.constraint(equalToConstant: 32),
            
            vc2Button.topAnchor.constraint(equalTo: calculateButton.bottomAnchor,constant:32),
            vc2Button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            vc2Button.widthAnchor.constraint(equalToConstant: 128),
            vc2Button.heightAnchor.constraint(equalToConstant: 32),
            
            subtitleResultLabel.widthAnchor.constraint(equalToConstant: 150),
            subtitleResultLabel.topAnchor.constraint(equalTo: vc2Button.bottomAnchor, constant: 32),
            subtitleResultLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            imageResult.topAnchor.constraint(equalTo: subtitleResultLabel.bottomAnchor, constant: 32),
            imageResult.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageResult.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 40)
        ])
    }
    
    func setupUIConfiguration(){
        view.backgroundColor = .red
        
        verticalScrollView.backgroundColor = .systemIndigo
        
        IMCtitle.textAlignment = .center
        IMCtitle.font = UIFont(name: "HelveticaNeue", size: 30)
        IMCtitle.backgroundColor = .systemYellow
        IMCtitle.text = "IMC"
        IMCtitle.tintColor = .black
        
        massTextField.tag = TextFieldTags.massTextfield.rawValue
        massTextField.backgroundColor = .systemGray2
        massTextField.tintColor = .black
        massTextField.placeholder = "Massa(kg)"
        massTextField.textAlignment = .center
        massTextField.keyboardType = UIKeyboardType.numberPad
        massTextField.delegate = self
    
        heightTextField.tag = TextFieldTags.heightTextfield.rawValue
        heightTextField.backgroundColor = .systemGray2
        heightTextField.tintColor = .black
        heightTextField.placeholder = "Altura(cm)"
        heightTextField.textAlignment = .center
        heightTextField.keyboardType = UIKeyboardType.numberPad
        heightTextField.delegate = self
        
        calculateButton.backgroundColor = .systemTeal
        calculateButton.setTitle("Calcular", for: .normal)
        calculateButton.tintColor = .black
        calculateButton.layer.cornerRadius = 5
        calculateButton.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
        
        subtitleResultLabel.textAlignment = .center
        subtitleResultLabel.backgroundColor = .systemYellow
        subtitleResultLabel.tintColor = .black
        subtitleResultLabel.text = "Resultado"
        subtitleResultLabel.isHidden = true
        
        imageResult.contentMode = .scaleAspectFill
        
        vc2Button.backgroundColor = .systemTeal
        vc2Button.setTitle("Converter", for: .normal)
        vc2Button.layer.cornerRadius = 5
        vc2Button.tintColor = .black
        vc2Button.addTarget(self, action: #selector(didTapButtonVC2), for: .touchUpInside)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func dismissKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func willDisplayAnErrorHandlerMessage(){
        let alert = UIAlertController(title: "Erro nos dados", message: "Algo errado aconteceu. \nConfira seus dados.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    
    // MARK: - ACTIONS
    
    @objc private func didTapCalculateButton() {
        view.endEditing(true) 
        let result = viewModel.calculateButtonPressed()
        
        switch result {
        case .success((let name, let imageName)):
            subtitleResultLabel.text = name
            imageResult.image = UIImage(named: imageName)
            subtitleResultLabel.isHidden = false
            
        case .failure:
            willDisplayAnErrorHandlerMessage()
            
        }
    }
    
    @objc private func didTapButtonVC2() {
        view.endEditing(true)
        viewModel.converterButtonPressed { [weak self ] _ in
            self?.willDisplayAnErrorHandlerMessage()
        }
    }
}

// MARK: - EXTESIONS

extension IMCViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        guard let newValue = textField.text else { return }
    
        switch textField.tag {
        case TextFieldTags.heightTextfield.rawValue:
            viewModel.userDidUpdateHeitgh(newValue: newValue)
            
        case TextFieldTags.massTextfield.rawValue:
            viewModel.userDidUpdateMass(newValue: newValue)
        default:
            return
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacteres = CharacterSet(charactersIn: "01234567890.").inverted
        return string.rangeOfCharacter(from: invalidCharacteres) == nil
    }
}


