import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../shared/logger/log.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../domain/entities/support_center_place_detail_entity.dart';
import '../../domain/states/support_center_show_state.dart';
import '../pages/support_center_general_error.dart';
import '../pages/widget/support_center_detail_map_widget.dart';
import '../pages/widget/support_center_rate_widget.dart';
import 'support_center_show_controller.dart';

class SupportCenterShowPage extends StatefulWidget {
  const SupportCenterShowPage({
    super.key,
    required this.controller,
  });

  final SupportCenterShowController controller;

  @override
  SupportCenterShowPageState createState() => SupportCenterShowPageState();
}

class SupportCenterShowPageState extends State<SupportCenterShowPage> {
  SupportCenterShowController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do Ponto'),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (_) {
          return bodyBuilder(context, controller.state);
        },
      ),
    );
  }
}

extension _PageStateBuilder on SupportCenterShowPageState {
  Widget bodyBuilder(BuildContext context, SupportCenterShowState state) {
    return state.when(
      initial: () => buildInitialState(),
      loaded: (detail) => buildMainScreen(context, detail),
      error: (msg) =>
          SupportCenterGeneralError(message: msg, onPressed: controller.retry),
    );
  }

  Widget buildInitialState() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: 'Carregando...',
        child: Container(color: DesignSystemColors.white),
      ),
    );
  }

  Widget buildMainScreen(
    BuildContext context,
    SupportCenterPlaceDetailEntity detail,
  ) {
    final placeColor =
        DesignSystemColors.hexColor(detail.place!.category.color!);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: SupportCenterDetailMapWidget(detail: detail),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              color: DesignSystemColors.systemBackgroundColor,
              child: Text(
                detail.place!.name!,
                style: TextStyle(
                  color: placeColor,
                  fontFamily: 'Lato',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: DesignSystemColors.systemBackgroundColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.place,
                      size: 32,
                      color: placeColor,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          '${detail.place!.category.name!.toUpperCase()} | ${detail.place!.typeOfPlace!.toUpperCase()}',
                          style: placeTypeTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: SizedBox.shrink(),
              // TODO: HtmlWidget(
              //   detail.place!.htmlContent!,
              //   factoryBuilder: () => _DisabledWebViewJsWidgetFactory(),
              //   textStyle: htmlContentTextStyle,
              // ),
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    color: DesignSystemColors.systemBackgroundColor,
                    child: SizedBox(
                      height: 44,
                      child: PenhasButton.roundedFilled(
                        onPressed: () async => openMapsSheet(context, detail),
                        child: const Text('Traçar rota'),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            SupportCenterRateWidget(
              detail: detail,
              onRated: controller.onRate,
            ),
          ],
        ),
      ),
    );
  }
}

extension _Maps on SupportCenterShowPageState {
  double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Future<void> openMapsSheet(
    BuildContext context,
    SupportCenterPlaceDetailEntity detail,
  ) async {
    try {
      final coords = Coords(detail.place!.latitude!, detail.place!.longitude!);
      final title = detail.place!.name;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        isDismissible: true,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              constraints: const BoxConstraints(minHeight: 120),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          (fullWidth(context) - fullWidth(context) * .2) / 2,
                      vertical: 12,
                    ),
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Wrap(
                      children: <Widget>[
                        for (var map in availableMaps)
                          ListTile(
                            onTap: () => map.showMarker(
                              coords: coords,
                              title: title!,
                            ),
                            title: Text(
                              map.mapName,
                              style: mapTitleTextStyle,
                            ),
                            leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e, stack) {
      logError(e, stack);
    }
  }
}

extension _TextStyle on SupportCenterShowPageState {
  TextStyle get placeTypeTextStyle => const TextStyle(
        color: DesignSystemColors.brownishGrey,
        fontFamily: 'Lato',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      );

  TextStyle get mapTitleTextStyle => const TextStyle(
        color: Colors.black,
        fontFamily: 'Lato',
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      );
  TextStyle get htmlContentTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}

// TODO: class _DisabledWebViewJsWidgetFactory extends WidgetFactory {
//   @override
//   bool get webViewJs => false;
// }
