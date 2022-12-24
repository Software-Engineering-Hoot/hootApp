import 'package:flutter/material.dart';
import 'package:hoot/posts/models/settings_model.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/view/RFAboutUsScreen.dart';
import 'package:hoot/posts/view/RFHelpScreen.dart';
import 'package:hoot/posts/view/notifications.dart';
import 'package:hoot/posts/view/settings.dart';

const widgetHeight = 300;
const bottomNavigationIconSize = 16.0;
/*fonts*/
const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 30.0;

const profileImage = 'assets/images/profile.png';

const List<String> petTypes = ['Dog', 'Cat', 'Bird'];
List<String> cities = [
  'Erzincan',
  'Ordu',
  'Giresun',
  'Rize',
  'Amasya',
  'Corum',
  'Edirne',
  'Karabük',
  'Kütahya',
  'Sinop',
  'Usak',
  'Istanbul',
  'Ankara',
  'Izmir',
  'Bursa',
  'Adana',
  'Gaziantep',
  'Konya',
  'Antalya',
  'Kayseri',
  'Mersin',
  'Eskisehir',
  'Sanliurfa',
  'Diyarbakir',
  'Samsun',
  'Denizli',
  'Malatya',
  'Kahramanmaras',
  'Erzurum',
  'Van',
  'Sivas',
  'Tokat',
  'Elazig',
  'Trabzon',
  'Manisa',
  'Aydin',
  'Balikesir'
];

List<SettingsModel> settingList() {
  final settingListData = <SettingsModel>[];
  // ignore: cascade_invocations
  settingListData
    ..add(
      SettingsModel(
        img: notification,
        roomCategoryName: 'Notifications',
        newScreenWidget: const Notifications(),
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        roomCategoryName: 'Get Help',
        newScreenWidget: RFHelpScreen(),
      ),
    )
    ..add(
      SettingsModel(
        img: about_us,
        roomCategoryName: 'About us',
        newScreenWidget: RFAboutUsScreen(),
      ),
    )
    ..add(
      SettingsModel(
        img: sign_out,
        roomCategoryName: 'Sign Out',
        newScreenWidget: const SizedBox(),
      ),
    );
  return settingListData;
}

List<SettingsModel> faqList() {
  final faqListData = <SettingsModel>[];
  // ignore: cascade_invocations
  faqListData
    ..add(
      SettingsModel(
        img: faq,
        price: 'What do we get here in this app?',
        description:
            "That which doesn't kill you makes you stronger, right? Unless it almost kills you, and renders you weaker. Being strong is pretty rad though, so go ahead.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price: 'What is the use of this App?',
        description:
            "Sometimes, you've just got to say 'the party starts here'. Unless you're not in the place where the aforementioned party is starting. Then, just shut up.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price: 'How to get from location A to B?',
        description:
            "If you believe in yourself, go double or nothing. Well, depending on how long it takes you to calculate what double is. If you're terrible at maths, don't.",
      ),
    );

  return faqListData;
}
