import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../domain/entities/support_center_place_entity.dart';
import 'support_center_list_controller.dart';

typedef ActionOnSelected = void Function(SupportCenterPlaceEntity place);

class SupportCenterListPage extends StatefulWidget {
  const SupportCenterListPage({Key? key, required this.controller})
      : super(key: key);

  final SupportCenterListController controller;

  @override
  _SupportCenterListPageState createState() => _SupportCenterListPageState();
}

class _SupportCenterListPageState extends State<SupportCenterListPage> {
  SupportCenterListController get _controller => widget.controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista'),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (_) {
          return Container(
            color: DesignSystemColors.systemBackgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'Pontos de apoio encontrados',
                      style: const TextStyle().listTitle,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _controller.places.length,
                      itemBuilder: (BuildContext context, int index) {
                        final place = _controller.places[index];
                        return Card(
                          place: place,
                          onSelected: _controller.selected,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
    required this.place,
    required this.onSelected,
  }) : super(key: key);
  final SupportCenterPlaceEntity place;
  final ActionOnSelected onSelected;

  @override
  Widget build(BuildContext context) {
    final uf = place.uf;
    final rate = place.rate;
    final placeColor = DesignSystemColors.hexColor(place.category.color!);
    final kmText =
        place.distance != null ? '$uf - ${place.distance} KM DE DISTÂNCIA' : '';
    final rateText = rate != null && rate != 'n/a' ? '$rate/5' : 'n/a';

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: DesignSystemColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 1.0),
                blurRadius: 8.0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.place,
                      size: 30,
                      color: placeColor,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name!,
                          style: TextStyle(
                            color: placeColor,
                            fontFamily: 'Lato',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 20.0,
                          ),
                          child: Text(
                            place.category.name!.toUpperCase(),
                            style: const TextStyle().categoryName,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      kmText,
                      style: const TextStyle().categoryName,
                    ),
                    Text(
                      rateText,
                      style: const TextStyle().rate,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => onSelected(place),
    );
  }
}

extension _TextStyle on TextStyle {
  TextStyle get listTitle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get categoryName => const TextStyle(
        color: DesignSystemColors.brownishGrey,
        fontFamily: 'Lato',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      );

  TextStyle get rate => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      );
}
