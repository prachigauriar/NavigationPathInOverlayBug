//
//  ContentView.swift
//  NavigationPathBug
//
//  Created by Prachi Gauriar on 8/18/25.
//

import SwiftUI

struct ContentView: View {
    @State var primaryNavigationPath = NavigationPath()
    @State var secondaryNavigationPath = NavigationPath()
    @State var isShowingOverlay = false


    var body: some View {
        NavigationStack(path: $primaryNavigationPath) {
            List {
                Section("Buttons") {
                    ForEach(ColorViewModel.allCases) { (colorViewModel) in
                        Button(colorViewModel.title) {
                            navigateToColor(colorViewModel)
                        }
                    }
                }

                Section("Navigation Links") {
                    ForEach(ColorViewModel.allCases) { (colorViewModel) in
                        NavigationLink(colorViewModel.title, value: colorViewModel)
                    }
                }

                Section("Actions") {
                    Button("Show Overlay") {
                        isShowingOverlay = true
                    }
                }
            }
            .overlay {
                if isShowingOverlay {
                    NavigationStack(path: $secondaryNavigationPath) {
                        AngularGradient(
                            colors: ColorViewModel.allCases.map(\.color),
                            center: .center
                        )
                        .navigationTitle("Overlay")
                        .ignoresSafeArea(.all)
                        .toolbar {
                            ToolbarItem(placement: .navigation) {
                                Button("Dismiss", systemImage: "xmark", role: .close) {
                                    isShowingOverlay = false
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Navigation Path Bug")
            .navigationDestination(for: ColorViewModel.self) { (colorViewModel) in
                colorViewModel.color
                    .navigationTitle(colorViewModel.title)
                    .ignoresSafeArea(edges: .bottom)
            }
        }
        .onChange(of: primaryNavigationPath) { (old, new) in
            printValueChange("Primary Navigation Path", old: old, new: new)
        }
        .onChange(of: secondaryNavigationPath) { (old, new) in
            printValueChange("Secondary Navigation Path", old: old, new: new)
        }
    }


    func navigateToColor(_ colorViewModel: ColorViewModel) {
        primaryNavigationPath.append(colorViewModel)
    }
}


func printValueChange<T>(_ description: String, old: T, new: T) {
    print(
        """
        \(description) changed.
            old=\(old)
            new=\(new)

        """
    )
}


struct ColorViewModel: Hashable, Identifiable {
    let title: String
    let color: Color


    var id: Color {
        return color
    }
}


extension ColorViewModel: CaseIterable {
    static let red: ColorViewModel = .init(title: "Red", color: .red)
    static let orange: ColorViewModel = .init(title: "Orange", color: .orange)
    static let yellow: ColorViewModel = .init(title: "Yellow", color: .yellow)
    static let green: ColorViewModel = .init(title: "Green", color: .green)
    static let blue: ColorViewModel = .init(title: "Blue", color: .blue)
    static let indigo: ColorViewModel = .init(title: "Indigo", color: .indigo)
    static let violet: ColorViewModel = .init(title: "Violet", color: .purple)


    static var allCases: [ColorViewModel] {
        return [.red, .orange, .yellow, .green, .blue, .indigo, .violet]
    }
}


#Preview {
    ContentView()
}
