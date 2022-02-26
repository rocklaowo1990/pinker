import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/money_set/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MoneySetView extends GetView<MoneySetController> {
  const MoneySetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('正在为玩家 ${controller.arguments.value.playerId} 参数设置'),
      lineColor: AppColors.line,
      backgroundColor: AppColors.secondBacground,
    );

    Widget _setNumber(
      double number, {
      void Function()? subtraction,
      void Function()? addition,
      void Function(double)? onChanged,
      double? min,
      double? max,
    }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getButton(
              child: Center(
                child: getSpan('-', fontSize: 17),
              ),
              width: 22,
              background: AppColors.line,
              height: 22,
              onPressed: subtraction,
              borderRadius: const BorderRadius.all(Radius.circular(1000))),
          // getSpan('$number'),
          Expanded(
            child: Slider(
              value: number,
              onChanged: onChanged,
              max: max ?? 20.0,
              min: min ?? 0,
            ),
          ),
          getButton(
              child: Center(
                child: getSpan('+', fontSize: 17),
              ),
              width: 22,
              background: AppColors.line,
              height: 22,
              onPressed: addition,
              borderRadius: const BorderRadius.all(Radius.circular(1000))),
        ],
      );
    }

    Widget setJi = Container(
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: const EdgeInsets.fromLTRB(9, 5, 9, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80,
            child: Row(
              children: [
                getSpan('鸡（ '),
                Obx(() => getSpan('${controller.arguments.value.ji}',
                    color: controller.arguments.value.ji > 0
                        ? AppColors.errro
                        : controller.arguments.value.ji < 0
                            ? Colors.green
                            : null)),
                getSpan(' )'),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => _setNumber(
                  controller.arguments.value.ji.toDouble(),
                  onChanged: (value) {
                    controller.arguments.update((val) {
                      val!.ji = value.toInt();
                    });
                  },
                  subtraction: () {
                    controller.arguments.update((val) {
                      if (val!.ji > 0) val.ji--;
                    });
                  },
                  addition: () {
                    controller.arguments.update((val) {
                      if (val!.ji < 20) val.ji++;
                    });
                  },
                  min: 0,
                  max: 20,
                )),
          ),
        ],
      ),
    );

    Widget setOnly = Container(
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSpan('你的单独冲锋鸡，杠：（ 输入单倍 ）'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                  decoration: const BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            getSpan('${controller.arguments.value.onlyId_1}（ '),
                            Obx(() =>
                                getSpan('${controller.arguments.value.only_1}',
                                    color: controller.arguments.value.only_1 > 0
                                        ? AppColors.errro
                                        : controller.arguments.value.only_1 < 0
                                            ? Colors.green
                                            : null)),
                            getSpan(' )'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => _setNumber(
                              controller.arguments.value.only_1.toDouble(),
                              onChanged: (value) {
                                controller.arguments.update((val) {
                                  val!.only_1 = value.toInt();
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_2
                                          .value.only_1 = -value.toInt();
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_1
                                          .value.only_1 = -value.toInt();
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_1
                                          .value.only_1 = -value.toInt();
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_1
                                          .value.only_1 = -value.toInt();
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                  }
                                });
                              },
                              subtraction: () {
                                controller.arguments.update((val) {
                                  if (val!.only_1 > -20) val.only_1--;
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_2
                                          .value.only_1++;
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_1
                                          .value.only_1++;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_1
                                          .value.only_1++;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_1
                                          .value.only_1++;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                  }
                                });
                              },
                              addition: () {
                                controller.arguments.update((val) {
                                  if (val!.only_1 < 20) val.only_1++;
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_2
                                          .value.only_1--;
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_1
                                          .value.only_1--;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_1
                                          .value.only_1--;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_1
                                          .value.only_1--;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                  }
                                });
                              },
                              min: -20,
                              max: 20,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                  decoration: const BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            getSpan('${controller.arguments.value.onlyId_2}（ '),
                            Obx(() =>
                                getSpan('${controller.arguments.value.only_2}',
                                    color: controller.arguments.value.only_2 > 0
                                        ? AppColors.errro
                                        : controller.arguments.value.only_2 < 0
                                            ? Colors.green
                                            : null)),
                            getSpan(' )'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => _setNumber(
                              controller.arguments.value.only_2.toDouble(),
                              onChanged: (value) {
                                controller.arguments.update((val) {
                                  val!.only_2 = value.toInt();
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_3
                                          .value.only_1 = -value.toInt();
                                      controller.moneyController.state.player_3
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_3
                                          .value.only_2 = -value.toInt();
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_2
                                          .value.only_2 = -value.toInt();
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_2
                                          .value.only_3 = -value.toInt();
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                  }
                                });
                              },
                              subtraction: () {
                                controller.arguments.update((val) {
                                  if (val!.only_2 > -20) val.only_2--;
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_3
                                          .value.only_1++;
                                      controller.moneyController.state.player_3
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_3
                                          .value.only_2++;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_2
                                          .value.only_2++;
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_2
                                          .value.only_3++;
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                  }
                                });
                              },
                              addition: () {
                                controller.arguments.update((val) {
                                  if (val!.only_2 < 20) val.only_2++;
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_3
                                          .value.only_1--;
                                      controller.moneyController.state.player_3
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_3
                                          .value.only_2--;
                                      controller.moneyController.state.player_1
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_2
                                          .value.only_2--;
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_2
                                          .value.only_3--;
                                      controller.moneyController.state.player_2
                                          .update((val) {});
                                  }
                                });
                              },
                              min: -20,
                              max: 20,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                  decoration: const BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            getSpan('${controller.arguments.value.onlyId_3}（ '),
                            Obx(() =>
                                getSpan('${controller.arguments.value.only_3}',
                                    color: controller.arguments.value.only_3 > 0
                                        ? AppColors.errro
                                        : controller.arguments.value.only_3 < 0
                                            ? Colors.green
                                            : null)),
                            getSpan(' )'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => _setNumber(
                              controller.arguments.value.only_3.toDouble(),
                              onChanged: (value) {
                                controller.arguments.update((val) {
                                  val!.only_3 = value.toInt();
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_4
                                          .value.only_1 = -value.toInt();
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_4
                                          .value.only_2 = -value.toInt();
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_4
                                          .value.only_3 = -value.toInt();
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_3
                                          .value.only_3 = -value.toInt();
                                      controller.moneyController.state.player_3
                                          .update((val) {});
                                  }
                                });
                              },
                              subtraction: () {
                                controller.arguments.update((val) {
                                  if (val!.only_3 > -20) val.only_3--;
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_4
                                          .value.only_1++;
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_4
                                          .value.only_2++;
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_4
                                          .value.only_3++;
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_3
                                          .value.only_3++;
                                      controller.moneyController.state.player_3
                                          .update((val) {});
                                  }
                                });
                              },
                              addition: () {
                                controller.arguments.update((val) {
                                  if (val!.only_3 < 20) val.only_3++;
                                  switch (controller.arguments.value.playerId) {
                                    case 1:
                                      controller.moneyController.state.player_4
                                          .value.only_1--;
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    case 2:
                                      controller.moneyController.state.player_4
                                          .value.only_2--;
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    case 3:
                                      controller.moneyController.state.player_4
                                          .value.only_3--;
                                      controller.moneyController.state.player_4
                                          .update((val) {});
                                      break;
                                    default:
                                      controller.moneyController.state.player_3
                                          .value.only_3--;
                                      controller.moneyController.state.player_3
                                          .update((val) {});
                                  }
                                });
                              },
                              min: -20,
                              max: 20,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget ma = Container(
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSpan('你中的码号：'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                  decoration: const BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            getSpan('1（ '),
                            Obx(() =>
                                getSpan('${controller.arguments.value.ma_1}',
                                    color: controller.arguments.value.ma_1 > 0
                                        ? AppColors.errro
                                        : controller.arguments.value.ma_1 < 0
                                            ? Colors.green
                                            : null)),
                            getSpan(' )'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => _setNumber(
                              controller.arguments.value.ma_1.toDouble(),
                              onChanged: (value) {
                                controller.arguments.update((val) {
                                  val!.ma_1 = value.toInt();
                                });
                                controller.changeBebuy();
                              },
                              subtraction: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_1 > 0) val.ma_1--;
                                });
                                controller.changeBebuy();
                              },
                              addition: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_1 < 10) val.ma_1++;
                                });
                                controller.changeBebuy();
                              },
                              min: 0,
                              max: 10,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                  decoration: const BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            getSpan('2（ '),
                            Obx(() =>
                                getSpan('${controller.arguments.value.ma_2}',
                                    color: controller.arguments.value.ma_2 > 0
                                        ? AppColors.errro
                                        : controller.arguments.value.ma_2 < 0
                                            ? Colors.green
                                            : null)),
                            getSpan(' )'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => _setNumber(
                              controller.arguments.value.ma_2.toDouble(),
                              onChanged: (value) {
                                controller.arguments.update((val) {
                                  val!.ma_2 = value.toInt();
                                });
                                controller.changeBebuy();
                              },
                              subtraction: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_2 > 0) val.ma_2--;
                                });
                                controller.changeBebuy();
                              },
                              addition: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_2 < 10) val.ma_2++;
                                });
                                controller.changeBebuy();
                              },
                              min: 0,
                              max: 10,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                  decoration: const BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            getSpan('3（ '),
                            Obx(() =>
                                getSpan('${controller.arguments.value.ma_3}',
                                    color: controller.arguments.value.ma_3 > 0
                                        ? AppColors.errro
                                        : controller.arguments.value.ma_3 < 0
                                            ? Colors.green
                                            : null)),
                            getSpan(' )'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => _setNumber(
                              controller.arguments.value.ma_3.toDouble(),
                              onChanged: (value) {
                                controller.arguments.update((val) {
                                  val!.ma_3 = value.toInt();
                                });
                                controller.changeBebuy();
                              },
                              subtraction: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_3 > 0) val.ma_3--;
                                });
                                controller.changeBebuy();
                              },
                              addition: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_3 < 10) val.ma_3++;
                                });
                                controller.changeBebuy();
                              },
                              min: 0,
                              max: 20,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                  decoration: const BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            getSpan('4（ '),
                            Obx(() =>
                                getSpan('${controller.arguments.value.ma_4}',
                                    color: controller.arguments.value.ma_4 > 0
                                        ? AppColors.errro
                                        : controller.arguments.value.ma_4 < 0
                                            ? Colors.green
                                            : null)),
                            getSpan(' )'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => _setNumber(
                              controller.arguments.value.ma_4.toDouble(),
                              onChanged: (value) {
                                controller.arguments.update((val) {
                                  val!.ma_4 = value.toInt();
                                });
                                controller.changeBebuy();
                              },
                              subtraction: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_4 > 0) val.ma_4--;
                                });
                                controller.changeBebuy();
                              },
                              addition: () {
                                controller.arguments.update((val) {
                                  if (val!.ma_4 < 10) val.ma_4++;
                                });
                                controller.changeBebuy();
                              },
                              min: 0,
                              max: 20,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget body = ListView(
      children: [
        const SizedBox(height: 10),
        setJi,
        const SizedBox(height: 3),
        ma,
        const SizedBox(height: 3),
        setOnly,
      ],
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
