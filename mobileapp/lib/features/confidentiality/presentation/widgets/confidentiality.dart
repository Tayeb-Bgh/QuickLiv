import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';

class Confidentiality extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final Color backColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final Color textColor = isDarkMode ? kSecondaryWhite : kSecondaryDark;
    final Color sectionBackgroundColor =
        isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;

    return Scaffold(
      backgroundColor: backColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            'Chez QuickLiv, nous nous engageons à protéger votre vie privée. Cette politique de confidentialité vous explique comment nous collectons, utilisons, stockons et protégeons vos informations personnelles lorsque vous utilisez notre application.',
            Icons.security,
            textColor,
            sectionBackgroundColor,
          ),
          _buildSectionHeader(
            '1. Collecte des informations personnelles',
            Icons.person_add,
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionContent(
            'Lorsque vous utilisez notre application, nous pouvons collecter des informations personnelles telles que :\n'
            '- Votre nom\n'
            '- Votre adresse e-mail\n'
            '- Votre numéro de téléphone\n'
            '- Votre adresse de livraison\n'
            '- Historique de vos commandes\n\n'
            'Ces informations sont collectées uniquement lorsque vous les fournissez volontairement lors de votre inscription ou de l\'utilisation de l\'application.',
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionHeader(
            '2. Utilisation des informations',
            Icons.info,
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionContent(
            'Les informations que nous collectons sont utilisées pour :\n'
            '- Traiter vos commandes\n'
            '- Vous offrir un service client personnalisé\n'
            '- Améliorer notre application et nos services\n'
            '- Vous informer des offres spéciales et promotions, si vous y avez consenti.\n\n'
            'Nous ne partagerons jamais vos informations personnelles avec des tiers sans votre consentement, sauf si cela est requis par la loi.',
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionHeader(
            '3. Sécurité des informations',
            Icons.security,
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionContent(
            'Nous mettons en place des mesures de sécurité appropriées pour protéger vos informations personnelles contre l\'accès, la divulgation, la modification ou la destruction non autorisée. Cela inclut des protocoles de cryptage lors de la transmission des données sensibles.',
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionHeader('4. Vos droits', Icons.gavel, textColor),
          SizedBox(height: 20),
          _buildSectionContent(
            'Vous avez le droit d\'accéder à vos informations personnelles, de les corriger, de les mettre à jour ou de les supprimer. Vous pouvez également retirer votre consentement pour l\'utilisation de vos données personnelles à tout moment. Si vous souhaitez exercer ces droits, veuillez nous contacter à l\'adresse suivante :\n example@quickLiv.com',
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionHeader(
            '5. Partage des informations',
            Icons.share,
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionContent(
            'Nous ne vendons ni ne louons vos informations personnelles à des tiers. Cependant, nous pouvons partager vos informations avec des prestataires de services tiers qui nous aident à fonctionner (par exemple, les services de livraison, de paiement, etc.). Ces prestataires sont tenus de protéger vos données conformément à cette politique de confidentialité.',
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionHeader(
            '6. Modifications de la politique de confidentialité',
            Icons.update,
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionContent(
            'Nous nous réservons le droit de modifier cette politique de confidentialité à tout moment. Toute modification sera publiée sur cette page avec la date de mise à jour.',
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionHeader(
            '7. Contactez-nous',
            Icons.contact_mail,
            textColor,
          ),
          SizedBox(height: 20),
          _buildSectionContent(
            'Si vous avez des questions concernant cette politique de confidentialité ou si vous souhaitez exercer vos droits, veuillez nous contacter à : example@quickLiv.com',
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String content,
    IconData icon,
    Color textColor,
    Color backgroundColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              content,
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: textColor, size: 30),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContent(String content, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Text(content, style: TextStyle(fontSize: 16, color: textColor)),
    );
  }
}
