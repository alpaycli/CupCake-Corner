//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Alpay Calalli on 14.08.22.
//

import SwiftUI


struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section{
                    Toggle("Any special requests?", isOn: $order.specialRequest.animation())
                    
                    if order.specialRequest{
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink{
                        AdressView(order: order)
                    }label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("CupCake Corner")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
