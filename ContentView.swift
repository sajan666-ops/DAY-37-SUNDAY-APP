import SwiftUI
import Foundation

// MARK: - Codable Models

struct APIResponse: Codable {
    let results: [WordEntry]
}

struct WordEntry: Codable, Identifiable {
    let id: String
    let word: String
    let lexicalEntries: [LexicalEntry]
}

struct LexicalEntry: Codable, Hashable {
    let entries: [Entry]
}

struct Entry: Codable, Hashable {
    let senses: [Sense]
}

struct Sense: Codable, Hashable {
    let definitions: [String]
}

// MARK: - ViewModel

@MainActor
class DictionaryViewModel: ObservableObject {
    @Published var entries = [WordEntry]()

    func fetchDefinitions(for word: String) async {
        // Construct the full URL by appending the endpoint and the word
        let fullURL = "https://od-api-sandbox.oxforddictionaries.com/api/v2/entries/en-us/\(word)"
        
        guard let url = URL(string: fullURL) else {
            print("Invalid URL")
            return
        }

        // Use your actual API credentials here, as shown in your screenshot
        let apiKey = "6e4048113f6108a50e2736dec94d968a"
        let appId = "067b921e"

        var request = URLRequest(url: url)
        
        // Correctly set the header fields with the keys "app_key" and "app_id"
        request.addValue(apiKey, forHTTPHeaderField: "app_key")
        request.addValue(appId, forHTTPHeaderField: "app_id")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            self.entries = decodedResponse.results
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
            // To debug, you can uncomment this to see the raw data from the API
            // if let data = data, let str = String(data: data, encoding: .utf8) {
            //     print("Raw data: \(str)")
            // }
        }
    }
}

// MARK: - ContentView

struct ContentView: View {
    @StateObject private var viewModel = DictionaryViewModel()
    @State private var wordToSearch: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a word", text: $wordToSearch)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Search") {
                    Task {
                        await viewModel.fetchDefinitions(for: wordToSearch)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)

                List(viewModel.entries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.word)
                            .font(.headline)

                        ForEach(entry.lexicalEntries, id: \.self) { lexicalEntry in
                            ForEach(lexicalEntry.entries, id: \.self) { innerEntry in
                                ForEach(innerEntry.senses, id: \.self) { sense in
                                    ForEach(sense.definitions, id: \.self) { definition in
                                        Text(definition)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Dict Fict")
        }
    }
}
