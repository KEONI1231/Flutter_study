import 'package:flutter/material.dart';
import 'package:per_pro/constant/color.dart';
import 'package:per_pro/screen/free_board.dart';
import 'package:per_pro/screen/love_board.dart';
import 'package:per_pro/screen/meal_board.dart';
import 'package:per_pro/screen/study_board.dart';

import '../component/meal_info.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeMeal(),
        _HomeWordCloud(),
        _HomeBannerAd(),
        _HomeBoard(),
      ],
    );
  }
}

class _HomeMeal extends StatelessWidget {
  const _HomeMeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: SizedBox(
            height: 80,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              color: BRIGHT_COLOR,
              child: LayoutBuilder(builder: (context, constraint) {
                constraint.maxWidth;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          '급식',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: PageScrollPhysics(),
                        children: List.generate(
                          20,
                          (index) => MealInfo(
                            width: constraint.maxWidth / 3,
                            mealdate: '2022-08-20',
                            meal: '돈가스',
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeWordCloud extends StatelessWidget {
  const _HomeWordCloud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            '<오늘의 워드클라우드>',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
          Image.asset(
            'asset/img/word_cloud.png',
            height: 200.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              DefaultTabController.of(context)?.animateTo(1);
            },
            child: Text('의견 반영하기'),
          ),
        ],
      ),
    );
  }
}

class _HomeBannerAd extends StatelessWidget {
  const _HomeBannerAd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('배너 광고'),
    );
  }
}

class _HomeBoard extends StatelessWidget {
  const _HomeBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return FreeBoard(); //자유 게시판
              }));
            },
            child: HomeBoardGenerate('자유게시판', '자유게시판의 최근 올라온 게시글 내용'),
          ),
          SizedBox(
            height: 2.0,
          ),
          GestureDetector(
            //워드클라우드게시판 누르면 워드클라우드 게시판으로 이동
            onTap: () {
              DefaultTabController.of(context)?.animateTo(1);
            },
            child: HomeBoardGenerate('워드클라우드게시판', '워드클라우드게시판의 최근 올라온 게시글 내용'),
          ),
          SizedBox(
            height: 2.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return MealBoard(); //급식 게시판
              }));
            },
            child: HomeBoardGenerate('급식게시판', '급식게시판의 최근 올라온 게시글 내용'),
          ),
          SizedBox(
            height: 2.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return StudyBoard(); //입시게시판
              }));
            },
            child: HomeBoardGenerate('입시게시판', '입시게시판의 최근 올라온 게시글 내용'),
          ),
          SizedBox(
            height: 2.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return LoveBoard(); //연애 게시판
              }));
            },
            child: HomeBoardGenerate('연애게시판', '연애게시판의 최근 올라온 게시글 내용'),
          ),
        ],
      ),
    );
  }
}

Widget HomeBoardGenerate(String BoardName, String BoardContent) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          BoardName,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          BoardContent,
        ),
      ],
    ),
  );
}
