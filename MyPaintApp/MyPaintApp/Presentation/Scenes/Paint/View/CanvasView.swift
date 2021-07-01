//
//  CanvasView.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class CanvasView: UIView {

    private var lines = [Line]()
    var strokeColor = UIColor.black
    var strokeWidth: Float = 1

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
        guard  let context = UIGraphicsGetCurrentContext() else {return}
        
  
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (index, point) in line.points.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()

        }
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {return}
        guard var lastLine = lines.popLast() else {return}
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    func undo() {
       _ = lines.popLast()
        setNeedsDisplay()
    }
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
}

struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}
