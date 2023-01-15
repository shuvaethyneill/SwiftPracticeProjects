//
//  ContentView.swift
//  Calculator
//
//  Created by Shuvaethy Neill on 2023-01-14.
//

import SwiftUI

enum CalculatorButton: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var background: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return Color(.orange)
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNum = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // Text display
            VStack() {
                HStack {
                    Spacer()
                    Text(value).foregroundColor(.white)
                        .font(.system(size: 88, weight: .light))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
                .padding()
                
                // Button
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                didTap(button)
                            }, label: {
                                Text(button.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(button), height: self.buttonHeight())
                                    .foregroundColor(.white)
                                    .background(button.background)
                                    .cornerRadius(self.buttonWidth(button))
                            })
                        }
                    }
                    
                }
    
            }
            .padding(.bottom)
        }
    }
    
    func didTap(_ button: CalculatorButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNum = Int(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNum = Int(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNum = Int(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNum = Int(self.value) ?? 0
            } else if button == .equal {
                let runningValue = self.runningNum
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(_ button: CalculatorButton) -> CGFloat {
        // Zero button takes up two columns
        if button == .zero {
            return ((UIScreen.main.bounds.width - 4 * 12) / 4) * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
