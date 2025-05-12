import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/about/presentation/widgets/bubble_item.dart';
import 'package:mobileapp/features/customer/about/presentation/widgets/member_card.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamMembers = [
      {
        'name': 'Kenza BELALOUI',
        'specialty': 'Développement mobile',
        'description':
            'Collaboration sur le développement mobile et l\'intégration des fonctionnalités principales.',
        'icon': Icons.person,
        'githubUrl': 'https://github.com/KenBel',
      },
      {
        'name': 'Tayeb BOUGUERMOUH',
        'specialty': 'Développement et intégration',
        'description':
            'Travail collaboratif sur l\'architecture du projet et l\'intégration des services.',
        'icon': Icons.person,
        'githubUrl': 'https://github.com/Tayeb-Bgh',
      },
      {
        'name': 'Amel BENAISSA',
        'specialty': 'Conception UI/UX',
        'description':
            'Conception et prototypage d\'interfaces intuitives et collaboratives.',
        'icon': Icons.person,
        'githubUrl': 'https://github.com/amel0902',
      },
      {
        'name': 'Badis AOURTILANE',
        'specialty': 'Développement full stack',
        'description':
            'Implémentation de la logique côté client et serveur, tout en travaillant en collaboration avec l\'équipe.',
        'icon': Icons.person,
        'githubUrl': 'https://github.com/Usokka',
      },
      {
        'name': 'Doussan BENKERROU',
        'specialty': 'Qualité et tests',
        'description':
            'Mise en place des tests et validation de la qualité pour garantir la stabilité du projet.',
        'icon': Icons.person,
        'githubUrl': 'https://github.com/Doussan-Benkerrou',
      },
      {
        'name': 'Anis AYOUZ',
        'specialty': 'Déploiement et intégration continue',
        'description':
            'Automatisation des processus de déploiement et gestion de l\'infrastructure cloud.',
        'icon': Icons.person,
        'githubUrl': 'https://github.com/Anisayz',
      },
    ];

    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color backColor = isDarkMode ? Color(0xFF282525) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        centerTitle: true,
        backgroundColor: kPrimaryRed,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: SvgPicture.asset(
                'assets/images/Vector.svg',
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notre Équipe',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: kPrimaryWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(offset: Offset(0, 3), blurRadius: 5, color: kPrimaryBlack),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 12),
                Container(
                  width: 302,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: KSecondaryRed,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kPrimaryRed),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'À Propos de Nous',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryRed,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nous sommes une équipe passionnée de 6 développeurs dédiés à révolutionner votre expérience d\'achat et de livraison alimentaire.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: BubbleItem(
                              icon: Icons.restaurant,
                              label: 'Qualité',
                            ),
                          ),
                          Flexible(
                            child: BubbleItem(
                              icon: Icons.local_shipping,
                              label: 'Rapidité',
                            ),
                          ),
                          Flexible(
                            child: BubbleItem(
                              icon: Icons.code,
                              label: 'Innovation',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  itemCount: teamMembers.length,
                  itemBuilder: (context, index) {
                    final member = teamMembers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MemberCard(
                        name: member['name'] as String,
                        specialty: member['specialty'] as String,
                        description: member['description'] as String,
                        icon: member['icon'] as IconData,
                        githubUrl: member['githubUrl'] as String,
                        ref: ref,
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Notre Équipe au Complet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryRed,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 280,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: KSecondaryRed, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/photo_grp.jpg',
                            width: 260,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'L\'équipe QuickLiv réunie pour révolutionner la livraison alimentaire',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kPrimaryRed,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: kPrimaryRed,
                  child: Text(
                    '© ${DateTime.now().year} QuickLiv',
                    style: const TextStyle(
                      fontSize: 12,
                      color: kPrimaryWhite,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          color: kPrimaryBlack,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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
