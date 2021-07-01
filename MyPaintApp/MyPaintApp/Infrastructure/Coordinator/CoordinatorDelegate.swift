//
//  CoordinatorDelegate.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit
protocol CoordinatorDelegate: UIViewController {
    var coordinator: CoordinatorProtocol? { get set }
}
