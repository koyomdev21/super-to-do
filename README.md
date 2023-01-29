TDD clean architecture with repository pattern.

## Getting Started

This project is mainly focusing on the implementation of riverpod state management package with the most basic UI. Thus, the API used is just a stubbed with MockLab. Register features is not implemented yet. To login, always use 'abc@gmail.com' as email, 'password' as password as they are stubbed API. Also get your Mapbox API key to enable the mapbox feature and replace the secret and public API keys where required for IOS and android. There will be major UI update with animation in the near future. To be able to use new feature, use other branch other than main branch.

Packages used in this project:

- flutter riverpod: to handle the state of the apps and caching strategy.
- go router: to handle the navigation.
- retrofit and dio: to handle the entire REST api calling.
- mocktail: mocking and testing.
- mapbox: implementing map for the application.
- sembast: for data persistence.

For the meantime, apps crash happened for android when closing map as per https://github.com/flutter-mapbox-gl/maps/issues?q=crash#issuecomment-1357623726. The only solution is to use another plugin that is mapbox_maps_flutter(another mapbox official plugin) as mentioned in the link attached but i will not implement the changes for now. Feel free to do so. Running on IOS working as intended.

Changes to be implement in the near future:

- [ ] real working use cases backend(firebase)
- [ ] UI update
- [ ] application with real features
- [x] search autocomplete in mapbox map
- [ ] navigation with mapbox
- [ ] implement push notification
