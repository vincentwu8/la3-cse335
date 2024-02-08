import SwiftUI

struct ContentView: View {
    @State private var cardDetails = CardDetails()
    @State private var selectedCardTheme: String = "Blue" // Default theme
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CardInputView(cardDetails: $cardDetails, selectedCardTheme: $selectedCardTheme)) {
                    Text("Enter Card Details")
                        .padding()
                }
                
                NavigationLink(destination: CardPreviewView(cardDetails: cardDetails, cardTheme: selectedCardTheme)) {
                    Text("Preview Card")
                        .padding()
                }
                
                Spacer()
            }
            .navigationBarTitle("Wallet App")
        }
    }
}

struct CardInputView: View {
    @Binding var cardDetails: CardDetails
    @Binding var selectedCardTheme: String
    
    var body: some View {
        Form {
            Section(header: Text("Card Information")) {
                TextField("Cardholder Name", text: $cardDetails.holderName)
                TextField("Bank", text: $cardDetails.bank)
                
                Picker(selection: $cardDetails.type, label: Text("Card Type")) {
                    ForEach(CardType.allCases, id: \.self) { cardType in
                        Text(cardType.rawValue).tag(cardType)
                    }
                }
                
                TextField("Card Number", text: $cardDetails.number)
                
                DatePicker(selection: $cardDetails.validity, in: Date()..., displayedComponents: .date) {
                    Text("Validity")
                }
            }
            
            Section(header: Text("Security")) {
                TextField("Security Code", text: $cardDetails.secureCode)
            }
            
            Section(header: Text("Card Theme")) {
                Picker(selection: $selectedCardTheme, label: Text("Card Color")) {
                    Text("Blue").tag("Blue")
                    Text("Red").tag("Red")
                    Text("Green").tag("Green")
                    Text("Yellow").tag("Yellow")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationBarTitle("Enter Card Details")
    }
}

struct CardPreviewView: View {
    let cardDetails: CardDetails
    let cardTheme: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(getColorForTheme(theme: cardTheme))
                .frame(height: 200)
                .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(cardDetails.holderName)
                        .fontWeight(.bold)
                    Text(cardDetails.bank)
                    Text(cardDetails.type.rawValue)
                }
                Spacer()
                Text(cardDetails.formattedValidity)
            }
            .padding()
            
            HStack {
                Spacer()
                Text(cardDetails.number)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .navigationBarTitle("Card Preview")
    }
    
    func getColorForTheme(theme: String) -> Color {
        switch theme {
        case "Blue":
            return Color.blue
        case "Red":
            return Color.red
        case "Green":
            return Color.green
        case "Yellow":
            return Color.yellow
        default:
            return Color.blue // Default to blue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

