import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/asset.dart';

class TreeItemWidget extends StatelessWidget {
  final List<Location> locations;
  final List<Asset> assets;
  const TreeItemWidget(
      {super.key, required this.locations, required this.assets});

  @override
  Widget build(BuildContext context) {
    final locals = locations
        .where(
          (element) => element.parentId == null,
        )
        .toList();
    final componentsWithouRelation = assets.where(
      (asset) =>
          asset.sensorType != null &&
          (asset.locationId == null && asset.parentId == null),
    );
    return Expanded(
      child: ListView(children: [
        ...locals.map(
          (mainLocation) {
            return ExpansionTile(
              initiallyExpanded: false,
              leading: Image.asset('assets/GoLocation.png'),
              title: Text(
                mainLocation.name,
                style: const TextStyle(fontFamily: 'Roboto'),
              ),
              children: [
                ...locations.map(
                  (subLocal) {
                    if (subLocal.parentId == mainLocation.id) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ExpansionTile(
                          leading: Image.asset('assets/GoLocation.png'),
                          title: Text(
                            subLocal.name,
                            style: const TextStyle(fontFamily: 'Roboto'),
                          ),
                          children: [
                            ...assets.map(
                              (asset) {
                                if (asset.sensorId == null &&
                                    asset.locationId == subLocal.id) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: ExpansionTile(
                                      leading: Image.asset('assets/cubic.png'),
                                      title: Text(
                                        asset.name,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto'),
                                      ),
                                      children: [
                                        ...assets.map(
                                          (assetLevelTwo) {
                                            if (assetLevelTwo.sensorId ==
                                                    null &&
                                                assetLevelTwo.parentId ==
                                                    asset.id) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: ExpansionTile(
                                                  leading: Image.asset(
                                                      'assets/cubic.png'),
                                                  title: Text(
                                                    assetLevelTwo.name,
                                                    style: const TextStyle(
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                  children: [
                                                    ...assets.map((subAsset) {
                                                      if (subAsset.sensorType !=
                                                              null &&
                                                          subAsset.parentId ==
                                                              assetLevelTwo
                                                                  .id) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16.0),
                                                          child: ExpansionTile(
                                                            leading: Image.asset(
                                                                'assets/Codepen.png'),
                                                            title: Row(
                                                              children: [
                                                                Text(
                                                                  subAsset.name,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Roboto'),
                                                                ),
                                                                Visibility(
                                                                  visible: subAsset
                                                                          .sensorType ==
                                                                      'energy',
                                                                  child: Image
                                                                      .asset(
                                                                          'assets/bolt.png'),
                                                                )
                                                              ],
                                                            ),
                                                            trailing:
                                                                const SizedBox
                                                                    .shrink(),
                                                          ),
                                                        );
                                                      } else {
                                                        return const SizedBox
                                                            .shrink();
                                                      }
                                                    }),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                ...assets.map((assetLocationRelation) {
                  if (assetLocationRelation.locationId == mainLocation.id) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ExpansionTile(
                        leading: Image.asset('assets/cubic.png'),
                        title: Text(
                          assetLocationRelation.name,
                          style: const TextStyle(fontFamily: 'Roboto'),
                        ),
                        children: [
                          ...assets.map((subComponent) {
                            if (subComponent.sensorType != null &&
                                subComponent.parentId ==
                                    assetLocationRelation.id) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: ExpansionTile(
                                  leading: Image.asset('assets/Codepen.png'),
                                  title: Row(
                                    children: [
                                      Text(
                                        subComponent.name,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto'),
                                      ),
                                      Visibility(
                                          visible:
                                              subComponent.status == 'alert',
                                          child: Image.asset(
                                              'assets/Ellipse.png')),
                                    ],
                                  ),
                                  trailing: const SizedBox.shrink(),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ],
            );
          },
        ),
        ...componentsWithouRelation.map(
          (component) => ExpansionTile(
            initiallyExpanded: false,
            leading: Image.asset('assets/Codepen.png'),
            title: Row(
              children: [
                Text(
                  component.name,
                  style: const TextStyle(fontFamily: 'Roboto'),
                ),
                Image.asset(component.sensorType == 'energy'
                    ? 'assets/bolt.png'
                    : 'assets/Ellipse.png'),
              ],
            ),
            trailing: const SizedBox.shrink(),
          ),
        )
      ]),
    );
  }
}
