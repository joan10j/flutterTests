//ITS HANDY TO IMPLEMENT OUR OWN BLOC DELEGATE WHICH ALLOWS US TO OVERRIDE ON TRANSITION AND ONERROR
// AND WILL HELP US SE ALL BLOC STATE CHANGES IN ONE PLACE

import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate{

  @override
  void onEvent(Bloc bloc,Object event){
    super.onEvent(bloc, event);
    print(event);
  }

  @override 
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print(transition);
  }

}