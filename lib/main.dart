import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // DateFormat을 사용하기 위해 추가
import 'package:flutter/cupertino.dart';
import 'Calendar.dart';
import 'Goal.dart';
import 'Widget.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoalProvider(),
      child: MaterialApp(
        initialRoute: '/main', // 초기 경로를 지정
        routes: {
          '/main': (context) => MainScreen(), // 로그인 화면
          // '/': (context) => splash(), // 로그인 화면
          '/calender': (context) => Calendar(), // 채팅 화면
          // '/friend': (context) => friend(), // 뒤로
        },
        title: '목표 달성 앱',
        home: Calendar(),
      ),
    );
  }
}


class MainScreen extends StatelessWidget {
  TextEditingController _goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9FB),
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoalButtons(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (Provider.of<GoalProvider>(context, listen: false)
                      .hasSelectedGoals()) {
                    // 선택된 목표가 있을 때만 삭제
                    Provider.of<GoalProvider>(context, listen: false)
                        .removeSelectedGoals();
                  } else {
                    // 첫 번째 버튼을 눌렀을 때 나타날 팝업
                    _showFirstPopup(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Provider.of<GoalProvider>(context).hasSelectedGoals()
                      ? Color(0xffffffff)
                      : Color(0xffffffff),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(108, 37),
                  elevation: 0,
                ),
                child: Consumer<GoalProvider>(
                  builder: (context, goalProvider, child) {
                    return Text(
                      goalProvider.hasSelectedGoals() ? '삭제하기' : '다짐 추가하기',
                      style: TextStyle(
                        color: goalProvider.hasSelectedGoals()
                            ? Color(0xffFF6B6B)
                            : Color(0xff3885E0),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),

    );
  }

  void _showFirstPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: 300,
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(34),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 26, top: 26),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '어떤 다짐을 할까요?',
                            style: TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 18,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 0.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 26, right: 26),
                        child: TextField(
                          controller: _goalController,
                          onChanged: (value) {
                            // 입력값이 변경될 때마다 상태를 업데이트
                            setState(() {});
                          },
                          maxLines: null, // 이 부분을 추가하여 자동으로 줄 바꿈되도록 설정
                          maxLength: 100, // 최대 입력 가능한 문자 수 설정
                          decoration: InputDecoration(
                            labelText: '이 곳에 입력해주세요:)',
                            labelStyle: TextStyle(
                              color: Color(0xFFDBDBDB),
                              fontSize: 18,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0.0,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: ElevatedButton(
                              onPressed: _goalController.text.isNotEmpty
                                  ? () {
                                      // 입력한 목표를 저장하고 팝업 닫기
                                      _saveGoal(context, _goalController.text);
                                      _goalController.clear();
                                      Navigator.pop(context);
                                    }
                                  : null, // 입력이 없을 때 버튼 비활성화
                              style: ElevatedButton.styleFrom(
                                primary: _goalController.text.isNotEmpty
                                    ? Color(0xFF3885E0) // 입력이 있을 때의 배경색ㅁ
                                    : null,
                                // 입력이 없을 때 null로 설정하여 기본 회색 사용
                                onSurface: Color(0x993885E0),
                                // 비활성화 상태일 때의 배경색
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                                minimumSize:
                                    Size(double.infinity, 0), // 최소 크기 지정
                              ),
                              child: Text(
                                _goalController.text.isNotEmpty
                                    ? '다짐 완료!'
                                    : '다짐 생각중..',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  height: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void _saveGoal(BuildContext context, String goal) {
    if (goal.isNotEmpty) {
      Provider.of<GoalProvider>(context, listen: false).setGoal(goal);
    }
  }
}


Widget buildBottomNavigationBar(BuildContext context) {
  return Container(
    width: 390,
    height: 82,
    decoration: ShapeDecoration(
      color: Color(0xFFF9F9FB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      shadows: [
        BoxShadow(
          color: Color(0x0C000000),
          blurRadius: 4,
          offset: Offset(0, -2),
          spreadRadius: 0,
        )
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(right: 80.0,left: 80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/calender');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.calendar, color: Color(0xFFADB5BD)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/main');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.house, color: Color(0xFFADB5BD)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.person_add, color: Color(0xFFADB5BD)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

