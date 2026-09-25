import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/design_system/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/app_selectors.dart';
import 'package:tsi_ind_pr_2/doctor_list.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _birth = TextEditingController();
  final _notes = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _dark = false;
  bool _gradient = true;
  bool _selected = false;
  bool _radio = false;
  bool _switch = false;
  bool _bigSwitch = false;
  bool _obscure = true;
  bool _notification = true;
  bool _dateSelected = true;
  String _lastAction = 'Tap any component';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _birth.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _pressed(String name) {
    setState(() => _lastAction = 'Pressed: $name');
  }

  Widget _sample(String name, Widget child) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _dark ? const Color(0xFF263D48) : const Color(0xFFC9DBDF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      ],
    ),
  );

  Widget _page(List<Widget> children) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );

  Widget _buttons() => _page([
    SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Text button gradient'),
      value: _gradient,
      onChanged: (value) => setState(() => _gradient = value),
    ),
    _sample(
      'circleInkButton',
      AppButtons.circleInkButton(
        onPressed: () => _pressed('circleInkButton'),
        icon: AppIcons.userOutlinedIcon(
          color: Colors.white,
          width: 18.1,
          height: 21.9,
        ),
      ),
    ),
    _sample(
      'circleIconBTN',
      AppButtons.circleIconBTN(
        onPressed: () => _pressed('circleIconBTN'),
        icon: AppIcons.walletIcon(),
      ),
    ),
    _sample(
      'smallSquareBTN',
      AppButtons.smallSquareBTN(
        onPressed: () => _pressed('smallSquareBTN'),
        contWidth: 56,
        contHeight: 56,
        radius: 12,
        icon: AppIcons.globalIcon(),
      ),
    ),
    _sample(
      'squareImageAndTextBTN',
      AppButtons.squareImageAndTextBTN(
        onPressed: () => _pressed('squareImageAndTextBTN'),
        contWidth: 96,
        contHeight: 94,
        radius: 18,
        spacing: 10,
        icon: AppIcons.gynecology(color: Colors.white),
        text: 'Gynecology',
        textSize: 13,
      ),
    ),
    _sample(
      'bookingGradientBTN',
      AppButtons.bookingGradientBTN(
        onPressed: () => _pressed('bookingGradientBTN'),
      ),
    ),
    _sample(
      'homeGradientBTN',
      AppButtons.homeGradientBTN(onPressed: () => _pressed('homeGradientBTN')),
    ),
    _sample(
      'chatGradientBTN',
      AppButtons.chatGradientBTN(onPressed: () => _pressed('chatGradientBTN')),
    ),
    _sample(
      'userGradientBTN',
      AppButtons.userGradientBTN(onPressed: () => _pressed('userGradientBTN')),
    ),
    _sample(
      'starIconBTN',
      AppButtons.starIconBTN(onPressed: () => _pressed('starIconBTN')),
    ),
    _sample(
      'starOutlindedIconBTN',
      AppButtons.starOutlindedIconBTN(
        onPressed: () => _pressed('starOutlindedIconBTN'),
      ),
    ),
    _sample(
      'maleIconBTN',
      AppButtons.maleIconBTN(onPressed: () => _pressed('maleIconBTN')),
    ),
    _sample(
      'famaleIconBTN',
      AppButtons.famaleIconBTN(onPressed: () => _pressed('famaleIconBTN')),
    ),
    _sample(
      'heartIconBTN',
      AppButtons.heartIconBTN(onPressed: () => _pressed('heartIconBTN')),
    ),
    _sample(
      'heartOutlinedIconBTN',
      AppButtons.heartOutlinedIconBTN(
        onPressed: () => _pressed('heartOutlinedIconBTN'),
      ),
    ),
    _sample(
      'authButton',
      AppButtons.authButton(
        onPressed: () => _pressed('authButton'),
        text: 'Log In',
        isGradient: _gradient,
      ),
    ),
    _sample(
      'singleTextButton',
      AppButtons.singleTextButton(
        onPressed: () => _pressed('singleTextButton'),
        text: 'Continue',
        width: 220,
        height: 45,
        isGradient: _gradient,
      ),
    ),
    _sample(
      'textWithImageBTN',
      AppButtons.textWithImageBTN(
        onPressed: () => _pressed('textWithImageBTN'),
        text: 'Book now',
        isGradient: _gradient,
      ),
    ),
    _sample(
      'contactUs',
      AppButtons.contactUs(onPressed: () => _pressed('contactUs')),
    ),
  ]);

  Widget _selectors() => _page([
    const Text('Tap again to compare states.'),
    const SizedBox(height: 16),
    _sample(
      'specialitySelector',
      AppSelectors.specialitySelector(
        text: 'Cardiology',
        icon: AppIcons.cardiology(
          color: _selected ? Colors.white : AppColors.primary,
        ),
        isClicked: _selected,
        onPressed: () => setState(() {
          _selected = !_selected;
          _lastAction = 'Specialty: $_selected';
        }),
      ),
    ),
    _sample(
      'customRadioBTN',
      AppButtons.customRadioBTN(
        selected: _radio,
        onTap: () => setState(() {
          _radio = !_radio;
          _lastAction = 'Radio: $_radio';
        }),
      ),
    ),
    _sample(
      'switchBTN',
      AppButtons.switchBTN(
        value: _switch,
        onTap: () => setState(() {
          _switch = !_switch;
          _lastAction = 'Switch: $_switch';
        }),
      ),
    ),
    _sample(
      'switchBTN · isBig',
      AppButtons.switchBTN(
        value: _bigSwitch,
        isBig: true,
        onTap: () => setState(() {
          _bigSwitch = !_bigSwitch;
          _lastAction = 'Big switch: $_bigSwitch';
        }),
      ),
    ),
  ]);

  Widget _inputs() => Form(
    key: _form,
    child: _page([
      _sample('inputEmail', AppInputs.inputEmail(controller: _email)),
      _sample(
        'inputPassword',
        AppInputs.inputPassword(
          controller: _password,
          obscureText: _obscure,
          onEyePressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
      _sample(
        'inputBirth',
        AppInputs.inputBirth(
          controller: _birth,
          context: context,
          onDateSelected: (date) =>
              _pressed('Date: ${date.day}.${date.month}.${date.year}'),
        ),
      ),
      _sample(
        'inputText',
        AppInputs.inputText(
          controller: _notes,
          width: 298,
          height: 120,
          hint: 'Enter a note...',
        ),
      ),
      FilledButton(
        onPressed: () {
          final valid = _form.currentState!.validate();
          setState(
            () => _lastAction = valid
                ? 'Form is valid'
                : 'Please check the form fields',
          );
        },
        child: const Text('Validate form'),
      ),
    ]),
  );

  Widget _containers() => _page([
    _sample(
      'smallSquareContainer',
      AppContainers.smallSquareContainer(
        icon: Center(child: AppIcons.odontology(color: Colors.white)),
      ),
    ),
    SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Show notification'),
      value: _notification,
      onChanged: (value) => setState(() => _notification = value),
    ),
    _sample(
      'whiteCircleContainer',
      AppContainers.whiteCircleContainer(hasNotification: _notification),
    ),
    _sample(
      'navigations',
      AppContainers.navigations(
        icon: AppIcons.homeIcon(width: 24, height: 24),
        text: 'Home',
      ),
    ),
    SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Date selected'),
      value: _dateSelected,
      onChanged: (value) => setState(() => _dateSelected = value),
    ),
    _sample(
      'dateContainer',
      AppContainers.dateContainer(
        date: '25',
        day: 'Fri',
        isSelected: _dateSelected,
      ),
    ),
    _sample(
      'profileAvatar',
      AppContainers.profileAvatar(image: AssetImage(doctorAvatars.first)),
    ),
  ]);

  Widget _icons() {
    final icons = <String, Widget>{
      'userOutlinedIcon': AppIcons.userOutlinedIcon(
        color: AppColors.primary,
        width: 24,
        height: 24,
      ),
      'userIcon': AppIcons.userIcon(),
      'checkIcon': AppIcons.checkIcon(),
      'closeIcon': AppIcons.closeIcon(),
      'heartIcon': AppIcons.heartIcon(),
      'heartOutlinedIcon': AppIcons.heartOutlinedIcon(
        color: AppColors.primary,
        width: 24,
        height: 24,
      ),
      'topIcon': AppIcons.topIcon(),
      'walletIcon': AppIcons.walletIcon(),
      'soundIcon': AppIcons.soundIcon(),
      'fingerprintIcon': AppIcons.fingerprintIcon(),
      'privacyIcon': AppIcons.privacyIcon(),
      'globalIcon': AppIcons.globalIcon(),
      'facebookIcon': AppIcons.facebookIcon(),
      'sattingIcon': AppIcons.sattingIcon(
        color: AppColors.primary,
        width: 24,
        height: 24,
      ),
      'whatsappIcon': AppIcons.whatsappIcon(),
      'googleIcon': AppIcons.googleIcon(),
      'questionsIcon': AppIcons.questionsIcon(
        color: AppColors.primary,
        width: 24,
        height: 24,
      ),
      'logOutIcon': AppIcons.logOutIcon(),
      'picgramIcon': AppIcons.picgramIcon(),
      'documentIcon': AppIcons.documentIcon(),
      'bookingOutlinedIcon': AppIcons.bookingOutlinedIcon(
        color: AppColors.primary,
        width: 24,
        height: 24,
      ),
      'infoIcon': AppIcons.infoIcon(),
      'returnIcon': AppIcons.returnIcon(
        color: AppColors.primary,
        width: 24,
        height: 24,
      ),
      'homeIcon': AppIcons.homeIcon(width: 24, height: 24),
      'homeOutlinedIcon': AppIcons.homeOutlinedIcon(
        color: AppColors.primary,
        width: 24,
        height: 24,
      ),
      'stethoscopeIcon': AppIcons.stethoscopeIcon(),
      'chatOutlinedIcon': AppIcons.chatOutlinedIcon(),
      'pharmacyIcon': AppIcons.pharmacyIcon(),
      'speciality': AppIcons.speciality(),
      'record': AppIcons.record(),
      'bell': AppIcons.bell,
      'search': AppIcons.search(),
      'filters': AppIcons.filters(),
      'edit': AppIcons.edit(),
      'generalMedicine': AppIcons.generalMedicine(color: AppColors.primary),
      'ophtamology': AppIcons.ophtamology(color: AppColors.primary),
      'dermatology': AppIcons.dermatology(color: AppColors.primary),
      'cardiology': AppIcons.cardiology(color: AppColors.primary),
      'gynecology': AppIcons.gynecology(color: AppColors.primary),
      'oncology': AppIcons.oncology(color: AppColors.primary),
      'odontology': AppIcons.odontology(color: AppColors.primary),
      'orthopedics': AppIcons.orthopedics(color: AppColors.primary),
      'otolaryngology': AppIcons.otolaryngology(color: AppColors.primary),
      'bookingIcon': AppIcons.bookingIcon,
      'chatGradienFullIcon': AppIcons.chatGradienFullIcon,
      'pinHomeLocationIcon': AppIcons.pinHomeLocationIcon,
      'messaheIcon': AppIcons.messaheIcon,
      'analysis': AppIcons.analysis(),
      'vaccinations': AppIcons.vaccinations(),
      'allergies': AppIcons.allergies(),
      'medicalHistory': AppIcons.medicalHistory(),
    };
    return _page([
      const Text(
        'One example of each icon. Use the button above to change the background.',
      ),
      const SizedBox(height: 16),
      for (final entry in icons.entries) _sample(entry.key, entry.value),
    ]);
  }

  Widget _avatars() => _page([
    for (final path in doctorAvatars)
      _sample(
        path.split('/').last,
        AppContainers.profileAvatar(image: AssetImage(path)),
      ),
  ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F6F7),
        appBar: AppBar(
          title: const Text('Component Catalog'),
          actions: [
            TextButton(
              onPressed: () => setState(() => _dark = !_dark),
              child: Text(_dark ? 'Light background' : 'Dark background'),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Buttons'),
              Tab(text: 'Selection'),
              Tab(text: 'Inputs'),
              Tab(text: 'Containers'),
              Tab(text: 'Icons'),
              Tab(text: 'Avatars'),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(_lastAction, key: const ValueKey('last-action')),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buttons(),
                    _selectors(),
                    _inputs(),
                    _containers(),
                    _icons(),
                    _avatars(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
