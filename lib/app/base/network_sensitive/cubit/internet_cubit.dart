import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_state.dart';


// enum InternetState{Initial, Lost, Gained}

class InternetCubit extends Cubit<InternetState>{

  Connectivity _connectivity = Connectivity();

  StreamSubscription? _connectivitySubscription;


  InternetCubit(): super(InternetInitialState()){

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        emit(InternetGainedState());
      }else {
        emit(InternetLostState());
      }
    });

  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }



}
