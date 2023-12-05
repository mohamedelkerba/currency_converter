import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiClient client = ApiClient();
  Color mainColor = const Color(0xff212936);
  Color secondColor = const Color(0xff2849e5);
  List<String>? currencies;
  String? from;
  String? to;
  Map<String,dynamic>? rate;
  String result = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    String too;
    if (to!=null) {
      too=to.toString();
    }else{
      too="";
    }
    return Scaffold(

      backgroundColor: mainColor,
      body: Container(

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  child: const Text(
                    "Flo\$ak",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  "💰 Bekam",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        onSubmitted: (value) async {
                          if (from != null && to != null) {
                            rate = (await client.getRate(from!, to!));
                            // print('to////////////////////////////////////////////////////////$from$to');
                            // print('to////////////////////////////////////////////////////////$rate');
                            setState(() {
                              result = (rate!.values.first * double.parse(value)).toStringAsFixed(3);
                              // print('///result$result');
                            });
                          } else {
                            print('Error: from or to is null');
                            // Handle the case when from or to is null
                          }
                        },

                        decoration:
                        InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Input Value To Convert",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: secondColor,
                            )),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customDropDown(currencies, from, (val) {
                            setState(() {
                              from = val;
                            });
                          }),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                result= "";
                              });
                              String? temp = from;
                              setState(() {
                                from= to ;
                                to = temp!;
                              });
                            },
                            elevation: 0.0,
                            backgroundColor: secondColor,
                            child: const Icon(Icons.swap_horiz_outlined),
                          ),
                          customDropDown(currencies, to, (val) {
                            setState(() {
                              to = val;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white ,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Column(
                          children: [
                            const Text("Result", style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),),
                            Text(result, style: TextStyle(
                              color: secondColor,
                              fontSize: 36,
                              fontWeight: FontWeight.bold
                            ),),
                            Text(too, style: const TextStyle(

                              //count = count == N ? 0 : count + 1;
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),

                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
