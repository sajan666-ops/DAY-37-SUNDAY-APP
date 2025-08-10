# DictFict — Secure & Modern SwiftUI Dictionary App

[![Swift Version](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org)  
[![iOS Version](https://img.shields.io/badge/iOS-15%2B-blue.svg)](https://developer.apple.com/ios)  
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## Overview

DictFict is a lightweight, performant dictionary app built with **SwiftUI** and **Swift Concurrency**.  
It securely fetches definitions from the **Oxford Dictionaries API** using best practices for API key management and modern networking.  

This project serves as a clean template to learn how to integrate third-party APIs with SwiftUI in a secure, maintainable, and scalable way.

---

## Key Features & Security Highlights

- **Async/Await** powered network calls for responsiveness and clarity  
- Strongly typed **Codable** models reflecting the Oxford Dictionaries JSON structure  
- **Secure API Authentication**:  
  - API credentials **never hardcoded** in production (use environment variables or secure vaults)  
  - Demonstrates best practice for setting HTTP headers (`app_id` and `app_key`) correctly  
- Input validation to prevent malformed API requests  
- Error handling with detailed logging for debugging  
- UI prevents empty or invalid search queries  
- Scalability ready for localization and offline caching  

---

## Architecture & Code Structure

- `DictionaryViewModel`: Handles all network requests and business logic asynchronously. Annotated with `@MainActor` for thread-safe UI updates.  
- Codable data models (`APIResponse`, `WordEntry`, `LexicalEntry`, `Entry`, `Sense`) are immutable structs for safety and predictability.  
- `ContentView`: Modular SwiftUI view with clean separation of concerns and reactive UI.  

---

## Getting Started

### Requirements

- Xcode 14+  
- iOS 15+  
- Oxford Dictionaries API credentials (Get yours at [Oxford Developer Portal](https://developer.oxforddictionaries.com/))  


---

### What you need to do:

- Copy the entire block above (including the triple backticks and markdown syntax).  
- Paste it directly into your `README.md` file on GitHub in the editor (either web UI or local editor).  
- Save/commit changes.

This will render perfectly with all the sections, headings, bullet points, code blocks, and badges properly formatted and easy to read.

---

If you want, I can also help you generate badges with real links, or add screenshots to make it visually richer.  
Just say the word!
