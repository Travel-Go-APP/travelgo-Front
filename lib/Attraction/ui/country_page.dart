import 'package:flutter/material.dart';
import 'package:xtyle/xtyle.dart';

class countryPage extends StatefulWidget {
  final String? country;
  final int? percent;
  final int? count;
  final int? check;

  const countryPage({super.key, this.country, this.percent, this.count, this.check});

  @override
  State<countryPage> createState() => _countryPageState();
}

class _countryPageState extends State<countryPage> {
  late ScrollController? _scrollController;
  bool lastStatus = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_isShrink != lastStatus) {
          setState(() {
            lastStatus = _isShrink;
          });
        }
      }); // 상단 스크롤 검사
  }

  bool get _isShrink {
    return _scrollController != null && _scrollController!.hasClients && _scrollController!.offset > kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isShrink ? Colors.green : Colors.white,
        shadowColor: Colors.black,
        title: XtyleText(widget.country ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07)),
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                        child: XtyleText(
                      "수집률 : ",
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
                    )),
                    WidgetSpan(
                        child: XtyleText(
                      "${widget.percent}%",
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, color: _isShrink ? Colors.white : Colors.blue),
                    )),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
            child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: widget.count ?? 0,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.12, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white
                  ),
                onPressed: () {}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/Logo.png', scale: 3.5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        XtyleText("??? ???"),
                        XtyleText("??? ??? ???")
                      ],
                    )
                    ]
                    ),
                ));
          },
          separatorBuilder: (context, index) => Divider(
            indent: MediaQuery.of(context).size.width * 0.02,
            endIndent: MediaQuery.of(context).size.width * 0.02,
            color: Colors.grey,
          ),
        ))
      ]),
    );
  }
}
