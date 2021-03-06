import 'package:bloc/bloc.dart';
import 'package:flutter_local_db/src/core/data/hive_constants.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/models/address_model.dart';
import 'package:flutter_local_db/src/core/models/company_model.dart';
import 'package:flutter_local_db/src/core/models/geo_model.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/app_repository.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';
import 'package:hive/hive.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  final AppRepository _appRepository = AppRepository();

  SplashBloc() : super(SplashStateInit()) {
    on<SplashEventInit>(_getListUser);
  }

  void _getListUser(SplashEventInit event, Emitter<SplashState> emit) async {
    Box<User> boxUsers = await Hive.openBox<User>(USERS);
    try {
      List<User> users = await _appRepository.getUser();
      boxUsers.clear().then((value) => {
        users.forEach((User user) {
          _insertUser(boxUsers, user);
        })
      });
      emit(SplashStateSuccess(listUser: users));
    } catch (e) {
      emit(SplashStateFailed(e));
    }
  }

  void _insertUser(Box<User> box, User user) {
    User _user = User(
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        address: Address(
            street: user.address.street,
            suite: user.address.suite,
            city: user.address.city,
            zipcode: user.address.zipcode,
            geo: Geo(
                lat: user.address.geo.lat,
                lng: user.address.geo.lng
            )
        ),
        phone: user.phone,
        website: user.website,
        company: Company(
            name: user.company.name,
            catchPhrase: user.company.catchPhrase,
            bs: user.company.bs
        )
    );
    box.add(_user);
  }

}