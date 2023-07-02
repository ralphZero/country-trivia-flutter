import 'package:country_quiz/mocks/question_cms.dart';
import 'package:country_quiz/utils/constants.dart';
import 'package:country_quiz/widgets/question/question_flag.dart';
import 'package:country_quiz/widgets/question/question_prompt.dart';
import 'package:country_quiz/widgets/question/score_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../features/models/app_state.dart';
import '../features/models/question.dart';
import '../widgets/question/answer_list.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var cms = QuestionPageCMS();
  late Question currentQuestion;

  @override
  void initState() {
    super.initState();
  }

  void handleOnClose() {
    print('tap');
    return;
  }

  @override
  Widget build(BuildContext context) {
    double customAppBarHeight = MediaQuery.of(context).size.height * 0.05;
    double customScoreHeight = MediaQuery.of(context).size.height * 0.2;
    double dynamicMargin = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: pageGradient,
          ),
          child: Column(
            children: [
              SizedBox(
                height: customAppBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: handleOnClose,
                      color: Colors.white,
                    ),
                    Text(
                      'timer',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: customScoreHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScoreBox(
                      currScore: 0,
                      cms: cms,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width - dynamicMargin,
                  margin: EdgeInsets.fromLTRB(
                    dynamicMargin,
                    dynamicMargin,
                    dynamicMargin,
                    dynamicMargin * 2,
                  ),
                  padding: const EdgeInsets.all(18.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  child: Consumer<AppState>(
                    builder: (ctx, state, child) {
                      bool hasFlag = state.getCurrentQuestion!.hasFlag;
                      var capital = state.getCurrentQuestion!.question.capital;
                      var flagUrl = state.getCurrentQuestion!.question.flag;
                      var answers = state.getCurrentQuestion!.answers;
                      var answerId = state.getCurrentQuestion!.currAnswer;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QuestionFlag(
                            flagUrl: flagUrl,
                            hasFlag: hasFlag,
                          ),
                          Flexible(
                            child: QuestionPrompt(
                              capital: capital,
                              hasFlag: hasFlag,
                              cms: cms,
                            ),
                          ),
                          AnswerList(
                            answers: answers,
                            answerId: answerId,
                            onOptionPressed: (selectedId) {},
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
