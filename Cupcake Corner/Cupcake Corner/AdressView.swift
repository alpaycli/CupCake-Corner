//
//  AdressView.swift
//  Cupcake Corner
//
//  Created by Alpay Calalli on 15.08.22.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Adress", text: $order.streetAdress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                }label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAdress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AdressView(order: Order())
        }
    }
}
