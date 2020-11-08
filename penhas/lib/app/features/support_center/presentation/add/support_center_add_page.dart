import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_add_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_input.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'support_center_add_controller.dart';

class SupportCenterAddPage extends StatefulWidget {
  SupportCenterAddPage({Key key}) : super(key: key);

  @override
  _SupportCenterAddPageState createState() => _SupportCenterAddPageState();
}

class _SupportCenterAddPageState
    extends ModularState<SupportCenterAddPage, SupportCenterAddController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Ponto"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(builder: (_) {
        return buildBody(controller.state);
      }),
    );
  }

  Widget buildBody(SupportCenterAddState state) {
    return state.when(
      initial: () => buildLodingCategories(),
      loaded: () => buildLoaded(),
      error: (msg) => buildError(),
    );
  }

  Widget buildLodingCategories() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: "Carregando as categorias",
        child: Container(color: DesignSystemColors.systemBackgroundColor),
      ),
    );
  }

  Widget buildLoaded() {
    return Container(
      color: Colors.blueAccent,
    );
  }

  Widget buildError() {
    return Container(
      color: Colors.redAccent,
    );
  }

  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }
}

extension _BuildWidget on _SupportCenterAddPageState {
  Widget buildInputPlaceInformation(
      BuildContext context, List<FilterTagEntity> categories) {
    final dataSource = buildDataSource(categories);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Adicione novos pontos de apoio para aumentar as opções de suporte das mulheres em situação de violência.",
            style: introdutionText,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child:
                Text("Informação sobre o ponto de apoio", style: addressTitle),
          ),
          SupportCenterInput(
            maxLines: 2,
            hintText: "Insira um endereço ou CEP",
            errorText: controller.addressError,
            onChanged: controller.setAddress,
          ),
          buildDropdownList(
            context: context,
            labelText: "Selecione o tipo de ponto de apoio",
            errorMessage: "",
            dataSource: dataSource,
            currentValue: "",
          ),
          SupportCenterInput(
            hintText: "Nome do ponto de apoio",
            errorText: controller.placeNameError,
            onChanged: controller.setPlaceName,
          ),
          SupportCenterInput(
            maxLines: 6,
            hintText:
                "Explique brevemente os serviços oferecidos por este ponto de apoio",
            errorText: controller.placeDescriptionError,
            onChanged: controller.setPlaceName,
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
              decoration: BoxDecoration(
                color: DesignSystemColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Text(
                  "Essa informação ajuda usuárias do PenhaS que estão em situação de violência a entender se o ponto de apoio oferece o que ela precisa."),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 44,
              child: RaisedButton(
                onPressed: controller.salvePlace,
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
                child: Text(
                  "Adicionar ponto de apoio",
                  style: buttonTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> buildDataSource(List<FilterTagEntity> list) {
    return list
        .map(
          (v) => DropdownMenuItem<String>(
            child: Text(v.label),
            value: v.id,
          ),
        )
        .toList();
  }

  Widget buildDropdownList({
    @required BuildContext context,
    @required String labelText,
    @required String errorMessage,
    @required String currentValue,
    @required List dataSource,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Color.fromRGBO(141, 146, 157, 1)),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            errorText: (errorMessage?.isEmpty ?? true) ? "" : errorMessage,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: DesignSystemColors.easterPurple)),
            labelText: controller.categorieName,
            // labelStyle: TextStyle(color: Colors.white),
            contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
            hintText: labelText,
          ),
          items: dataSource,
          onChanged: controller.setCategorie,
          // style: TextStyle(color: Colors.white),
          value: controller.categorieName,
        ),
      ),
    );
  }
}

extension _SupportCenterAddPageStateTextStyle on _SupportCenterAddPageState {
  TextStyle get introdutionText => TextStyle(
      color: DesignSystemColors.darkIndigoThree,
      fontFamily: 'Lato',
      fontSize: 14.0,
      fontWeight: FontWeight.normal);

  TextStyle get addressTitle => TextStyle(
      color: DesignSystemColors.darkIndigoThree,
      fontFamily: 'Lato',
      fontSize: 20.0,
      fontWeight: FontWeight.bold);

  TextStyle get buttonTitle => TextStyle(
      color: DesignSystemColors.white,
      fontFamily: 'Lato',
      fontSize: 12.0,
      fontWeight: FontWeight.bold);
}
