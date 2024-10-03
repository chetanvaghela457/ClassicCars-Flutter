import 'package:bloc/bloc.dart';

import '../../constants/application.dart';
import 'bloc.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final Application application = Application();

  ApplicationBloc() : super(ApplicationInitial()) {
    on<SetupApplication>((event, emit) {
      // Handle the SetupApplication event
      try {
        // Perform setup logic here
        emit(ApplicationCompleted());
      } catch (error) {
        // emit(ApplicationSetupFailure());
      }
    });
  }

  // @override
  // Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
  //   if (event is SetupApplication) {
  //     /// Setup SharedPreferences
  //     await application.setPreferences();
  //
  //     // /// Get old settings
  //     // final oldLanguage = LocalPref.getString("language");
  //     //
  //     // if (oldLanguage != null) {
  //     //   CommonBloc.languageBloc.add(LanguageChanged(Locale(oldLanguage)));
  //     // }
  //     //
  //     // /// Authentication begin check
  //     // CommonBloc.authencationBloc.add(AuthenticationStarted());
  //
  //     yield ApplicationCompleted();
  //   }
  // }
}
