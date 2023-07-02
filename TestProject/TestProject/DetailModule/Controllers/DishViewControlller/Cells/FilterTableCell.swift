//
//  FilterTableCell.swift
//  TestProject
//
//  Created by user on 30.06.2023.
//

import UIKit

final class FilterTableCell: UITableViewCell {
    static let identifier = "FilterTableCell"
    
    //MARK: - scrollView
    private var scrollView: UIScrollView = {
        var scrl = UIScrollView()
        scrl.translatesAutoresizingMaskIntoConstraints = false
        scrl.showsHorizontalScrollIndicator = false
        
        return scrl
    }()
    
    //MARK: - filterPickerView
    var filterPickerView: FilterPickerView = {
        var picker = FilterPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setupView()
        
        return picker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - scrollView constraint
        contentView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        //MARK: - constraint filterPickerView
        scrollView.addSubview(filterPickerView)
        NSLayoutConstraint.activate([
            filterPickerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            filterPickerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            filterPickerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            filterPickerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            filterPickerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            filterPickerView.widthAnchor.constraint(equalToConstant: 530)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurate(titleArray: [String]) {
        filterPickerView.configurate(titleArray: titleArray)
    }
}
