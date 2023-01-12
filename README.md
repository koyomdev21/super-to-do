# super_to_do

TDD and clean architecture with repository pattern.

## Getting Started

This project is mainly focusing on the implementation of riverpod state management package with the most basic UI. Thus, the API used is just a stubbed with MockLab. Register features is not implemented. To login, always use 'abc@gmail.com' as email, 'password' as password as they are stubbed API. There will be major UI update with animation in the near future. 

Packages used in this project:
  - flutter riverpod: to handle the state of the apps and caching strategy.
  - go router: to handle the navigation.
  - retrofit and dio: to handle the entire REST api calling.
  - mocktail: mocking and testing.
  - mapbox: implementing map for the application.
  - sembast: for data persistence.

For the meantime, apps crash happened for android when closing map as per https://github.com/flutter/flutter/issues/106464. IOS working as intended.

Changes to be implement in the near future:
  - real working use cases backend
  - UI update
  - application with real features
