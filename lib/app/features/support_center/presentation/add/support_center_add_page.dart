import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/extension/asuka.dart';
import '../../../../shared/design_system/button_shape.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../../filters/domain/entities/filter_tag_entity.dart';
import '../../../help_center/domain/states/guardian_alert_state.dart';
import '../../domain/states/support_center_add_state.dart';
import '../pages/support_center_dropdown_input.dart';
import '../pages/support_center_input.dart';
import '../pages/support_center_input_cep.dart';
import '../pages/support_center_input_ddd.dart';
import '../pages/support_center_input_phone.dart';
import 'support_center_add_controller.dart';

class SupportCenterAddPage extends StatefulWidget {
  const SupportCenterAddPage({Key? key}) : super(key: key);

  @override
  _SupportCenterAddPageState createState() => _SupportCenterAddPageState();
}

class _SupportCenterAddPageState
    extends ModularState<SupportCenterAddPage, SupportCenterAddController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Adicionar Ponto'),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Scrollbar(
        thickness: 8,
        isAlwaysShown: true,
        child: Observer(
          builder: (_) {
            return buildBody(context, controller.state);
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, SupportCenterAddState state) {
    return state.when(
      initial: () => buildLodingCategories(),
      loaded: () => buildLoaded(context),
      error: (msg) => buildError(),
    );
  }

  Widget buildLodingCategories() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: 'Carregando as categorias',
        child: Container(color: DesignSystemColors.systemBackgroundColor),
      ),
    );
  }

  Widget buildLoaded(BuildContext context) {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: controller.progressState,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInputPlaceInformation(context, controller.places),
              buildPlaceAction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildError() {
    return Container(
      color: Colors.redAccent,
    );
  }

  @override
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      showErrorMessage(),
      showAlert(),
    ];
  }
}

