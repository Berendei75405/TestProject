//
//  StepperView.swift
//  TestProject
//
//  Created by user on 02.07.2023.
//

import UIKit

protocol CustomStepperDelegateProtocol: AnyObject {
    func decrease(tag: Int)
    func increaseButton(tag: Int)
}

final class CustomStepper: UIControl {
    /// Счетчик степпер который мы можем считывать и записывать
    var currentValue = 1 {
        didSet {
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    
    weak var delegate: CustomStepperDelegateProtocol?
    
    private lazy var decreaseButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentStepValueLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "\(currentValue)"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func setupViews() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(decreaseButton)
        horizontalStackView.addArrangedSubview(currentStepValueLabel)
        horizontalStackView.addArrangedSubview(increaseButton)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            
        ])
    }
    
    //MARK: - Actions
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
            delegate?.decrease(tag: self.tag)
        case increaseButton:
            currentValue += 1
            delegate?.increaseButton(tag: self.tag)
        default:
            break
        }
    }
}

