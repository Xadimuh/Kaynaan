import SwiftUI

struct AccueilPage: View {
    @ObservedObject var userData: UserData
    @State private var isAddDrinkViewActive: Bool = false
    @State private var isDragging: Bool = false
    @State private var isHistoryViewActive: Bool = false
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()

    @State private var waterDrank: Double = 0.0

    var body: some View {
        
        NavigationView {
            ZStack {
                Color(UIColor(red: 0x9C / 255.0, green: 0xB3 / 255.0, blue: 0xC7 / 255.0, alpha: 1.0))
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Image("logo 3")
                            .resizable()
                            .frame(width: 140, height: 140)
                            .padding()
                        Spacer()
                    }
                    .padding(.top)

                    HStack {
                                           NavigationLink(destination: HistoryView(), isActive: $isHistoryViewActive) { // Utilisation de NavigationLink
                                               Button(action: {
                                                   isHistoryViewActive = true
                                               }) {
                                                   // Bouton du calendrier avec une icône
                                                   Image(systemName: "calendar.badge.plus")
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fit)
                                                       .frame(width: 40, height: 50)
                                                       .padding()
                                               }
                                           }

                        Text(dateFormatter.string(from: Date()))
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(.white)
                    }

                    Spacer()
                    
                    Spacer()
                    
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 6)
                                .foregroundColor(Color(UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1.0)))

                            let percent = min(max(waterDrank / userData.recommendedWaterIntake, 0.0), 1.0)
                            let symbolX = geometry.size.width * percent

                            Image(systemName: "drop.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.cyan)
                                .offset(x: symbolX - 15, y: 0)
                                .gesture(DragGesture()
                                    .onChanged { gesture in
                                        // Vous pouvez ajouter une logique pour déplacer le symbole si nécessaire
                                    }
                                    .onEnded { _ in
                                        // Vous pouvez ajouter une logique de fin de glissement si nécessaire
                                    }
                                )
                                .animation(isDragging ? nil : .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.2))
                            Text(String(format: "%.0f%%", percent * 100))
                                .font(.caption)
                                .foregroundColor(.white)
                                .offset(x: symbolX, y: 30)
                        }
                        .frame(height: 40)
                    }
                    Text("\(String(format: "%.2f", waterDrank)) ml sur \(String(format: "%.2f", userData.recommendedWaterIntake)) ml")
                                            .font(.title2)
                                            .padding(.bottom, 16)

                    Spacer()

                    NavigationLink(
                        destination: AddDrinkView(waterDrank: $waterDrank),
                        isActive: $isAddDrinkViewActive
                    ) {
                        Button(action: {
                            isAddDrinkViewActive = true
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(Color(UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1.0)))
                        .cornerRadius(30)
                        .padding(16)
                    }
                }
            }
            
        }
        //.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Cacher le bouton "Back"
    }

    struct AccueilPage_Previews: PreviewProvider {
        static var previews: some View {
            AccueilPage(userData: UserData())
        }
    }
}
class WaterHistoryManager {
    static let shared = WaterHistoryManager()

    private let key = "WaterHistory"
    private var waterRecords: [WaterRecord]

    init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decodedRecords = try? JSONDecoder().decode([WaterRecord].self, from: data) {
            waterRecords = decodedRecords
        } else {
            waterRecords = []
        }
    }

    func saveRecord(_ record: WaterRecord) {
        waterRecords.append(record)
        saveToUserDefaults()
    }

    func getRecords() -> [WaterRecord] {
        return waterRecords
    }

    private func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(waterRecords) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
}
