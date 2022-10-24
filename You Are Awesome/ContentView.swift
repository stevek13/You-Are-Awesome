//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Steve on 10/17/22.
//  Asset files -> https://bit.ly/prof-g-swiftui-files
//  https://www.youtube.com/watch?v=XHtmISMKrxQ&list=PL9VJ9OpT-IPSM6dFSwQCIl409gNBsqKTe&index=3
// Next:
//https://www.youtube.com/watch?v=xf5JTCcUrdE&list=PL9VJ9OpT-IPSM6dFSwQCIl409gNBsqKTe&index=29
import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var messageString = "Fabulous? That's You!"
    @State private var imageName = "image1"
    @State private var soundName = ""
    @State private var lastMessageNumber : Int = -1
    @State private var lastSoundNumber = -1
    @State private var lastImageNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundIsOn = false
    
    //    var size = UIScreen.main.bounds.size
    var body: some View {
        
        //     GeometryReader { geometry in
        VStack {
            Text(messageString)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.red)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
//                .border(.orange, width: 1)
                .padding()
                .animation(.easeInOut(duration: 0.15), value: messageString)
                
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .shadow(radius: 30)
                .padding()
                .frame(height: 500)
                .animation(.default, value: messageString)
//                .border(.orange, width: 1)
            
            Spacer()
            
            
            // Group {
            //        }
            
            //                    Divider()
            //                        .background(.black)
            //                        .padding()
            //                        .frame(width: 150.0)
            //
            //                        Rectangle()
            //                        .fill(.indigo)
            //                        // Size the divider to 2/3 the size of the screen
            //                        .frame(width: geometry.size.width * (2/3), height: 1)
            
            
            HStack {
                Text("Sound On")
                    .padding()
                Toggle("Sound On:", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) { _ in
                        if audioPlayer != nil && audioPlayer.isPlaying {
                                audioPlayer.stop()
                            
                        }
                    }
                
                Spacer()
                Button("Show Messge!") {
                    let messages = ["You are Awesome!",
                                    "You are Great!!",
                                    "You are Fantastic!",
                                    "Fabulous? That's You!",
                                    "You make me smile!",
                                    "When the Genius bar needs help, they call you!"]
                    
                    lastMessageNumber = nonRepetingRandom(lastNumber: lastMessageNumber, upperBound: messages.count - 1)
                    messageString = messages[lastMessageNumber]
                   
                    lastImageNumber = nonRepetingRandom(lastNumber: lastImageNumber, upperBound: 9)
                    imageName = "image\(lastImageNumber)"
                    
                    lastSoundNumber = nonRepetingRandom(lastNumber: lastSoundNumber, upperBound: 5)
                    if soundIsOn {
                        playSound(soundName: "sound\(lastSoundNumber)")
                    }
                }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                
            }
            .tint(.accentColor)
        }
        .preferredColorScheme(.dark)
    }
    
    func nonRepetingRandom(lastNumber:Int, upperBound:Int) -> Int {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 0...upperBound)
        } while newNumber == lastNumber
        return newNumber
        
    }
    
    func playSound(soundName:String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("🤢 Could not read file named \(soundName)! 😡")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print(" 😡 ERROR: ERROR: \(error.localizedDescription) creating audio player")
        }
    }
    

}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
