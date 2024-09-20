import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/news_cubit/states.dart';
import '../../../modules/business/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center),
      label: 'Business'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_martial_arts),
      label: 'Sports'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science),
      label: 'Science'
    ),

  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    currentindex = index;

    if(index == 1) {
      getSports();
    }
    if(index == 2) {
      getScience();
    }
    emit(NewsBottomNavStates());

  }
  
  List<dynamic> business = [];
  
  void getBusiness(){

    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query:{
      'country':'us',
      'category':'business',
      'apiKey':'197a34e64c254568a246217ec47c5e94',
    }).then((value){
      business = value?.data['articles'];
      print(business[0]['title']);
      
      emit(NewsGetBusinessSucessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports(){

    emit(NewsGetSportsLoadingState());

    if (sports.isEmpty){
      DioHelper.getData(url: 'v2/top-headlines', query:{
        'country':'us',
        'category':'sports',
        'apiKey':'197a34e64c254568a246217ec47c5e94',
      }).then((value){
        sports = value?.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSucessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });

    }else{
      emit(NewsGetSportsSucessState());

    }


  }

  List<dynamic> science = [];

  void getScience(){

    emit(NewsGetScienceLoadingState());

    if (science.isEmpty){
      DioHelper.getData(url: 'v2/top-headlines', query:{
        'country':'us',
        'category':'science',
        'apiKey':'197a34e64c254568a246217ec47c5e94',
      }).then((value){
        science = value?.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSucessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });

    }else{
      emit(NewsGetScienceSucessState());
    }

  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '197a34e64c254568a246217ec47c5e94',
    }).then((value) {
      search = value?.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }




}