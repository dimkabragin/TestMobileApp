//
//  SplashScreenView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 05.08.2021.
//

import SwiftUI

struct SplashScreenView: View {
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            
            ContentView()
            
            ZStack {
                Color("bg")
                Image("logoLarge")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 128, height: animate ? nil : 128)
                    
                    .scaleEffect(animate ? 3 : 1)
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
        }
    }
    
    func animateSplash() {
        // Манипулируя временем можно устанавливать свою собственную скорость загрузки
        // или дожидаться когда прогрузятся данные
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.easeOut(duration: 0.45)){
                animate.toggle()
            }
            
            withAnimation(Animation.easeOut(duration: 0.35)){
                endSplash.toggle()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
