import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';
import 'package:mobileapp/features/deliverer/profil/presentation/widgets/driver_profile_card.dart';
import 'package:mobileapp/features/deliverer/profil/presentation/widgets/logout_Profile_2.dart';
import 'package:mobileapp/features/deliverer/profil/presentation/widgets/personal_information_card.dart';

import 'package:mobileapp/features/deliverer/profil/presentation/widgets/vehicle_card.dart';

class ProfilPage extends ConsumerStatefulWidget {
  const ProfilPage({super.key});

  @override
  ConsumerState<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends ConsumerState<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isDarkMod = ref.watch(darkModeProvider);
    var box = Hive.box<DelivererHiveObject>('delivererBox');
    DelivererHiveObject? deliverer = box.get('currentDeliverer');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryRed,
        title: Text(
          "Profil",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),

        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutProfile2(),
              );
            },
            child: _buildIcon(context),
          ),
        ],
      ),
      body: Container(
        color: isDarkMod ? kPrimaryBlack : kPrimaryWhite,

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: height * 0.01,
              children: [
                DriverProfileCard(savedDeliverer: deliverer),
                Container(
                  alignment: Alignment.centerLeft,
                  height: height * 0.05,
                  child: AutoSizeText(
                    'Informations personnelles ',
                    style: TextStyle(
                      fontSize: 22,
                      color: kPrimaryRed,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    minFontSize: 15,
                  ),
                ),
                PersonalInformationCard(deliverer: deliverer),
                Container(
                  alignment: Alignment.centerLeft,
                  height: height * 0.05,
                  child: AutoSizeText(
                    'Informations du vehicule ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                      color: kPrimaryRed,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    minFontSize: 15,
                  ),
                ),
                VehicleInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: SizedBox(
        width: width * 0.088,
        height: width * 0.088,
        child: Container(
          decoration: BoxDecoration(color: kDarkGray, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              Icons.logout_outlined,
              size: width * 0.06,
              color: kPrimaryWhite,
            ),
          ),
        ),
      ),
    );
  }
}
