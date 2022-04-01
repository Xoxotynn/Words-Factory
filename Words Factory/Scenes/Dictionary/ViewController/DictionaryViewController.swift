//
//  DictionaryViewController.swift
//  Words Factory
//
//  Created by Эдуард Логинов on 01.04.2022.
//

import UIKit

class DictionaryViewController: UIViewController {

    // MARK: Properties
    private let viewModel: DictionaryViewModel
    
    // MARK: Init
    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Private setup methods
    private func setup() {
        view.backgroundColor = .appWhite
    }
}
