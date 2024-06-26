import 'package:exercies3/common/widgets/app_button.dart';
import 'package:exercies3/common/widgets/app_text_form_field.dart';
import 'package:exercies3/features/auth/controller/auth_controller.dart';
import 'package:exercies3/common/model/user_entity.dart';
import 'package:exercies3/features/auth/provider/is_login_provider.dart';
import 'package:exercies3/loader_provider.dart';
import 'package:exercies3/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthFormWidget extends ConsumerStatefulWidget {
  const AuthFormWidget({super.key});

  @override
  ConsumerState<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends ConsumerState<AuthFormWidget> {
  late UserEntity user;
  String pass = "";

  @override
  void didChangeDependencies() {
    user = ref.watch(userProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLogin = ref.watch(isLoginProvider);
    final bool isLoader = ref.watch(loaderProvider);
    final GlobalKey<FormState> keyForm = GlobalKey();
    return Form(
      key: keyForm,
      child: Column(
        children: [
          SizedBox(height: isLogin ? 20.h : 0),
          AppTextFormField(
            hintText: "Email",
            initialValue: user.email,
            validator: (value) {
              if (value == null || !value.contains("@")) return "Email is not valid";
              return null;
            },
            onChanged: (value) {
              ref.read(userProvider.notifier).onChanged(email: value);
            },
          ),
          SizedBox(height: 20.h),
          AppTextFormField(
            hintText: "Password",
            initialValue: user.password,
            isPass: true,
            validator: (value) {
              if (value == null || value.trim().length < 6) return "Username needs at least than 6 characters";
              return null;
            },
            onChanged: (value) {
              ref.read(userProvider.notifier).onChanged(password: value);
              pass = value ?? "";
            },
          ),
          if (!isLogin)
            Column(
              children: [
                SizedBox(height: 20.h),
                AppTextFormField(
                  hintText: "Confirm Password",
                  initialValue: user.password,
                  isPass: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value != pass) return "Repassword not same";
                    return null;
                  },
                  onChanged: (value) {},
                ),
              ],
            ),
          SizedBox(height: isLogin ? 50.h : 20.h),
          AppButton(
            ontap: isLoader
                ? null
                : () {
                    didChangeDependencies.call();
                    if (keyForm.currentState!.validate()) {
                      isLogin
                          ? AuthController.signIn(ref, context)
                          : AuthController.signUp(ref);
                    }
                  },
            name: isLogin ? "Login" : "SignUp",
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isLogin
                  ? "Don't have an account?"
                  : "You already have an account?"),
              SizedBox(width: 5.w),
              GestureDetector(
                onTap: isLoader
                    ? null
                    : () {
                        ref.read(isLoginProvider.notifier).switchScreen();
                        didChangeDependencies.call();
                      },
                child: Text(
                  isLogin ? "SignUp" : "SignIn",
                  style: const TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
