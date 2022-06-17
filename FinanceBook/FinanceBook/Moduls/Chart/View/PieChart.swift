//
//  PieChartView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

//@IBDesignable
final class PieChart: UIView {
    
    var segments = [Segment]() {
        didSet { setNeedsDisplay() }
    }
    
//    @IBInspectable
    var showSegmentLabels: Bool = true {
        didSet { setNeedsDisplay() }
    }
    
//    @IBInspectable
    var segmentLabelFont: UIFont = UIFont.systemFont(ofSize: 10) {
        didSet {
            textAttributes[.font] = segmentLabelFont
            setNeedsDisplay()
        }
    }
    
    var segmentLabelFormatter = SegmentLabelFormatter.nameWithValue {
        didSet { setNeedsDisplay() }
    }
    
    private let paragraphStyle: NSParagraphStyle = {
        var p = NSMutableParagraphStyle()
        p.alignment = .center
        return p.copy() as! NSParagraphStyle
    }()
    
    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .paragraphStyle: self.paragraphStyle, .font: self.segmentLabelFont
    ]
    
    init() {
        super.init(frame: .zero)
        self.isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        let radius = min(frame.width, frame.height) * 0.5
        
        let viewCenter = bounds.center
        
        forEachSegment { segment, startAngle, endAngle in
            
            ctx.setFillColor(segment.color.cgColor)
            
            ctx.move(to: viewCenter)
            
            ctx.addArc(center: viewCenter,
                       radius: radius,
                       startAngle: startAngle,
                       endAngle: endAngle,
                       clockwise: false)
            
            ctx.fillPath()
        }
        
        if showSegmentLabels {
            forEachSegment { segment, startAngle, endAngle in
                let halfAngle = startAngle + (endAngle - startAngle) * 0.5;
                
                var segmentCenter = viewCenter
                if segments.count > 1 {
                    segmentCenter = segmentCenter
                        .projected(by: radius * 0.8, angle: halfAngle)
                }
                
                let textToRender = segmentLabelFormatter.getLabel(for: segment) as NSString
                let textRenderSize = textToRender.size(withAttributes: textAttributes)
                let renderRect = CGRect(centeredOn: segmentCenter,
                                        size: textRenderSize)
                textToRender.draw(in: renderRect, withAttributes: textAttributes)
            }
        }
    }
}

private extension PieChart {
    
    func forEachSegment(complition: (Segment, _ startAngle: CGFloat, _ endAngle: CGFloat) -> ()) {
        
        let valueCount = segments.lazy.map { $0.value }.reduce(0, +)
        
        var startAngle: CGFloat = -.pi * 0.5
        
        for segment in segments {
            let endAngle = startAngle + .pi * 2 * CGFloat((segment.value / valueCount))
            defer {
                startAngle = endAngle
            }
            
            complition(segment, startAngle, endAngle)
        }
    }
}

extension CGRect {
    
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x - size.width * 0.5,
                                  y: center.y - size.height * 0.5),
                  size: size)
    }
    
    var center: CGPoint {
        return CGPoint(x: origin.x + size.width * 0.5,
                       y: origin.y + size.height * 0.5)
    }
}

extension CGPoint {
    
    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        
        return CGPoint(x: x + value * cos(angle),
                       y: y + value * sin(angle))
    }
}


struct SegmentLabelFormatter {
    private let getLabel: (Segment) -> String
    
    init(_ getLabel: @escaping (Segment) -> String) {
        self.getLabel = getLabel
    }
    
    func getLabel(for segment: Segment) -> String {
        return getLabel(segment)
    }
}

extension SegmentLabelFormatter {
    static let nameWithValue = SegmentLabelFormatter { segment in
        let formattedValue = NumberFormatter()
            .string(from: segment.value as NSNumber) ?? "\(segment.value)"
        return "\(segment.name) (\(formattedValue))"
    }
    
    static let nameOnly = SegmentLabelFormatter { $0.name }
}
