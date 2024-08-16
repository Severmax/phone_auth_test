part of 'login_screen.dart';

Widget _buildFooter(BuildContext context, String countryCodePhone,
    TextEditingController passwordController, TextEditingController phoneConroller, final GlobalKey<FormState> formKey) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async{
            if (formKey.currentState!.validate()) {
              String phone = countryCodePhone + phoneConroller.text;
              await context.read<AuthCubit>().login(phone, passwordController.text);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Log in',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?"),
          SizedBox(width: 4),
          InkWell(
            child: const Text(
              "Create Account",
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
          ),
        ],
      ),
    ],
  );
}
