/// Copyright (c) 2023 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ContentView: View {
  @State private var alertIsVisible: Bool = false
  @State private var redColor: Double = 0.0
  @State private var greenColor: Double = 0.0
  @State private var blueColor: Double = 0.0
  @State private var foregroundColor = Color(red: 0, green: 0, blue: 0)
  
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  
  var body: some View {
    
    
    let isPortraitMode = verticalSizeClass == .regular && horizontalSizeClass == .compact
    
    VStack {
      BannerText(text: "Color Picker")
      
      if isPortraitMode {
        RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
          .foregroundColor(foregroundColor)
          .border(.white)
          .padding(.bottom, Constants.General.standardPadding)
        
        ColorSliderView(sliderColor: $redColor, colorName: "Red", accentColor: .red)
        ColorSliderView(sliderColor: $greenColor, colorName: "Green", accentColor: .green)
        ColorSliderView(sliderColor: $blueColor, colorName: "Blue", accentColor: .blue)
        
        SetColorButton(redColor: $redColor, greenColor: $greenColor, blueColor: $blueColor, foregroundColor: $foregroundColor)
      } else {
        HStack {
          RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
            .foregroundColor(foregroundColor)
            .border(.white)
            .padding(.trailing, Constants.General.standardPadding)
          VStack {
            ColorSliderView(sliderColor: $redColor, colorName: "Red", accentColor: .red)
            ColorSliderView(sliderColor: $greenColor, colorName: "Green", accentColor: .green)
            ColorSliderView(sliderColor: $blueColor, colorName: "Blue", accentColor: .blue)
            
            SetColorButton(redColor: $redColor, greenColor: $greenColor, blueColor: $blueColor, foregroundColor: $foregroundColor)
          }
        }
      }
    }
    .background(Color("MainBackgroundColor"))
    .padding(Constants.General.standardPadding)

  }
}

struct ColorSliderView: View {
  @Binding var sliderColor: Double
  var colorName: String
  var accentColor: Color
  
  var body: some View {
    VStack {
      SliderLabelText(text: colorName)
      HStack {
        Slider(value: $sliderColor, in: 0...255)
          .accentColor(accentColor)
        SliderValueText(value: sliderColor)
          .frame(width: Constants.General.sliderValueTextWidth)
      }
    }
  }
}

struct SetColorButton: View {
  @Binding var redColor: Double
  @Binding var greenColor: Double
  @Binding var blueColor: Double
  @Binding var foregroundColor: Color
  
  var body: some View {
    VStack {
      Button("Set Color") {
        foregroundColor = Color(red: redColor / 255, green: greenColor / 255, blue: blueColor / 255)
      }
      .padding(Constants.General.standardPadding)
      .background(
        Color(.blue)
      )
      .overlay(
        RoundedRectangle(cornerRadius: Constants.General.buttonRectCornerRadius)
          .strokeBorder(.white, lineWidth: Constants.General.strokeWidth)
      )
      .foregroundColor(
        Color(.white)
      )
      .cornerRadius(Constants.General.buttonRectCornerRadius)
      .bold()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    ContentView()
      .preferredColorScheme(.dark)
    ContentView()
      .previewInterfaceOrientation(.landscapeRight)
      .preferredColorScheme(.dark)
  }
}
