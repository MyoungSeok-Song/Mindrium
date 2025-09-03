import 'package:flutter/material.dart';
import 'package:gad_app_team/common/constants.dart';
import 'package:gad_app_team/widgets/custom_appbar.dart';
import 'package:gad_app_team/widgets/navigation_button.dart';
import 'package:gad_app_team/features/7th_treatment/week7_add_display_screen.dart';

class Week7GainLoseScreen extends StatefulWidget {
  final String behavior;

  const Week7GainLoseScreen({super.key, required this.behavior});

  @override
  State<Week7GainLoseScreen> createState() => _Week7GainLoseScreenState();
}

class _Week7GainLoseScreenState extends State<Week7GainLoseScreen> {
  final TextEditingController _executionGainController =
      TextEditingController();
  final TextEditingController _executionLoseController =
      TextEditingController();
  final TextEditingController _nonExecutionGainController =
      TextEditingController();
  final TextEditingController _nonExecutionLoseController =
      TextEditingController();

  int _currentStep = 0; // 0: 실행 시 이익, 1: 실행 시 불이익, 2: 미실행 시 이익, 3: 미실행 시 불이익
  bool _isNextEnabled = false;

  @override
  void initState() {
    super.initState();
    _executionGainController.addListener(_onTextChanged);
    _executionLoseController.addListener(_onTextChanged);
    _nonExecutionGainController.addListener(_onTextChanged);
    _nonExecutionLoseController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _executionGainController.dispose();
    _executionLoseController.dispose();
    _nonExecutionGainController.dispose();
    _nonExecutionLoseController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      switch (_currentStep) {
        case 0:
          _isNextEnabled = _executionGainController.text.trim().isNotEmpty;
          break;
        case 1:
          _isNextEnabled = _executionLoseController.text.trim().isNotEmpty;
          break;
        case 2:
          _isNextEnabled = _nonExecutionGainController.text.trim().isNotEmpty;
          break;
        case 3:
          _isNextEnabled = _nonExecutionLoseController.text.trim().isNotEmpty;
          break;
      }
    });
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
        _isNextEnabled = false;
      });
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return '실행 시 이익';
      case 1:
        return '실행 시 불이익';
      case 2:
        return '미실행 시 이익';
      case 3:
        return '미실행 시 불이익';
      default:
        return '';
    }
  }

  String _getStepDescription() {
    switch (_currentStep) {
      case 0:
        return '이 행동을 건강한 생활 습관에 추가해서\n했을 때 얻을 수 있는 이익은 무엇인가요?';
      case 1:
        return '이 행동을 건강한 생활 습관에 추가해서\n했을 때 겪을 수 있는 불이익은 무엇인가요?';
      case 2:
        return '이 행동을 하지 않았을 때\n얻을 수 있는 이익은 무엇인가요?';
      case 3:
        return '이 행동을 하지 않았을 때\n겪을 수 있는 불이익은 무엇인가요?';
      default:
        return '';
    }
  }

  IconData _getStepIcon() {
    switch (_currentStep) {
      case 0:
        return Icons.trending_up;
      case 1:
        return Icons.trending_down;
      case 2:
        return Icons.trending_up;
      case 3:
        return Icons.trending_down;
      default:
        return Icons.help;
    }
  }

  Color _getStepColor() {
    switch (_currentStep) {
      case 0:
        return const Color(0xFF4CAF50); // 초록색 (이익)
      case 1:
        return const Color(0xFFFF5722); // 빨간색 (불이익)
      case 2:
        return const Color(0xFF4CAF50); // 초록색 (이익)
      case 3:
        return const Color(0xFFFF5722); // 빨간색 (불이익)
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  TextEditingController _getCurrentController() {
    switch (_currentStep) {
      case 0:
        return _executionGainController;
      case 1:
        return _executionLoseController;
      case 2:
        return _nonExecutionGainController;
      case 3:
        return _nonExecutionLoseController;
      default:
        return _executionGainController;
    }
  }

  void _showAddToHealthyHabitsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.health_and_safety,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '건강한 생활 습관 추가',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이 행동을 건강한 생활 습관에\n추가하시겠습니까?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF718096),
                  height: 1.4,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (_, __, ___) => const Week7AddDisplayScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Text(
                      '아니요',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (_, __, ___) => Week7AddDisplayScreen(
                                initialBehavior: widget.behavior,
                              ),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      '예',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF),
      appBar: const CustomAppBar(title: '7주차 - 생활 습관 개선'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 진행 단계 표시
              Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                      decoration: BoxDecoration(
                        color:
                            index <= _currentStep
                                ? _getStepColor()
                                : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              // 단계 아이콘
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_getStepColor(), _getStepColor().withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: _getStepColor().withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(_getStepIcon(), size: 48, color: Colors.white),
              ),

              const SizedBox(height: 24),

              // 단계 제목
              Text(
                _getStepTitle(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: _getStepColor(),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // 단계 설명
              Text(
                _getStepDescription(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF718096),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // 텍스트 입력 필드
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getStepColor().withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _getStepColor().withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _getCurrentController(),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: '여기에 입력해주세요...',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: _getStepColor().withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2D3748),
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: NavigationButtons(
          onBack: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
                _isNextEnabled = _getCurrentController().text.trim().isNotEmpty;
              });
            } else {
              Navigator.pop(context);
            }
          },
          onNext:
              _isNextEnabled
                  ? () {
                    if (_currentStep < 3) {
                      _nextStep();
                    } else {
                      // 모든 단계 완료, 모달창 표시
                      _showAddToHealthyHabitsDialog();
                    }
                  }
                  : null,
        ),
      ),
    );
  }
}
