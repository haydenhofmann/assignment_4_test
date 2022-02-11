//
//  IntroductionUIView.swift
//  CardinalKit_Example
//
//  Created by Hayden hofmann on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct IntroductionUIView: View {
    var body: some View {
        ZStack {
                Image("resized_blue")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
        VStack {
            Spacer()
            Image("CHOIR_LOGO")
            //Spacer()
            Text("Instructions").font(.title.bold()).foregroundColor(Color("Cardinal"))
            Text("Each day you will be notified to take 3 surveys each taking less than 5 minutes to complete. You can view these surveys in the schedule tab below.").font(.body).padding().multilineTextAlignment(.center)
            Spacer()
            
        }
        }
    }
}

struct IntroductionUIView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionUIView()
    }
}
