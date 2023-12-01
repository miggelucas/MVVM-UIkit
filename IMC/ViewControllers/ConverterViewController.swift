//
//  ConverterViewController.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 19/11/21.
//

import UIKit
import Combine

class ConverterViewController: UIViewController{
    // MARK: - UI
    
    @TemplateView var slider: UISlider
    @TemplateView var valueOfSliderLabel: UILabel
    @TemplateView var pickerLabel: UILabel
    @TemplateView var converterLabel: UILabel
    @TemplateView var picker: UIPickerView
    @TemplateView var switchConverter: UISwitch
    
    var viewModel: ConverterViewModel
    
    var mass: Double {
        viewModel.mass.value
    }
    
    var height: Double {
        viewModel.height.value
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - LIFE CYCLE
    
    init(_ viewModel: ConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cancellables.forEach { $0.cancel() }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupContraints()
        setupUIConfiguration()
        bindViewModel()
    }
    
    // MARK: - SETUP
    
    func addSubViews(){
        view.addSubview(converterLabel)
        view.addSubview(switchConverter)
        view.addSubview(slider)
        view.addSubview(valueOfSliderLabel)
        view.addSubview(pickerLabel)
        view.addSubview(picker)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            
            converterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            converterLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            converterLabel.widthAnchor.constraint(equalToConstant: 152),
            converterLabel.heightAnchor.constraint(equalToConstant: 40),
            
            switchConverter.topAnchor.constraint(equalTo: converterLabel.bottomAnchor, constant: 16),
            switchConverter.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            slider.topAnchor.constraint(equalTo: switchConverter.bottomAnchor, constant: 16),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            valueOfSliderLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16),
            valueOfSliderLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            valueOfSliderLabel.widthAnchor.constraint(equalToConstant: 152),
            valueOfSliderLabel.heightAnchor.constraint(equalToConstant: 40),
            
            picker.topAnchor.constraint(equalTo: valueOfSliderLabel.bottomAnchor, constant: 16),
            picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            pickerLabel.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 16),
            pickerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pickerLabel.widthAnchor.constraint(equalToConstant: 152),
            pickerLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupUIConfiguration(){
        
        navigationItem.title = "ConverterView"
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(Int(height), inComponent: 0, animated: true)
        
        converterLabel.text = "Kg to Libra:"
        converterLabel.backgroundColor = .yellow
        converterLabel.textColor = .black
        converterLabel.textAlignment = .center
        
        switchConverter.addTarget(self, action: #selector(didTapSwitch), for: .valueChanged)
        switchConverter.setOn(false, animated: true)
        switchConverter.onTintColor = .purple
        
        view.backgroundColor = .systemIndigo
        slider.maximumValue = 600
        slider.minimumValue = 0
        slider.value = Float(viewModel.mass.value)
        
        valueOfSliderLabel.backgroundColor = .yellow
        valueOfSliderLabel.text = String(format: "Massa: %.1f", Float(mass))
        valueOfSliderLabel.textColor = .black
        valueOfSliderLabel.textAlignment = .center
        
        pickerLabel.backgroundColor = .yellow
        pickerLabel.textColor = .black
        pickerLabel.text = String(format: "Altura: %.1f", Float(height))
        pickerLabel.textAlignment = .center
        
        slider.addTarget(self, action: #selector(didChangeSliderValue), for: .valueChanged)
    }
    
    private func bindViewModel() {
            
        viewModel.mass.sink { [weak self] newValue in
            self?.valueOfSliderLabel.text = String(format: "Massa: %.1f", Float(newValue))
        }.store(in: &cancellables)
        
        viewModel.height.sink { [weak self] newValue in
            self?.pickerLabel.text = "\(newValue)"
        }.store(in: &cancellables)
                
    }
    
    // MARK: - ACTIONS
    
    @objc func didChangeSliderValue(sender: UISlider) {
        let currentValue = Int(sender.value)
        viewModel.sliderValueDidChange(currentValue)
        
    }
    
    @objc private func didTapSwitch(_ sender:UISwitch){
        viewModel.switchValueChanged(sender.isOn)

    }
}

// MARK: - EXTESIONS

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 400
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.pickerValueDidChange(Int(row))
        
    }
}
