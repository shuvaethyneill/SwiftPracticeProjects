//
//  ContentView.swift
//  WeSplit
//
//  Created by Shuvaethy Neill on 2022-12-17.
//

import SwiftUI

struct ContentView: View {
    
    // State property wrapper automatically reload UI when changed
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipValue = billAmount / 100 * Double(tipPercentage)
        return billAmount + tipValue
    }
    
    var totalPerPerson: Double {
        return grandTotal / Double(numberOfPeople + 2)
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Text placeholder, two way binding $ amount, currency format
                    TextField("Bill amount", value: $billAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much would you like to tip?")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: "USD"))
                } header: {
                    Text("Grand total")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: "USD"))
                } header: {
                    Text("Total per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                // Toolbar attached to keyboard
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        // Closure to run when button is pressed - keyboard dismissed
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
