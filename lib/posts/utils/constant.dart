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

const List<String> petTypes = ['All', 'Dog', 'Cat', 'Bird'];
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
        price: 'How do I use Hootapp?',
        description:
            "Download Hootapp and sign up. Next, add your pet's information and start looking for a sitter. Choose from caregivers and schedule an appointment.",
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
        price: 'Is Hootapp free to use?',
        description:
            "Yes, we do not charge any fees from Hootapp users. Your fees are only between you and the provider of your service.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price: 'Have I been scammed by someone?',
        description:
            "In such a case, go to the nearest police station or prosecutor's office without wasting any time and make your complaint. In order to prevent others from being victimized, report the relevant account to us as soon as possible. \n Our e-mail address: info.hootapp@gmail.com",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price:
            'Can I search for sitters for different animal species on Hootapp?',
        description:
            "Yes, you can search for sitters for different types of animals on Hootapp. You can specify your animal type in your profile and choose your animal type by using the filters when you start looking for a sitter.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price: 'Are babysitting services only available locally on Hootapp?',
        description:
            "On Hootapp, babysitting services are offered locally. You can view the profiles of local carers and contact them to set up appointments.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price: "How are carers' wages determined on Hootapp?",
        description:
            "On Hootapp, caregivers' fees vary according to factors such as the type and duration of care services and the type of animal. You can view caregivers' fees in their profiles and negotiate their fees privately by contacting them.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price: 'How to pay on Hootapp?',
        description:
            "In Hootapp, the payment takes place between you and the person you receive service from, our application does not have such a service yet.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price:
            'Does Hootapp offer customized services to meet the specific needs of caregivers?',
        description:
            "Yes, customized services are available on Hootapp to meet the specific needs of caregivers. To view special services, go to the profiles of caregivers and contact them about their services.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price:
            "How can I view caregivers' health and insurance information on Hootapp?",
        description:
            "On Hootapp, you can view caregivers' health and insurance information on their carers' profiles if they have provided them. Go to carers' profiles and find this information.",
      ),
    )
    ..add(
      SettingsModel(
        img: faq,
        price: 'How do I rate caregivers on Hootapp?',
        description:
            "To rate caregivers on Hootapp, go to their profile and add them to favorites once you've finished getting their services.",
      ),
    );

  return faqListData;
}
