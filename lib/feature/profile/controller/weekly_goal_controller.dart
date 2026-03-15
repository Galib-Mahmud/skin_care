import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalTrackerController extends GetxController {
  SharedPreferences? prefs;

  // Daily check-in
  RxBool isCheckedToday = false.obs;
  RxInt currentDay = 1.obs;

  // Weekly status
  RxList<bool> weeklyCheckinStatus = List.generate(7, (_) => false).obs;

  // Water goal weekly status
  RxList<bool> weeklyWaterStatus = List.generate(7, (_) => false).obs;

  @override
  void onInit() {
    super.onInit();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    currentDay.value = prefs?.getInt('currentDay') ?? 1;

    List<String>? checkinStored = prefs?.getStringList('weeklyCheckinStatus');
    if (checkinStored != null) {
      weeklyCheckinStatus.value = checkinStored.map((e) => e == "true").toList();
    }

    List<String>? waterStored = prefs?.getStringList('weeklyWaterStatus');
    if (waterStored != null) {
      weeklyWaterStatus.value = waterStored.map((e) => e == "true").toList();
    }

    String? lastDate = prefs?.getString('lastCheckDate');
    if (lastDate != null) {
      DateTime last = DateTime.parse(lastDate);
      DateTime now = DateTime.now();

      if (last.year == now.year && last.month == now.month && last.day == now.day) {
        isCheckedToday.value = true;
      } else {
        isCheckedToday.value = false;
      }
    }
  }

  /// ================= DAILY CHECK-IN =================
  Future<void> checkInToday() async {
    if (isCheckedToday.value) {
      Get.snackbar("Already Checked", "You already completed today’s goal");
      return;
    }

    weeklyCheckinStatus[currentDay.value - 1] = true;

    isCheckedToday.value = true;

    await prefs?.setString('lastCheckDate', DateTime.now().toIso8601String());

    if (currentDay.value == 7) {
      resetWeek();
    } else {
      currentDay.value++;
    }

    saveData();
  }

  /// ================= WATER GOAL =================
  void markWaterGoal(bool achieved) {
    weeklyWaterStatus[currentDay.value - 1] = achieved;
    saveData();
  }

  /// ================= RESET WEEK =================
  void resetWeek() {
    currentDay.value = 1;
    weeklyCheckinStatus.value = List.generate(7, (_) => false);
    weeklyWaterStatus.value = List.generate(7, (_) => false);
    isCheckedToday.value = false;
    saveData();
  }

  /// ================= SAVE =================
  void saveData() {
    prefs?.setInt('currentDay', currentDay.value);
    prefs?.setStringList(
        'weeklyCheckinStatus', weeklyCheckinStatus.map((e) => e.toString()).toList());
    prefs?.setStringList(
        'weeklyWaterStatus', weeklyWaterStatus.map((e) => e.toString()).toList());
  }

  /// ================= GETTERS =================
  int get checkedInDays => weeklyCheckinStatus.where((e) => e).length;
  int get waterGoalDays => weeklyWaterStatus.where((e) => e).length;
}