extension _BuildWidget on _SupportCenterAddPageState {
  Widget buildInputPlaceInformation(
    BuildContext context,
    List<FilterTagEntity> categories,
  ) {
    final categoriesList = buildCategoriesList(categories);
    final coverageList = buildCoverageList(['Local', 'Regional', 'Nacional']);
    final ufList = buildUfList([
      'AC',
      'AL',
      'AP',
      'AM',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MT',
      'MS',
      'MG',
      'PA',
      'PB',
      'PR',
      'PE',
      'PI',
      'RJ',
      'RN',
      'RS',
      'RO',
      'RR',
      'SC',
      'SP',
      'SE',
      'TO'
    ]);
    final yesNoList = buildUfList([
      'Sim',
      'Não',
    ]);

    final _maskCep = MaskTextInputFormatter(
      mask: '#####-###',
      filter: {'#': RegExp('[0-9]')},
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Adicione novos pontos de apoio para aumentar as opções de suporte das mulheres em situação de violência.',
            style: introdutionText,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child:
                Text('Informação sobre o ponto de apoio', style: addressTitle),
          ),
          Text(
            '* Marcam os campos com preenchimento obrigatório.',
            style: introdutionText,
          ),
          SupportCenterInput(
            hintText: 'Nome *',
            errorText: controller.placeNameError,
            onChanged: controller.setPlaceName,
          ),
          buildDropDownCategoriesList(
            context: context,
            labelText: 'Categoria *',
            errorMessage: controller.categoryError,
            currentValue: controller.categorySelected,
            dataSource: categoriesList,
          ),
          SupportCenterDropdownInput(
            labelText: 'Abrangência *',
            errorMessage: controller.coverageError,
            currentValue: controller.coverageSelected,
            dataSource: coverageList,
            onChanged: (coverage) {
              controller.setCoverage(coverage);
            },
          ),
          SupportCenterInput(
            maxLines: 2,
            hintText: 'Nome do logradouro (Rua, Avenida, etc) *',
            errorText: controller.addressError,
            onChanged: controller.setAddress,
          ),
          SupportCenterInput(
            hintText: 'Número *',
            errorText: controller.numberError,
            onChanged: controller.setNumber,
          ),
          SupportCenterInput(
            hintText: 'Complemento',
            errorText: '',
            onChanged: controller.setComplement,
          ),
          SupportCenterInput(
            hintText: 'Bairro',
            errorText: '',
            onChanged: controller.setNeighborhood,
          ),
          SupportCenterInput(
            hintText: 'Município *',
            errorText: controller.cityError,
            onChanged: controller.setCity,
          ),
          SupportCenterDropdownInput(
            labelText: 'Estado *',
            errorMessage: controller.ufError,
            currentValue: controller.ufSelected,
            dataSource: ufList,
            onChanged: (uf) {
              controller.setUf(uf);
            },
          ),
          SupportCenterInputCep(
            hintText: 'CEP',
            onChanged: controller.setCep,
            mask: [_maskCep],
          ),
          SupportCenterInputDDD(
            hintText: 'DDD primário',
            errorText: controller.ddd1Error,
            onChanged: controller.setDdd1,
          ),
          SupportCenterInputPhone(
            hintText: 'Telefone primário',
            errorText: controller.phone1Error,
            onChanged: controller.setPhone1,
          ),
          SupportCenterDropdownInput(
            labelText: 'Telefone é WhatsApp?',
            errorMessage: '',
            currentValue: controller.is24hSelected,
            dataSource: yesNoList,
            onChanged: (v) {
              controller.setHasWhasapp(v);
            },
          ),
          SupportCenterInputDDD(
            hintText: 'DDD secundário',
            errorText: controller.ddd2Error,
            onChanged: controller.setDdd2,
          ),
          SupportCenterInputPhone(
            hintText: 'Telefone secundário',
            errorText: controller.phone2Error,
            onChanged: controller.setPhone2,
          ),
          SupportCenterInput(
            hintText: 'Email',
            errorText: controller.emailError,
            onChanged: controller.setEmail,
          ),
          SupportCenterInput(
            hintText: 'Horário de Funcionamento',
            errorText: '',
            onChanged: controller.setHour,
          ),
          SupportCenterDropdownInput(
            labelText: 'Atende 24H?',
            errorMessage: '',
            currentValue: controller.is24hSelected,
            dataSource: yesNoList,
            onChanged: (v) {
              controller.setIs24h(v);
            },
          ),
          SupportCenterInput(
            maxLines: 6,
            hintText: 'Observação',
            errorText: '',
            onChanged: controller.setObservation,
          ),
        ],
      ),
    );
  }

  bool isNotValid() {
    final List<String> errorTextList = [
      controller.addressError,
      controller.cityError,
      controller.categoryError,
      controller.cepError,
      controller.cityError,
      controller.coverageError,
      controller.ddd1Error,
      controller.ddd2Error,
      controller.placeNameError,
      controller.placeDescriptionError,
      controller.ufError,
      controller.placeNameError
    ];

    return errorTextList.any((e) => e.isNotEmpty);
  }

  Widget buildPlaceAction() {
    return Container(
      height: 200,
      color: DesignSystemColors.systemBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: DesignSystemColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: const Text(
                'Essa informação ajuda usuárias do PenhaS que estão em situação de violência a entender se o ponto de apoio oferece o que ela precisa.',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 44,
              child: RaisedButton(
                onPressed: () async {
                  controller.savePlace();
                  if (isNotValid()) {
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  }
                },
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
                child: Text(
                  'Adicionar ponto de apoio',
                  style: buttonTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> buildCategoriesList(
      List<FilterTagEntity> list) {
    return list
        .map(
          (v) => DropdownMenuItem<String>(
            value: v.id,
            child: Text(
              v.label!,
            ),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<String>> buildCoverageList(List<String> list) {
    return buildDataSource(list);
  }

  List<DropdownMenuItem<String>> buildUfList(List<String> list) {
    return buildDataSource(list);
  }

  List<DropdownMenuItem<String>> buildDataSource(List<String> list) {
    return list
        .map(
          (v) => DropdownMenuItem<String>(
            value: v.toLowerCase(),
            child: Text(
              v,
            ),
          ),
        )
        .toList();
  }

  Widget buildDropDownCategoriesList({
    required BuildContext context,
    required String labelText,
    String? errorMessage,
    required String currentValue,
    required List dataSource,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: const Color.fromRGBO(240, 240, 240, 1)),
        child: DropdownButtonFormField<dynamic>(
          isExpanded: true,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            errorText: (errorMessage?.isEmpty ?? true) ? null : errorMessage,
            contentPadding:
                const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
            hintText: labelText,
            hintStyle: const TextStyle(color: Colors.black),
          ),
          items: dataSource as List<DropdownMenuItem>,
          onChanged: (category) {
            controller.setCategory(category as String);
          },
          value: currentValue.isEmpty ? null : currentValue,
        ),
      ),
    );
  }

  ReactionDisposer showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer showAlert() {
    return reaction((_) => controller.alertState, (GuardianAlertState status) {
      status.when(
        initial: () {},
        alert: (action) => showSentInvite(action),
      );
    });
  }

  void showSentInvite(GuardianAlertMessageAction action) {
    Modular.to.showDialog(
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/svg/help_center/guardians/guardians_sent_invite.svg',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(action.title, style: kTextStyleAlertDialogTitle),
              ),
            ],
          ),
          content: Text(
            action.message!,
            style: kTextStyleAlertDialogDescription,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Fechar'),
              onPressed: () async {
                Navigator.of(context).pop();
                action.onPressed();
              },
            ),
          ],
        );
      },
    );
  }
}

extension _SupportCenterAddPageStateTextStyle on _SupportCenterAddPageState {
  TextStyle get introdutionText => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      );
  TextStyle get addressTitle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      );
  TextStyle get buttonTitle => const TextStyle(
        color: DesignSystemColors.white,
        fontFamily: 'Lato',
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      );
}
