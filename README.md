# FoodSpend — Food Expense Tracker

A Flutter app to track daily meal, snack, grocery and eating-out expenses.

## Features
- Dashboard with this-month and all-time food spending.
- Add expense with item, amount validation, category, date, shop and note.
- Detail screen with delete confirmation.
- Category-wise spending summary.
- Provider (`ChangeNotifier`) state management.
- SharedPreferences local persistence and offline access to saved records.
- Loading, empty and basic error/retry states.

## Structure
`lib/models`, `lib/services`, `lib/providers`, `lib/screens`, `lib/widgets`, and `test`.

## Run
1. Open the project in Android Studio.
2. Run `flutter pub get`.
3. Run `flutter analyze`.
4. Run `flutter test`.
5. Connect an Android phone and run `flutter run`.
6. Build with `flutter build apk --release`.

## Team work
Suggested division: Member 1 dashboard/history; Member 2 add form/validation; Member 3 details/summary/tests/README. All members should make genuine commits and understand their work.

## Submission checklist
This is an initial source package and has **not been verified by a Flutter build or physical-device test**. Fix all errors before calling it ready. Add at least 3 real screenshots, actual member names/responsibilities, defect log and final APK details. Test on a physical Android phone.

## Data note
Records are saved locally with SharedPreferences. This app does not connect to food delivery platforms or bank accounts. Clearing app data or uninstalling may remove records.
