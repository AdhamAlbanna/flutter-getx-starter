# Adding a screen

Example: a `Profile` screen that loads data from `GET /profile`.

## 1. Create the folder

```text
lib/view_controller/profile/
  profile.dart                UI only
  profile_controller.dart     Logic only
  items/                      Optional: widgets used only by this screen
```

## 2. Register the route

`lib/constants/approutes.dart`

```dart
static const String profile = "/profile";
```

`lib/routes.dart`

```dart
GetPage(
  name: AppRoute.profile,
  page: () => const Profile(),
  binding: BindingsBuilder(() => Get.lazyPut(() => ProfileController())),
),
```

Add `middlewares: [...]` if the route needs a guard. A screen with no controller needs no binding.

## 3. Write the controller

```dart
class ProfileController extends GetxController {
  Map<String, dynamic> profile = {};

  @override
  void onInit() {
    loadProfile();      // never make onInit async
    super.onInit();
  }

  Future<void> loadProfile() async {
    final response = await Api.makeApiRequest(
      url: ApiLinks.profile,
      method: 'GET',
    );
    if (response['success'] == true) {
      profile = response;
      update();
    }
  }
}
```

Dispose anything the controller owns (for example `TextEditingController`) in `onClose()`.

## 4. Write the screen

```dart
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(title: 'profile'.tr),
        body: /* presentation only */,
      ),
    );
  }
}
```

The UI calls controller methods (`onPressed: () => controller.save()`). It never calls `Api`.

## 5. Add the endpoint and model

- `lib/Network/api_links.dart`: `static const String profile = "$server/profile";`
- `lib/model/profile.dart`: a class with `final` fields and a `fromJson` factory. Add a test in `test/`.

## 6. Translate every visible string

Add the same key to **both** `ar` and `en` in `lib/localization/mylocalization.dart`. A test fails if the key sets differ.

## 7. Verify

```bash
dart format lib test
flutter analyze
flutter test
```

Then run the app and open the screen.
