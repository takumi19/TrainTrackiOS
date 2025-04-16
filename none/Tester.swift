import SwiftUI

struct SectionedWordsList: View {
    @State var selected = Set<String>()
    let wordDictionary: [String: [String]] = [
        "a": ["apple", "apricot", "ant"],
        "b": ["banana", "berry", "ball"],
        "c": ["carrot", "cat", "cow"],
        "d": ["dream", "dog", "date"],
        "e": ["elephant", "eagle", "egg"],
        "f": ["fox", "fish", "fly"],
        "g": ["grape", "goat", "grass"],
        "h": ["house", "horse", "hat"],
        "i": ["island", "ice", "ink"],
        "j": ["jump", "jug", "jam"]
    ]

    var body: some View {
        List {
            ForEach(Array("abcdefghijklmnopqrstuvwxyz".enumerated()), id: \.offset) { index, char in
                if wordDictionary[String(char)] != nil {
                    Section(header: Text(String(char))) {
                        ForEach(wordDictionary[String(char)]!, id: \.self) { word in
                            HStack {
                                Text(word)
                                Spacer()
                            }
                            .listRowBackground(selected.contains(word) ? Color.green : Color.gray)
                            .onTapGesture {
                                if selected.contains(word) {
                                    selected.remove(word)
                                } else {
                                    selected.insert(word)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
    }
}

#Preview {
    SectionedWordsList()
}

