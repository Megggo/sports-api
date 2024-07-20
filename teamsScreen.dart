import 'package:flutter/material.dart';
import 'package:sports_app/data/models/TeamsData.dart';
import 'package:sports_app/data/reposetories/TeamsRepo.dart';
import 'package:sports_app/utils/colors.dart';

class TeamsScreen extends StatefulWidget {
  final int leagueId;

  TeamsScreen({required this.leagueId});

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late Future<TeamsData> futureTeamsData;

  @override
  void initState() {
    super.initState();
    futureTeamsData = TeamsRepo().fetchTeamsData(widget.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: secondaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Teams',
          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<TeamsData>(
        future: futureTeamsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load teams data'));
          } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
            return Center(child: Text('No teams available'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4.2 / 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(5),
              itemCount: snapshot.data!.result.length,
              itemBuilder: (context, index) {
                var team = snapshot.data!.result[index];
                return Card(
                  color: thirdColor,
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (team.teamLogo.isNotEmpty)
                        Image.network(
                          team.teamLogo,
                          height: 50,
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: secondaryColor);
                          },
                        )
                      else
                        Icon(Icons.sports_soccer, color: secondaryColor, size: 50),
                      SizedBox(height: 10),
                      Text(
                        team.teamName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
