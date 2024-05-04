import 'package:do_an_2/views/user/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/values/color_extension.dart';
import '../../../res/widgets/round_button.dart';
import '../../../res/widgets/title_subtitle_cell.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              "assets/images/avocado.png",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Stefani Wong",
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Lose a Fat Program",
                                  style: TextStyle(
                                    color: AppColor.gray,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            height: 30,
                            child: RoundButton(
                              title: "Edit",
                              type: RoundButtonType.bgGradient,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: TitleSubtitleCell(
                              title: "180cm",
                              subtitle: "Height",
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TitleSubtitleCell(
                              title: "65kg",
                              subtitle: "Weight",
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TitleSubtitleCell(
                              title: "22yo",
                              subtitle: "Age",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 1)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account",
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_chart_sharp,
                                        color: Colors.blueAccent),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Statistical",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                        Icons.pause_presentation_outlined,
                                        color: Colors.blueAccent),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Read Blog",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.chat_outlined,
                                        color: Colors.blueAccent),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Chat with GPT",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.logout,
                                        color: Colors.blueAccent),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Logout",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 1)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Other",
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.settings,
                                        color: Colors.blueAccent),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Setting",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.mail_lock_outlined,
                                        color: Colors.blueAccent),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Contact us",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.safety_check_sharp,
                                      color: Colors.blueAccent,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Privacy Policy",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 25, top: 10),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1, color: Colors.red)),
                            onPressed: () {},
                            child: const Text(
                              "Delete Account",
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            )),
                      ),
                    ]))));
  }
}
