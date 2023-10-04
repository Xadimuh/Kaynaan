import SwiftUI
import Combine 
struct SecondPage: View {
    @State private var gender = "masculin"
    @State private var age = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var bedtime = ""
    @State private var wakeUpTime = ""
    @State private var recommendedWaterIntake = 0.0

    var body: some View {
        NavigationView {
            VStack {
                Text("Calcul de la quantité d'eau recommandée")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 6)

                Form {
                    Section(header: Text("Informations personnelles")) {
                        Picker("Genre", selection: $gender) {
                            Text("Masculin").tag("masculin")
                            Text("Féminin").tag("féminin")
                        }
                        .pickerStyle(SegmentedPickerStyle())

                        HStack {
                            Image(systemName: "calendar")
                            TextField("Âge", text: $age)
                                .keyboardType(.numberPad)
                                .onReceive(Just(age)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.age = filtered
                                    }
                                }
                        }
                        HStack {
                            Image(systemName: "scale")
                            TextField("Poids (kg)", text: $weight)
                                .keyboardType(.decimalPad)
                                .onReceive(Just(weight)) { newValue in
                                    let filtered = newValue.filter { "0123456789.".contains($0) }
                                    if filtered != newValue {
                                        self.weight = filtered
                                    }
                                }
                        }
                        HStack {
                            Image(systemName: "ruler")
                            TextField("Taille (cm)", text: $height)
                                .keyboardType(.decimalPad)
                                .onReceive(Just(height)) { newValue in
                                    let filtered = newValue.filter { "0123456789.".contains($0) }
                                    if filtered != newValue {
                                        self.height = filtered
                                    }
                                }
                        }
                    }

                    Section(header: Text("Heures de sommeil")) {
                        HStack {
                            Image(systemName: "moon.zzz")
                            TextField("Heure de coucher", text: $bedtime)
                                .keyboardType(.numbersAndPunctuation)
                                .onReceive(Just(bedtime)) { newValue in
                                    let filtered = newValue.filter { "0123456789:".contains($0) }
                                    if filtered != newValue {
                                        self.bedtime = filtered
                                    }
                                }
                        }
                        HStack {
                            Image(systemName: "sun.max")
                            TextField("Heure de réveil", text: $wakeUpTime)
                                .keyboardType(.numbersAndPunctuation)
                                .onReceive(Just(wakeUpTime)) { newValue in
                                    let filtered = newValue.filter { "0123456789:".contains($0) }
                                    if filtered != newValue {
                                        self.wakeUpTime = filtered
                                    }
                                }
                        }
                    }
                }

                Button(action: {
                    // Appel de la fonction de calcul de la quantité d'eau recommandée
                    let userWeight = Double(weight) ?? 0.0
                    let userHeight = Double(height) ?? 0.0
                    let userAge = Double(age) ?? 0.0
                    let userBedtime = Double(bedtime) ?? 0.0
                    let userWakeUpTime = Double(wakeUpTime) ?? 0.0
                    
                    recommendedWaterIntake = calculateWaterIntake(weightInKg: userWeight, heightInCm: userHeight, ageInYears: userAge, bedtimeInHours: userBedtime, wakeUpTimeInHours: userWakeUpTime, gender: gender)
                }) {
                    Text("Calculer")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(UIColor(red: 51/255, green: 73/255, blue: 92/255, alpha: 1.0)))
                        .cornerRadius(10)
                }
                .padding()

                Spacer()

                if recommendedWaterIntake > 0 {
                    Text("Quantité d'eau recommandée : \(Int(recommendedWaterIntake)) ml")
                        .font(.title2)
                        .padding(.bottom, 16)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }

    // Fonction de calcul de la quantité d'eau recommandée en millilitres en fonction des informations personnelles
    func calculateWaterIntake(weightInKg: Double, heightInCm: Double, ageInYears: Double, bedtimeInHours: Double, wakeUpTimeInHours: Double, gender: String) -> Double {
        // Calcul de la quantité d'eau recommandée en fonction des informations
        // Vous pouvez mettre en place une formule personnalisée en fonction de la recherche scientifique appropriée
        // Voici un exemple simplifié à titre indicatif
        var waterIntake = 0.0
        
        // Calculs basés sur le poids, la taille, l'âge, l'heure de coucher, l'heure de réveil et le genre
        // Ceci est un exemple simplifié et non basé sur des données scientifiques réelles
        waterIntake += weightInKg * 30.0 // Exemple : 30 ml d'eau par kilogramme de poids corporel
        waterIntake += heightInCm * 0.3 // Exemple : 0.3 ml d'eau par centimètre de taille
        waterIntake += ageInYears * 10.0 // Exemple : 10 ml d'eau par année d'âge
        waterIntake += (wakeUpTimeInHours - bedtimeInHours) * 15.0 // Exemple : 15 ml d'eau par heure de sommeil
        if gender.lowercased() == "masculin" {
            waterIntake += 500.0 // Exemple : 500 ml supplémentaires pour les hommes
        } else if gender.lowercased() == "féminin" {
            waterIntake += 300.0 // Exemple : 300 ml supplémentaires pour les femmes
        }
        
        return waterIntake
    }
}

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage()
    }
}
