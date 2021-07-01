//
//  CanvasView.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class CanvasView: UIView {

    private var lines = [[CGPoint]]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
        guard  let context = UIGraphicsGetCurrentContext() else {return}
        
        
        lines.forEach { (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(4)
        context.setLineCap(.butt)
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        lines.append([CGPoint]())
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {return}
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    func undo() {
       _ = lines.popLast()
        setNeedsDisplay()
    }
    
}
