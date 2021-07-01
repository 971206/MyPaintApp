//
//  CoordinatorProtocol.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
    func proceedToPaint()
}
