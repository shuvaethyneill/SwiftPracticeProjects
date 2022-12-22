//
//  ContentView.swift
//  BetterRest
//
//  Created by Shuvaethy Neill on 2022-12-20.
//

/*
 This project is currently complete in terms of basic functionality. However, I would like to make improvements in the coming days. Please keep that in mind when looking at this.
 */

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    let config = MLModelConfiguration()
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        // hide second label because we already have one
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                } header: {
                    Text("When do you want to wake up?")
                        .textCase(nil)
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .textCase(nil)
                        .font(.headline)
                }
                
                Section {
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                } header: {
                    Text("Daily coffee intake")
                    .textCase(nil)
                    .font(.headline)
                }
                
                Section {
                    Text("\(calculateBedtime())")
                } header: {
                    Text("Recommended bedtime")
                        .font(.headline)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let model = try SleepCalculator(configuration: config)
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
                        
            return  formatter.string(from: sleepTime)
            
        } catch {
            return "Error calculating bedtime"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
