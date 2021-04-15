#include <iostream>
using namespace std;

int main()
{
	char vehicles;
	double hour, parkingrate;

	cout << "Please enter the type of vehicle\nC for car\nL for lorry\nB for bus\nused: ";
	cin >> vehicles;

	if (vehicles == 'c' || vehicles == 'C')
	{
		cout << "Please enter the parking time (in hour): ";
		cin >> hour;
		if (hour <= 3)
			parkingrate = 1;
		else
			parkingrate = 1 + ((hour - 3)*2);
	}

	else if (vehicles == 'l' || vehicles == 'L')
	{
		cout << "Please enter the parking time (in hour): ";
		cin >> hour;
		if (hour <= 3)
			parkingrate = 2;
		else
			parkingrate = 2 + ((hour - 3)*3);
	}

	else if (vehicles == 'b' || vehicles == 'B')
	{
		cout << "Please enter the parking time (in hour): ";
		cin >> hour;
		if (hour <= 3)
			parkingrate = 3;
		else
			parkingrate = 3 + ((hour - 3)*4);
	}

	cout << "Your parking cost is RM " << parkingrate << endl;

	system("pause");
	return 0;
}