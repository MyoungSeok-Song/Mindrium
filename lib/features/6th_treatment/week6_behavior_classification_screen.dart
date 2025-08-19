import 'package:flutter/material.dart';
import 'package:gad_app_team/widgets/custom_appbar.dart';
import 'package:gad_app_team/widgets/navigation_button.dart';
import 'package:provider/provider.dart';
import 'package:gad_app_team/data/user_provider.dart';
import 'week6_behavior_reflection_screen.dart';

class Week6BehaviorClassificationScreen extends StatelessWidget {
  final String selectedBehavior;
  final String behaviorType; // 'face' 또는 'avoid'
  final double shortTermValue; // 단기 슬라이더 값
  final double longTermValue; // 장기 슬라이더 값
  final List<String>? remainingBehaviors; // 남은 행동 목록
  final List<String> allBehaviorList; // 전체 행동 목록

  const Week6BehaviorClassificationScreen({
    super.key,
    required this.selectedBehavior,
    required this.behaviorType,
    required this.shortTermValue,
    required this.longTermValue,
    this.remainingBehaviors,
    required this.allBehaviorList,
  });

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context, listen: false).userName;

    // 분류 로직
    bool isShortTermHigh = shortTermValue == 10;
    bool isLongTermHigh = longTermValue == 10;

    String mainText;
    // 조건별 자연스러운 문장
    if (isShortTermHigh && !isLongTermHigh) {
      // 단기 높고 장기 낮음 → 회피
      mainText =
          '방금 보셨던 "$selectedBehavior"(라)는 행동에 대해 단기적으로는 불안이 많이 완화되지만 장기적으로는 적게 완화된다고 해주셨습니다. \n\n이런 행동은 보통 불안을 회피하는 행동에 가깝기 때문에, 일시적으로는 불안이 완화되어 편안함을 주지만 지속 시 불안을 해결하는 데 큰 도움이 되지 않을 수 있어요!';
    } else if (!isShortTermHigh && isLongTermHigh) {
      // 단기 낮고 장기 높음 → 직면
      mainText =
          '방금 보셨던 "$selectedBehavior"(라)는 행동에 대해 단기적으로는 불안이 적게 완화되지만 장기적으로는 많이 완화된다고 해주셨습니다. \n\n이런 행동은 보통 불안을 직면하는 행동에 가깝기 때문에, 일시적으로 불안이 높아져서 처음에는 어려울 수 있지만 지속 시 불안을 해결하는 데 도움이 될 수 있어요!';
    } else if (isShortTermHigh && isLongTermHigh) {
      // 단기/장기 모두 높음 → 중립적(긍정)
      mainText =
          '방금 보셨던 "$selectedBehavior"(라)는 행동에 대해 단기적으로도 장기적으로도 불안이 많이 완화된다고 해주셨습니다. \n\n좋은 부분도 있지만 여기서 주의할 점이 있어요. 만약 불안을 줄이는 데 ‘안전장치’를 썼다면 뇌는 여전히 그 장치 없이는 불안하다고 배울 수 있어요. 반대로 안전장치 없이도 불안이 줄었다면 저강도 직면이 잘 된 거예요. 이 행동이 어느 쪽에 가까운지 생각해보시면 좋을거 같아요.';
    } else {
      // 단기/장기 모두 낮음 → 중립적(부정)
      mainText =
          '방금 보셨던 "$selectedBehavior"(라)는 행동에 대해 단기적으로도 장기적으로도 불안이 적게 완화된다고 해주셨습니다. \n\n이런 행동은 불안을 유지시키거나 더 키웠을 수도 있어요. 다음엔 불안이 완화될 수 있는 가능성이 조금이라도 있는 행동을 생각해보시면 좋을거 같아요.';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF),
      appBar: const CustomAppBar(title: '6주차 - 불안 직면 VS 회피'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
                      '$userName님',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5B3EFF),
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xFF5B3EFF).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      mainText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.5,
                        letterSpacing: 0.1,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: NavigationButtons(
          onBack: () => Navigator.pop(context),
          onNext: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder:
                    (_, __, ___) => Week6BehaviorReflectionScreen(
                      selectedBehavior: selectedBehavior,
                      behaviorType: behaviorType,
                      shortTermValue: shortTermValue,
                      longTermValue: longTermValue,
                      remainingBehaviors: remainingBehaviors,
                      allBehaviorList: allBehaviorList,
                    ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
        ),
      ),
    );
  }
}
