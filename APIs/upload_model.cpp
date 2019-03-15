/*
 This is where the APIs for Alfalfa/Boptest.
 check_filename() is for checking the correctness of the model name
*/

#include <iostream>
#include <stdio.h>
#include <string>
#include <typeinfo>

using namespace std;

/*This function check if the given model is OSM or FMU. */
int check_filename(int argc, char* argv[]){
    int i;
    int filename_check;
    if(argc<=1){
        cout << "Please specify the model filename" << endl;
        filename_check = 0;
    }
    else{
        for (i=0; i<argc; i++){
            cout << "Congratus!!! Arguments your specified: "<< argv[i] << endl;
        }

        std:string argv_str = std::string(argv[1]);

        if (argv_str.find(".fmu") != std::string::npos ||
            argv_str.find(".osm") != std::string::npos) {
            int pos = argv_str.find(".");
            string filename_type = argv_str.substr(pos+1);
            cout << "Hey filename type is: "<< filename_type << endl;
            filename_check = 1;

        }
        else{
            cout << "filename type is not correct!" <<endl;
            filename_check = 0;
        }

    }

    return filename_check;    
}


/*Here is the upload_model() */
int upload_model(){
        
}



//Here is the main function
int main(int argc, char* argv[]){
 
    check_filename(argc, argv);
     
}
