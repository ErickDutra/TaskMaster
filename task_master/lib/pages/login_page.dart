import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginPage({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  'TASK MASTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: emailController,

                  style: const TextStyle(color: Colors.white, height: 1),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    label: Center(
                      child: Text(
                        'E-mail',
                        style: TextStyle(
                          color: Color.fromARGB(125, 255, 255, 255),
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 48, 48, 48),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: const TextStyle(color: Colors.white, height: 1),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 48, 48, 48),

                    labelStyle: const TextStyle(color: Colors.white),
                    border: const OutlineInputBorder(),

                    label: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        'Senha',
                        style: TextStyle(
                          color: Color.fromARGB(125, 255, 255, 255),
                        ),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos.',
                            ),
                          ),
                        );
                        return;
                      }
                      if (emailController.text == 'email' ||
                          passwordController.text == 'senha') {
                        Navigator.pushReplacementNamed(context, '/home');
                        widget.onLogin();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login realizado!')),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.email),
                        SizedBox(width: 8),
                        Text(
                          'Continuar com o e-mail',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos.',
                            ),
                          ),
                        );
                        return;
                      }
                      if (emailController.text == 'email' ||
                          passwordController.text == 'senha') {
                        Navigator.pushReplacementNamed(context, '/home');
                        widget.onLogin();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login realizado!')),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.email),
                        SizedBox(width: 8),
                        Text(
                          'Continuar com o Google',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos.',
                            ),
                          ),
                        );
                        return;
                      }
                      if (emailController.text == 'email' ||
                          passwordController.text == 'senha') {
                        Navigator.pushReplacementNamed(context, '/home');
                        widget.onLogin();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login realizado!')),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.email),
                        SizedBox(width: 8),
                        Text(
                          'Continuar com o Apple',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem uma conta? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Assinar',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
