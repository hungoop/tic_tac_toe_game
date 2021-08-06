
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/utils/utils.dart';

class SimpleBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    UtilLogger.log('BLOC EVENT', '${bloc.runtimeType}, event: $event');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    UtilLogger.log('BLOC CREATE', '${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    UtilLogger.log('BLOC CHANGE', '${bloc.runtimeType}, change: hide data');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);

    UtilLogger.log('BLOC CLOSE', '${bloc.runtimeType}');
  }



  /*
  @override
  void onEvent(Cubit cubit, Object event) {
    super.onEvent(cubit, event);
    UtilLogger.log('BLOC EVENT', '${cubit.runtimeType}, event: $event');
  }

  @override
  void onTransition(Cubit cubit, Transition transition) {
    super.onTransition(cubit, transition);
  }

  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    UtilLogger.log('BLOC CREATE', '${cubit.runtimeType}');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print('${cubit.runtimeType}, change: $change');
    //UtilLogger.log('BLOC CHANGE', '${cubit.runtimeType}, change: $change');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    UtilLogger.log('BLOC ERROR', '${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    print('onClose -- cubit: ${cubit.runtimeType}');
  }
*/
}