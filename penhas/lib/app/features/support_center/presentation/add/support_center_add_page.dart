import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_add_state.dart';
import 'package:penhas/app/features/support_center/presentation/add/support_center_add_controller.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_dropdown_input.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_input.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_input_cep.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_input_number.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_input_phone.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Adicionar Ponto'),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (_) {
          return buildBody(context, controller.state);
        },
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
    final ufList = buildUfList(['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO']);
    
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
          SupportCenterInputCep(
            hintText: 'Insira um CEP',
            onChanged: controller.setCep,
            mask: [_maskCep],
          ),
          SupportCenterInput(
            maxLines: 2,
            hintText: 'Insira o Logradouro',
            errorText: controller.addressError,
            onChanged: controller.setAddress,
          ),
          SupportCenterInput(
            hintText: 'Insira um Complemento',
            errorText: '',
            onChanged: controller.setComplement,
          ),
          SupportCenterInputNumber(
            hintText: 'Número',
            errorText: controller.numberError,
            onChanged: controller.setNumber,
          ),
          SupportCenterInput(
            hintText: 'Insira um Bairro',
            errorText: '',
            onChanged: controller.setNeighborhood,
          ),
          SupportCenterInput(
            hintText: 'Insira um Município',
            errorText: controller.cityError,
            onChanged: controller.setCity,
          ),
          SupportCenterDropdownInput(
            labelText: 'Selecione o Estado',
            errorMessage: controller.ufError,
            currentValue: controller.ufSelected,
            dataSource: ufList,
            onChanged: (uf) {
              controller.setUf(uf);
            },
          ),
          SupportCenterInputPhone(
            hintText: 'Insira o telefone com o DDD',
            errorText: controller.phoneError,
            onChanged: controller.setPhone,
          ),
          buildDropDownCategoriesList(
            context: context,
            labelText: 'Selecione o tipo de ponto de apoio',
            errorMessage: controller.categoryError,
            currentValue: controller.categorySelected,
            dataSource: categoriesList,
          ),
          SupportCenterInput(
            hintText: 'Nome do ponto de apoio',
            errorText: controller.placeNameError,
            onChanged: controller.setPlaceName,
          ),
          SupportCenterInput(
            hintText: 'Email do ponto de apoio',
            errorText: '',
            onChanged: controller.setEmail,
          ),
          SupportCenterDropdownInput(
            labelText: 'Selecione a abrangência do ponto de apoio',
            errorMessage: controller.coverageError,
            currentValue: controller.coverageSelected,
            dataSource: coverageList,
            onChanged: (coverage) {
              controller.setCoverage(coverage);
            },
          ),
          SupportCenterInput(
            maxLines: 6,
            hintText:
                'Observação',
            errorText: '',
            onChanged: controller.setObservation,
          ),
        ],
      ),
    );
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
                onPressed: controller.savePlace,
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

   List<DropdownMenuItem<String>> buildCategoriesList(List<FilterTagEntity> list) {
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
            .copyWith(canvasColor: const Color.fromRGBO(141, 146, 157, 1)),
        child: DropdownButtonFormField<dynamic>(
          isExpanded: true,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            errorText: (errorMessage?.isEmpty ?? true) ? null : errorMessage,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            contentPadding:
                const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
            hintText: labelText,
            hintStyle: const TextStyle(color: Colors.black),
          ),
          items: dataSource as List<DropdownMenuItem>,
          onChanged: (category) {
            controller.setCategorie(category as String);
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
