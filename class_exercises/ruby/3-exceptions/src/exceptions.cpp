// GradeDistribution
#include <iostream>

using namespace std;

class NegativeInputException {
public: 
	NegativeInputException() {
		cout << "End of input data reached\n";
	}
}; // end NegativeInputException class

int main() { // Any exception can be raised
	int new_grade, index, limit_1, limit_2;
	int freq[10] = {0};
	// Exception to deal with end of data
	try {
		while (true) {
			cout << "Please input a grade or -1 to end: ";
			cin >> new_grade;
			if (new_grade < 0) // Terminating condition
				throw NegativeInputException();

			index = new_grade / 10;
			{ try { 
				if (index > 9)
					throw new_grade;
				freq[index]++;
			}
			catch (int grade) { // Handler for index error
				if (grade == 100)
					freq[9]++;
				else
					cout << "Error: " << grade << " out of range!\n";
			} // end of catch(int grade)
			} // end of inner try-catch pari

		} // end of while
	} // end of outer try block

	catch (NegativeInputException e) { // Handler for negative
		cout << "Limits Frequency\n";
		for (index = 0; index < 10; index++) {
			limit_1 = 10 *index;
			limit_2 = limit_1 + 9;
			if (index == 9)
				limit_2 = 100;
			cout << limit_1 << " " << limit_2 << " " << freq[index]
			<< endl;
		}  // end for
	} // end catch (negative int)

	system("pause");
} // end  main
