import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(label: 'Messages', fontSize: 28, color: primary),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 300,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: greyAccent,
                      ),
                      child: Center(
                        child: ListTile(
                          leading: NormalText(
                              label: 'Search message',
                              fontSize: 14,
                              color: Colors.grey),
                          trailing: IconButton(
                            onPressed: (() {}),
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  leading: const Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: CircleAvatar(
                                      minRadius: 40,
                                      maxRadius: 40,
                                      backgroundColor: blueAccent,
                                    ),
                                  ),
                                  title: BoldText(
                                      label: 'Lance Olana',
                                      fontSize: 18,
                                      color: Colors.black45),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 50, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: greenAccent,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: NormalText(
                                                  label: 'Grade',
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        NormalText(
                                            label: '8:45',
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: ListTile(
                            leading: const CircleAvatar(
                              minRadius: 50,
                              maxRadius: 50,
                              backgroundColor: Colors.grey,
                            ),
                            title: BoldText(
                                label: 'Lance Olana',
                                fontSize: 18,
                                color: Colors.grey),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(right: 300),
                              child: Container(
                                height: 20,
                                width: 50,
                                color: greenAccent,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: NormalText(
                                        label: 'Grade',
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    const Divider(),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                  itemBuilder: ((context, index) {
                                    return ListTile(
                                      leading: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          minRadius: 30,
                                          maxRadius: 30,
                                          backgroundColor: blueAccent,
                                        ),
                                      ),
                                      title: Container(
                                        decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: NormalText(
                                              label: 'Lorem Ipsum',
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                      trailing: NormalText(
                                          label: '8:45',
                                          fontSize: 14,
                                          color: Colors.grey),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: ListTile(
                                tileColor: Colors.white,
                                leading: SizedBox(
                                    height: 100,
                                    width: 500,
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: const InputDecoration(
                                          fillColor: Colors.white),
                                    )),
                                trailing: IconButton(
                                    onPressed: (() {}),
                                    icon: const Icon(Icons.send,
                                        color: secondary)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
