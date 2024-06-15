//
//  ChatBubbleShape.swift
//  Language Learning
//
//  Created by TungDVS on 12/11/2023.
//

import Foundation
import SwiftUI

struct ChatBubbleShape: Shape {
    var isUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 14
        let tailWidth: CGFloat = 10
        let tailHeight: CGFloat = 15
        
        var path = Path()
        path.addRoundedRect(in: CGRect(x: isUser ? 0 : tailWidth,
                                       y: 0,
                                       width: rect.width - tailWidth,
                                       height: rect.height),
                            cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        
        if isUser {
            // Tail on the right
            path.move(to: CGPoint(x: rect.maxX - tailWidth, y: rect.height / 2))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.height / 2 - tailHeight))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.height / 2 + tailHeight))
        } else {
            // Tail on the left
            path.move(to: CGPoint(x: tailWidth, y: rect.height / 2))
            path.addLine(to: CGPoint(x: 0, y: rect.height / 2 - tailHeight))
            path.addLine(to: CGPoint(x: 0, y: rect.height / 2 + tailHeight))
        }
        path.closeSubpath()
        
        return path
    }
}
