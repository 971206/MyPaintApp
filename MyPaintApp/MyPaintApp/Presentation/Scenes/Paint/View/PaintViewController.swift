//
//  PaintViewController.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class PaintViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    lazy var canvasView = CanvasView(frame: view.bounds)
    
    private var viewSquare: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()

    
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
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    let eraserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Eraser", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(onSave), for: .touchUpInside)
        return button
    }()
    
    
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    let greenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    let brownButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .brown
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    let purpleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    @objc func handleColor(button: UIButton) {
        canvasView.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 20
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        canvasView.setStrokeWidth(width: slider.value)
    }
    
    @objc func handleClear() {
        canvasView.clear()
    }
    
    
    override func loadView() {
        super.loadView()
        view = canvasView
    }
    
    let fileManager = FileManager.default
    private var documentsDirectoryURL: URL? {
        try? fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.backgroundColor = .white
        setUpStackViewLayout()
        print(documentsDirectoryURL!)
//        self.navigationController?.navigationBar.isHidden = true
        
    }
    private func setUpStackViewLayout() {
        let stackView = UIStackView(arrangedSubviews: [btnUndo, eraserButton, btnClear, saveButton])
        let colorsStackView = UIStackView(arrangedSubviews: [yellowButton, greenButton, blueButton, redButton, brownButton, purpleButton])
        stackView.distribution = .fillEqually
        colorsStackView.distribution = .fillEqually
        stackView.spacing = 5
        view.addSubview(viewSquare)
        viewSquare.addSubview(stackView)
        viewSquare.addSubview(colorsStackView)
        viewSquare.addSubview(slider)
        stackView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewSquare.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewSquare.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewSquare.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewSquare.heightAnchor.constraint(equalToConstant: 250),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            colorsStackView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            slider.bottomAnchor.constraint(equalTo: colorsStackView.topAnchor, constant: -8),
        ])
        
    }
    
    @objc func onSave() {
        slider.isHidden = true
        saveFile(with: self.canvasView.asImage().pngData())
        slider.isHidden = false
    }
    func saveFile(with data: Data?) {
        let documentsDirectory = try? FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
        
        let randomImageName = "\(UUID.init().uuidString).png"
        
        guard let imagePath = documentsDirectory?.appendingPathComponent(randomImageName) else {return}
        
        do {
            try data?.write(to: imagePath)
        } catch {
            print(error)
        }
    }

}
