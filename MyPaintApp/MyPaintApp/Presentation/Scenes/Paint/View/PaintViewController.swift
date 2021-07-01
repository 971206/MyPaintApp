//
//  PaintViewController.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class PaintViewController: BaseViewController {
    
    lazy var canvasView = CanvasView(frame: view.bounds)
    
    let btnUndo: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleUndo() {
        canvasView.undo()
    }
    
    let btnClear: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view = canvasView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.backgroundColor = .white
        setUpStackViewLayout()
    }
    
    private func setUpStackViewLayout() {
        let stackView = UIStackView(arrangedSubviews: [btnUndo, btnClear])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        view.addSubview(stackView)
        stackView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    
        ])
        
    }

}
