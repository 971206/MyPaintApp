//
//  UIView + Extension.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}



