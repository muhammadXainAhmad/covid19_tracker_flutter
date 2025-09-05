import 'package:covid19_tracker/constants/utils.dart';
import 'package:covid19_tracker/methods/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: bgClr,
        appBar: AppBar(
          backgroundColor: bgClr,
          iconTheme: IconThemeData(color: whiteClr, size: 24),
          leading: BackButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              await Future.delayed(const Duration(milliseconds: 300));
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: whiteClr),
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: whiteClr),
                    hintText: "Search by Country Name",
                    hintStyle: TextStyle(color: whiteClr),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cardClr),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: whiteClr),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: StatsServices().fetchCountriesStats(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(color: whiteClr, size: 50),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot
                                          .data![index]["countryInfo"]["flag"],
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data![index]["country"],
                                    style: TextStyle(color: whiteClr),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]["cases"].toString(),
                                    style: TextStyle(color: whiteClr),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
