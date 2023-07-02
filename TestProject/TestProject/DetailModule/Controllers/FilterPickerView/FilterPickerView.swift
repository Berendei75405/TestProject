//
//  FilterPickerView.swift
//  TestProject
//
//  Created by user on 30.06.2023.
//

import UIKit
import Combine

final class FilterPickerView: UIControl {
    //property
    var buttons: [UIButton] = []
    var colorsArray: [UIColor] = [#colorLiteral(red: 0.2, green: 0.3921568627, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1)]
    var textColor: [UIColor] = [.white, .black, .black, .black, .black]
    //сообщит если нажмут на кнопку и отдаст индекс
    var tapOnButton = PassthroughSubject<Teg, Never>()
    private var stackView: UIStackView!
    
    //MARK: - setupConstraints
    func setupView() {
        for item in 0...4 {
            //MARK: - button
            let button = UIButton(type: .system)
            button.frame.size = CGSize(width: 80, height: 35)
            button.layer.cornerRadius = 10
            button.tintColor = textColor[item]
            button.backgroundColor = colorsArray[item]
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = item
            button.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
            
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            buttons.append(button)
            
        }
        //MARK: - stackView
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        stackView.spacing = 10
        //ось на которой расположены элементы
        stackView.axis = .horizontal
        stackView.alignment = .center
        //Распределение упорядоченных представлений вдоль оси представления стека.
        stackView.distribution = .fillEqually
        
        self.backgroundColor = .white
    }
    
    //MARK: - configurateTimePicker
    func configurate(titleArray: [String]) {
        for i in 0...titleArray.count-1 {
            buttons[i].setTitle(titleArray[i], for: .normal)
        }
    }
    
    @objc private func tap(sender: UIButton) {
        for i in buttons {
            i.tintColor = .black
            i.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1)
        }
        self.buttons[sender.tag].tintColor = .white
        self.buttons[sender.tag].backgroundColor = #colorLiteral(red: 0.2, green: 0.3921568627, blue: 0.8784313725, alpha: 1)
        switch sender.tag {
        case 1:
            tapOnButton.send(Teg.салаты)
        case 2:
            tapOnButton.send(Teg.сРисом)
        case 3:
            tapOnButton.send(Teg.сРыбой)
        case 4:
            tapOnButton.send(Teg.роллы)
        default:
            tapOnButton.send(Teg.всеМеню)
        }
    }
}
