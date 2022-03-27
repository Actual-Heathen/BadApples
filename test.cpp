#include <fstream>
#include <iostream>
#include <string>
#include <bits/stdc++.h>

using namespace std;

int main()
{
    string sources[400];
    int scount = 0;
    int count = 1;
    bool dup = true;
    string line;
    ifstream inputFile;
    ofstream outFile;
    inputFile.open("TSharkStuff/test.csv");
    outFile.open("spaceInvedersTest/file.txt");
    
     getline(inputFile,line); //dump header
    while(inputFile)
    {

        getline(inputFile,line);

        dup = true;
        for (int i = 0; i <= scount; i++)
        {
            if (scount == 0)
            {
                dup = true;
                break;
            }
            if (sources[i].compare(line) == 0)
            {
                dup = false;
                break;
            }
        }
        
        if(dup && scount < 399)
        {
            sources[scount] = line;
            outFile << line <<"\n";
            scount++;
        }
        count++;

        if (count > 11)
        {
            count = 2;
        }
    }

    for (int i = 0; i< scount; i++)
    {
        cout << sources[i]<<"\n";
    }
    cout << scount<<endl;
    inputFile.close();
}