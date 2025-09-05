import 'package:covid19_tracker/constants/utils.dart';
import 'package:covid19_tracker/methods/stats_services.dart';
import 'package:covid19_tracker/views/countries_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(color: whiteClr),
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: whiteClr),
                    hintText: "Search by Country Name",
                    hintStyle: TextStyle(color: whiteClr),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                      icon: Icon(Icons.close, color: whiteClr),
                    ),
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
                Expanded(
                  child: FutureBuilder(
                    future: StatsServices().fetchCountriesStats(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: cardClr,
                              highlightColor: Colors.grey.shade400,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: whiteClr,
                                    ),
                                    title: Container(
                                      height: 10,
                                      width: double.infinity,
                                      color: whiteClr,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: double.infinity,
                                      color: whiteClr,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: TextStyle(color: whiteClr),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No data available"));
                      } else {
                        final countries = snapshot.data!;
                        final query =
                            searchController.text.toLowerCase().trim();

                        final filtered =
                            query.isEmpty
                                ? countries
                                : countries.where((c) {
                                  final name =
                                      c["country"].toString().toLowerCase();
                                  return name.contains(query);
                                }).toList();

                        if (filtered.isEmpty) {
                          return Center(
                            child: Text(
                              "No results found",
                              style: TextStyle(color: whiteClr),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => CountriesDetailScreen(
                                            active: filtered[index]["active"],
                                            crtical:
                                                filtered[index]["critical"],
                                            image:
                                                filtered[index]["countryInfo"]["flag"],
                                            name: filtered[index]["country"],
                                            test: filtered[index]["tests"],
                                            todayRecovered:
                                                filtered[index]["todayRecovered"],
                                            totalCases:
                                                filtered[index]["cases"],
                                            totalDeaths:
                                                filtered[index]["deaths"],
                                            totalRecovered:
                                                filtered[index]["recovered"],
                                          ),
                                    ),
                                  ),
                              child: ListTile(
                                leading: Image.network(
                                  filtered[index]["countryInfo"]["flag"],
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(
                                  filtered[index]["country"],
                                  style: TextStyle(color: whiteClr),
                                ),
                                subtitle: Text(
                                  filtered[index]["cases"].toString(),
                                  style: TextStyle(color: whiteClr),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
