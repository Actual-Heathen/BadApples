#include <fstream>
#include <iostream>
#include <string>
#include <bits/stdc++.h>

using namespace std;

string convertToString(char* a)
{
    string s = a;
    return s;
}

int main()
{
    string sources[400];
    int scount = 0;
    bool dup = true;
    char line[50];
    string sline;
    ifstream inputFile;
    inputFile.open("btTest.csv");

    cout << "Hello World!\n";
    
    int count = 1;

    while(inputFile)
    {

        inputFile.getline(line, 256, ',');
        if (count == 3)
        {
            sline = convertToString(line);
            dup = true;
            for (int i = 0; i <= scount; i++)
            {
                if (scount == 0)
                {
                    dup = true;
                    break;
                }
                if (sources[i].compare(sline) == 0)
                {
                    dup = false;
                    break;
                }
            }

             if (dup)
                cout<< 1;
            else
                cout << 0;

            cout <<"cv:"<<line <<"sv:"<< sline << "\n";
           
            if(dup && scount < 399)
            {
                sources[scount] = sline;
                scount++;
            }
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