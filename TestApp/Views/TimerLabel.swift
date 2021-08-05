//
//  TimerLabel.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 05.08.2021.
//

import SwiftUI

struct TimerLabel: View {
    // Тут делаем константу со значением таймера, которую будем назначать извне
    let timerValue: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var timeRemaining = 0
    @State var isTimerTextUpdate = false
    
    var body: some View {
        Button(action: {
            if (timeRemaining == 0) {
                isTimerTextUpdate.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    timeRemaining = timerValue
                    isTimerTextUpdate.toggle()
                }
            }
        }) {
            Text(self.timeRemaining > 0 ? "Повторить запрос кода через \(timeRemaining)" : "Повторить запрос")
        }
        .foregroundColor(self.timeRemaining > 0 || isTimerTextUpdate ? Color.gray : Color.blue)
        .font(Font.caption)
        .onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .disabled(timeRemaining > 0 || isTimerTextUpdate)
        .onAppear {
            timeRemaining = timerValue
        }
    }
}
