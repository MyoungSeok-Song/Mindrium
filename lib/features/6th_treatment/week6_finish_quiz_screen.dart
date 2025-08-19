import 'package:flutter/material.dart';
import 'package:gad_app_team/widgets/custom_appbar.dart';
import 'package:gad_app_team/widgets/navigation_button.dart';

class Week6FinishQuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>>
  mismatchedBehaviors; // [{behavior: ..., userChoice: ..., actualResult: ...}]

  const Week6FinishQuizScreen({super.key, required this.mismatchedBehaviors});

  @override
  State<Week6FinishQuizScreen> createState() => _Week6FinishQuizScreenState();
}

class _Week6FinishQuizScreenState extends State<Week6FinishQuizScreen> {
  int _currentIdx = 0;
  Map<int, String> _answers = {};

  @override
  Widget build(BuildContext context) {
    final behaviorList = widget.mismatchedBehaviors;
    final isLast = _currentIdx == behaviorList.length - 1;
    final current = behaviorList.isNotEmpty ? behaviorList[_currentIdx] : null;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF),
      appBar: const CustomAppBar(title: '6주차 - 마무리 퀴즈'),
      body: Center(
        child:
            behaviorList.isEmpty
                ? const Text('일치하지 않은 행동이 없습니다!')
                : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28.0,
                          vertical: 48.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '아래 행동은 본인 선택과 실제 분석 결과가 달랐던 항목입니다.\n각 행동이 불안을 직면하는 행동인지, 회피하는 행동인지 선택해 주세요.',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            if (current != null) ...[
                              Text(
                                '행동: "${current['behavior']}"',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(
                                        () => _answers[_currentIdx] = 'face',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          _answers[_currentIdx] == 'face'
                                              ? const Color(0xFF5B3EFF)
                                              : Colors.white,
                                      foregroundColor:
                                          _answers[_currentIdx] == 'face'
                                              ? Colors.white
                                              : const Color(0xFF5B3EFF),
                                      side: const BorderSide(
                                        color: Color(0xFF5B3EFF),
                                        width: 2,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                        horizontal: 24,
                                      ),
                                    ),
                                    child: const Text(
                                      '직면',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(
                                        () => _answers[_currentIdx] = 'avoid',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          _answers[_currentIdx] == 'avoid'
                                              ? const Color(0xFFFF5252)
                                              : Colors.white,
                                      foregroundColor:
                                          _answers[_currentIdx] == 'avoid'
                                              ? Colors.white
                                              : const Color(0xFFFF5252),
                                      side: const BorderSide(
                                        color: Color(0xFFFF5252),
                                        width: 2,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                        horizontal: 24,
                                      ),
                                    ),
                                    child: const Text(
                                      '회피',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Text(
                                '내 선택: ${current['userChoice']}\n실제 분류: ${current['actualResult']}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF8888AA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
      ),
      bottomNavigationBar:
          behaviorList.isEmpty
              ? null
              : Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: NavigationButtons(
                  onBack:
                      _currentIdx > 0
                          ? () => setState(() => _currentIdx--)
                          : null,
                  onNext:
                      _answers[_currentIdx] != null
                          ? () {
                            if (!isLast) {
                              setState(() => _currentIdx++);
                            } else {
                              // TODO: 마지막 결과 처리(예: 홈 이동 등)
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/home',
                                (route) => false,
                              );
                            }
                          }
                          : null,
                ),
              ),
    );
  }
}
