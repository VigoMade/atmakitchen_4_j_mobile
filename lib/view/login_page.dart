import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atmakitchen_4_j_mobile/bloc/form_submission_state.dart';
import 'package:atmakitchen_4_j_mobile/bloc/login_bloc.dart';
import 'package:atmakitchen_4_j_mobile/bloc/login_event.dart';
import 'package:atmakitchen_4_j_mobile/bloc/login_state.dart';
import 'package:atmakitchen_4_j_mobile/model/user.dart';
import 'package:atmakitchen_4_j_mobile/view/index.dart';
import 'package:atmakitchen_4_j_mobile/view/forget_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginviewState();
}

class _LoginviewState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state.formSubmissionState is SubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                key: Key("sakis-login"),
                content: Text('Login Success'),
                backgroundColor: Colors.lightBlue,
              ),
            );
            User userData =
                (state.formSubmissionState as SubmissionSuccess).user;
            await saveLoginData(userData);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const IndexPage()));
          }
          if (state.formSubmissionState is SubmissionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: const Key("error-login"),
                content: Text((state.formSubmissionState as SubmissionFailed)
                    .exception
                    .toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFFAD343E),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      color: Colors.white,
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Atma Kitchen",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 50.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back,',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'Login!',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        TextFormField(
                          key: const Key("input-username"),
                          controller: usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'username',
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter your username';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        TextFormField(
                          key: const Key("input-password"),
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                      IsPasswordVisibleChanged(),
                                    );
                              },
                              icon: Icon(
                                state.isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: state.isPasswordVisible
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                            ),
                          ),
                          obscureText: state.isPasswordVisible,
                          validator: (value) =>
                              value == '' ? 'Please enter your Password' : null,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      FormSubmitted(
                                          username: usernameController.text,
                                          password: passwordController.text),
                                    );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFAD343E)),
                            ),
                            child: Padding(
                              key: const ValueKey('login'),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: state.formSubmissionState is FormSubmitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Forget ur Password?"),
                            TextButton(
                              onPressed: () {
                                pushForget(context);
                              },
                              child: const Text("Forget"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void pushForget(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
    );
  }

  Future<void> saveLoginData(User userData) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setInt('id_customer', userData.idCustomer!);
    await sharedPrefs.setString('username', userData.username!);
    await sharedPrefs.setString('email', userData.email!);
    await sharedPrefs.setString('noTelp', userData.noTelpon!);
    await sharedPrefs.setString('name', userData.nama!);
    await sharedPrefs.setString('token', userData.token!);
  }
}
