import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';



class GoalProvider extends ChangeNotifier {
  List<String> _dailyGoals = [];
  Set<String> _selectedGoals = {};

  List<String> get dailyGoals => _dailyGoals;

  Set<String> get selectedGoals => _selectedGoals;

  void setGoal(String goal) {
    _dailyGoals.add(goal);
    notifyListeners();
  }

  void removeGoal(String goal) {
    _dailyGoals.remove(goal);
    _selectedGoals.remove(goal);
    notifyListeners();
  }

  void toggleGoalSelection(String goal) {
    if (_selectedGoals.contains(goal)) {
      _selectedGoals.remove(goal);
    } else {
      _selectedGoals.add(goal);
    }
    notifyListeners();
  }

  void removeSelectedGoals() {
    for (var goal in _selectedGoals.toList()) {
      removeGoal(goal);
    }
    notifyListeners();
  }

  bool isGoalSelected(String goal) {
    return _selectedGoals.contains(goal);
  }

  bool hasSelectedGoals() {
    return _selectedGoals.isNotEmpty;
  }
}

class GoalButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoalProvider goalProvider = Provider.of<GoalProvider>(context);

    double boxWidth =
        MediaQuery.of(context).size.width - 52; // 화면 너비에서 20을 뺍니다.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: goalProvider.dailyGoals.map((goal) {
        return Container(
          width: boxWidth,
          height: 60, // 원하는 세로 크기로 조절
          margin: EdgeInsets.only(bottom: 10), // 여백을 20으로 설정
          child: ElevatedButton(
            onPressed: () {
              Provider.of<GoalProvider>(context, listen: false)
                  .toggleGoalSelection(goal);
            },
            style: ElevatedButton.styleFrom(
              primary: goalProvider.isGoalSelected(goal)
                  ? Color(0xffeeeeee)
                  : Color(0xffF9F9FB),
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 이 부분을 수정
              children: [
                SizedBox(width: 16), // 아이콘과 왼쪽 여백
                Icon(
                  Icons.check_circle, // 원하는 아이콘으로 변경 가능
                  size: 20,
                  color: goalProvider.isGoalSelected(goal)
                      ? Color(0xff00FF00) // 선택되었을 때의 아이콘 색상
                      : Color(0xff333333), // 선택되지 않았을 때의 아이콘 색상
                ),
                SizedBox(width: 10), // 아이콘과 텍스트 사이의 간격 조절
                Flexible(
                  child: Text(
                    goal,
                    style: TextStyle(
                      color: goalProvider.isGoalSelected(goal)
                          ? Color(0xffdbdbdb)
                          : Color(0xff333333),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(width: 40), // 아이콘과 텍스트 사이의 간격 조절
                Icon(
                  Icons.add, // 오른쪽에 추가할 아이콘
                  size: 20,
                  color: Colors.blue, // 아이콘 색상 설정
                ),
                SizedBox(width: 16), // 아이콘과 왼쪽 여백
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CalendarGoalButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoalProvider goalProvider = Provider.of<GoalProvider>(context);

    double boxWidth = MediaQuery.of(context).size.width - 52;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: goalProvider.dailyGoals.map((goal) {
        return Container(
          width: boxWidth,
          height: 60,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: goalProvider.isGoalSelected(goal)
                ? Color(0xffF9F9FB)
                : Color(0xffF9F9FB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              Icon(
                Icons.check_circle,
                size: 20,
                color: Color(0xff333333),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  goal,
                  style: TextStyle(
                    color: goalProvider.isGoalSelected(goal)
                        ? Color(0xff333333)
                        : Color(0xff333333),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}