abstract class NewsStates{}

class NewsInitialStates extends NewsStates{}

class NewsBottomNavStates extends NewsStates{}

class NewsGetBusinessSucessState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{

  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsSucessState extends NewsStates{}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{

  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceSucessState extends NewsStates{}

class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates{

  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchSucessState extends NewsStates{}

class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{

  final String error;

  NewsGetSearchErrorState(this.error);
}



