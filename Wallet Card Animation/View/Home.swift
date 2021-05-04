//
//  Home.swift
//  Wallet Card Animation
//
//  Created by Владимир Калиниченко on 03.05.2021.
//

import SwiftUI

struct Home: View {
    
    // Animation propeties
    @State var startAnimation = false
    @State var startCardRotation = false
    @State var selectedCard: Card = Card(cardHolder: "", cardNumber: "", cardValidity: "", cardImage: "")
    
    @State var cardAnimation = false
    @Namespace var animation
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.title)
                            .foregroundColor(.primary)
                    })
                    
                    Text("Welcome, back!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image("pic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 51, height: 38)
                            .clipShape(Circle())
                    })
                    
                }
                
                ZStack{
                    
                    ForEach(cards.indices.reversed(), id: \.self){ index in
                        
                       CardView(card: cards[index])
                        
                        .scaleEffect(index == 0 ? 1: 0.9)
                        .rotationEffect(.init(degrees: startAnimation ? 0 : index == 1 ? -15 : (index == 2 ? 15 : 0)))
                        
                        .onTapGesture {animateView(card: cards[index])}
                        .offset(y: startAnimation ? 0 : index == 1 ? 60 : (index == 2 ? -60 : 0))
                        
                        .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                        
                        .rotationEffect(.init(degrees: selectedCard.id == cards[index].id && startCardRotation ? -90 : 0))
                        
                        .zIndex(selectedCard.id == cards[index].id ? 1000 : 0)
                        
                        .opacity(startAnimation ? selectedCard.id == cards[index].id ? 1: 0: 1)
                        
                    }
                    
                }
                
                .rotationEffect(.init(degrees: 90))
                .frame(height: getRect().width - 30)
                .scaleEffect(0.9)
                .padding(.top,20)
                
                VStack(alignment: .leading, spacing: 6, content: {
                    Text("Total Amount Spent")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text("$2,500.00")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,20)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.04)
        .ignoresSafeArea())
        .blur(radius: cardAnimation ? 100 : 0)
        
        .overlay(
        
            ZStack(alignment: .topTrailing, content: {
               
                if cardAnimation{
                    Button(action: {
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.5)){
                            
                            startCardRotation = false
                            cardAnimation = false
                            selectedCard = Card(cardHolder: "", cardNumber: "", cardValidity: "", cardImage: "")
                            cardAnimation = false
                            startAnimation = false
                        }
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(colorScheme != .dark ? .white : .black)
                            .padding()
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    .padding()

        
                    CardView(card: selectedCard)
                        .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                
            })
        )
    }
    
    func animateView(card: Card){
        
        selectedCard = card
        
        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)){
        
        startAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            
            withAnimation(.spring()) {
                startCardRotation = true
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.spring()){
                cardAnimation = true
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View{
    
    func getRect() -> CGRect{
        
        return UIScreen.main.bounds
    }
    
}


struct CardView: View {
    
    var card: Card
    
    var body: some View{
        
        Image(card.cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
            
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    Text(card.cardNumber)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(y: 25)
                       
                    Spacer()
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text("CARD HOLDER")
                                .fontWeight(.bold)
                                
                            
                            Text(card.cardHolder)
                                .font(.title2)
                                .fontWeight(.bold)
                        })
                    
                        Spacer(minLength: 10)
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text("VALID TILL")
                                .fontWeight(.bold)
                                
                            
                            Text(card.cardValidity)
                                .fontWeight(.bold)
                        })
                    }
                    .foregroundColor(.white)
                }
                .padding()
            
            )
    }
    
}
