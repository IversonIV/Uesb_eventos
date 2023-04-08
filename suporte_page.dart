import 'package:flutter/material.dart';
import 'package:uesb_eventos/ui/pages/suporte/widgets/body_component.dart';
import 'package:uesb_eventos/ui/pages/suporte/widgets/bottom_button.dart';
import 'package:uesb_eventos/ui/shared/widgets/custom_app_bar.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SuportePage extends StatelessWidget {
  const SuportePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();

    Future<void> _sendFeedback() async {
      final String username = 'seu_email_address@gmail.com';
      final String senha = 'sua_senha_email';

      final smtpServer = gmail(username, senha);

      final message = Message()
        ..from = Address(username, 'Seu Nome')
        ..recipients.add('admin_email_address@example.com')
        ..subject = 'Feedback do seu aplicativo'
        ..text =
            'Email: ${_emailController.text}\nMessage: ${_messageController.text}';

      try {
        await send(message, smtpServer);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Obrigado!'),
            content: Text('Seu feedback foi enviado.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro ao enviar seu feedback.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: buildAppBar("Fale Conosco"),
      body: const BodyComponent(),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.09,
        color: const Color.fromARGB(255, 253, 251, 251),
        child: ElevatedButton(
          onPressed: _sendFeedback,
          child: Text('enviar'),
        ),
      ),
    );
  }
}
