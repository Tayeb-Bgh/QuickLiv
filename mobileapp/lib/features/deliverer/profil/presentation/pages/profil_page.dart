import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';
import 'package:mobileapp/features/deliverer/profil/presentation/widgets/deliverer_profil_top_bar.dart';
import 'package:mobileapp/features/deliverer/profil/presentation/widgets/driver_profile_card.dart';
import 'package:mobileapp/features/deliverer/profil/presentation/widgets/personal_information_card.dart';

import 'package:mobileapp/features/deliverer/profil/presentation/widgets/vehicle_card.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    var box = Hive.box<DelivererHiveObject>('delivererBox');
    DelivererHiveObject? deliverer = box.get('currentDeliverer');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(statusBarHeight + height * 0.033),
        child: Container(
          color: kPrimaryWhite,
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: MyPainter2(),
            child: DelivererProfilTopBar(title: 'Profil'),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
    );
  }
}
