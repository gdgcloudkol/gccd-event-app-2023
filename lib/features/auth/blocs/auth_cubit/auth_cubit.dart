import 'package:ccd2023/configurations/configurations.dart';
import 'package:ccd2023/features/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_cubit.freezed.dart';

part 'auth_cubit.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    User? user,
    String? accessToken,
    String? refreshToken,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}

class AuthCubit extends HydratedCubit<AuthState> {
  static AuthCubit get instance => _instance;
  static final AuthCubit _instance = AuthCubit._internal();
  AuthenticationRepository? _authenticationRepository;

  AuthCubit._internal() : super(const AuthState());

  void initialize(AuthenticationRepository authenticationRepository) {
    if (_authenticationRepository != null) {
      throw Exception('Already initialized');
    }
    _authenticationRepository = authenticationRepository;
  }

  Future<void> fetchProfile() async {
    try {
      if (_authenticationRepository == null) {
        throw Exception('AuthCubit not initialized');
      }
      final profile = await _authenticationRepository?.getProfile(authToken: state.accessToken!);
      if (profile != null) {
        emit(
          state.copyWith(
            user: state.user!.copyWith(
              profile: profile,
            )
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data as Map<String, dynamic>;
        if (errorData.containsKey('non_field_errors')) {
          DjangoflowAppSnackbar.showError(
            errorData['non_field_errors'][0],
          );
        } else {
          DjangoflowAppSnackbar.showError(
            errorData.toString(),
          );
        }
      } else {
        DjangoflowAppSnackbar.showError(e.message ?? 'Error occurred');
      }
    } on Exception catch (e) {
      DjangoflowAppSnackbar.showError(e.toString());
    }
  }

  void _login(
    User user,
    String accessToken,
    String refreshToken,
  ) =>
      emit(
        state.copyWith(
          user: user,
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      );

  void logout() {
    emit(
      state.copyWith(
        user: null,
        accessToken: null,
        refreshToken: null,
      ),
    );
  }

  Future<void> loginWithUsernamePassword({
    required String password,
    required String username,
  }) async {
    try {
      if (_authenticationRepository == null) {
        throw Exception('AuthCubit not initialized');
      }
      final loginResponse = await _authenticationRepository?.signIn(
        email: '',
        username: username,
        password: password,
      );
      if (loginResponse != null) {
        _login(
          loginResponse.user,
          loginResponse.accessToken,
          loginResponse.refreshToken,
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data as Map<String, dynamic>;
        if (errorData.containsKey('non_field_errors')) {
          DjangoflowAppSnackbar.showError(
            errorData['non_field_errors'][0],
          );
        } else {
          DjangoflowAppSnackbar.showError(
            errorData.toString(),
          );
        }
      } else {
        DjangoflowAppSnackbar.showError(e.message ?? 'Error occurred');
      }
    } on Exception catch (e) {
      DjangoflowAppSnackbar.showError(e.toString());
    }
  }

  Future<void> signUpWithUsernamePassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      if (_authenticationRepository == null) {
        throw Exception('AuthCubit not initialized');
      }
      final signUpResponse = await _authenticationRepository?.signUp(
        email: email,
        username: username,
        password: password,
      );
      if (signUpResponse != null) {
        DjangoflowAppSnackbar.showInfo(
          'Sign up successful! Please verify email and login.',
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data as Map<String, dynamic>;
        if (errorData.containsKey('email')) {
          DjangoflowAppSnackbar.showError(
            errorData['email'][0],
          );
        } else if (errorData.containsKey('username')) {
          DjangoflowAppSnackbar.showError(
            errorData['username'][0],
          );
        } else {
          DjangoflowAppSnackbar.showError(
            errorData.toString(),
          );
        }
      } else {
        DjangoflowAppSnackbar.showError(e.message ?? 'Error occurred');
      }
    } on Exception catch (e) {
      DjangoflowAppSnackbar.showError(e.toString());
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      if (_authenticationRepository == null) {
        throw Exception('AuthCubit not initialized');
      }
      final forgotPasswordResponse =
          await _authenticationRepository?.resetPassword(
        email: email,
      );
      if (forgotPasswordResponse != null) {
        if (forgotPasswordResponse['detail'] == passwordResetResponse) {
          DjangoflowAppSnackbar.showInfo(
            'Password reset email sent!',
          );
        }
      }
    } on DioError catch (e) {
      DjangoflowAppSnackbar.showError(e.message ?? 'Error occurred');
    } on Exception catch (e) {
      DjangoflowAppSnackbar.showError(e.toString());
    }
  }

  Future<void> addReferrar({
    required String referrer,
  }) async {
    try {
      if (_authenticationRepository == null) {
        throw Exception('AuthCubit not initialized');
      }
      await _authenticationRepository?.addReferrar(
        authToken: state.accessToken!,
        referrer: referrer,
      );
    } on DioError catch (e) {
      DjangoflowAppSnackbar.showError(e.message ?? 'Error occurred');
    } on Exception catch (e) {
      DjangoflowAppSnackbar.showError(e.toString());
    }
  }

  Future<void> updateProfile({
    required String pronoun,
    required String firstName,
    required String lastName,
    required String phone,
    required String course,
    required String college,
    required int graduationYear,
    required String company,
    required String country,
    required String tSize,
    required String role,
    required String foodChoice,
  }) async {
    try {
      if (_authenticationRepository == null) {
        throw Exception('AuthCubit not initialized');
      }
      final updateProfileResponse =
          await _authenticationRepository?.updateProfile(
        authToken: state.accessToken!,
        profile: state.user!.profile.copyWith(
          pronoun: pronoun,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          course: course,
          graduationYear: graduationYear,
          college: college,
          company: company,
          countryCode: country,
          tSize: tSize,
          settings: {},
          role: role,
          foodChoice: foodChoice,
          socials: state.user?.profile.socials ?? {},
        ),
      );
      if (updateProfileResponse != null) {
        emit(
          state.copyWith(
            user: state.user?.copyWith(profile: updateProfileResponse),
          ),
        );
      }
    } on DioError catch (e) {
      DjangoflowAppSnackbar.showError(e.message ?? 'Error occurred');
    } on Exception catch (e) {
      DjangoflowAppSnackbar.showError(e.toString());
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  void updateSocialLink(String url) {
    final socialLinkMap = buildSocialLinkMap(
      url: url,
      existingLinks: state.user?.profile.socials ?? {},
    );

    emit(
      state.copyWith(
        user: state.user?.copyWith(
          profile: state.user!.profile.copyWith(
            socials: socialLinkMap,
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> buildSocialLinkMap(
      {required String url, required Map<String, dynamic> existingLinks}) {
    if (url.contains('facebook')) {
      return {
        ...existingLinks,
        'facebook': url,
      };
    } else if (url.contains('github')) {
      return {
        ...existingLinks,
        'github': url,
      };
    } else if (url.contains('instagram')) {
      return {
        ...existingLinks,
        'instagram': url,
      };
    } else if (url.contains('linkedin')) {
      return {
        ...existingLinks,
        'linkedin': url,
      };
    } else {
      return {
        ...existingLinks,
        'website': url,
      };
    }
  }
}
