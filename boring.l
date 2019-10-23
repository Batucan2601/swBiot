%% Decleration of constant variables, %%
%% our language does not includes const variables. %%
INT CONTROL_OPEN_GARAGE = 0;
INT CONTROL_CLOSE_GARAGE = 1;
INT CONTROL_OPEN_DOOR_1 = 2;
INT CONTROL_CLOSE_DOOR_1 = 3;
INT CONTROL_OPEN_LIGHTS = 4;
INT CONTROL_CLOSE_LIGHTS = 5;
INT CONTROL_GETSENSOR_INFO = 6;
INT CONTROL_SHUTDOWN = -1;

%% There are 10 switches but for our demo we used only 6 of them. %%
%% SW1 -> garage door %%
%% SW2 -> open door %%
%% SW3 -> light 1 %%
%% SW4 -> light 2 %%
%% SW5 -> light 3 %%
%% SW6 -> light 4 %%


%% Address of the phone (located on localhost for demonstrative purposes) %%
URL telephoneUrl = 'localhost:8080';

%% There is no main function  %%
%% This is for checking the return code from telephone %%
function check(Url telephoneUrl)
{
    %% Declare variables %%
    INT control;
    BOOL exit = false;

    %% Main while loop %%
    while (!exit)
    {
        %% This statement gets the contents of an url as an integer. %%
        control << telephoneUrl;

        %% Checks all signals. %%
        if (control == CONTROL_OPEN_GARAGE)
        {
            %% Enables the switch. %%
            true >> SW1;
        } 
        else if (control == CONTROL_CLOSE_GARAGE)
        {
            false >> SW1;
        } 
        else if (control == CONTROL_OPEN_DOOR_1)
        {
            true >> SW2;
        } 
        else if (control == CONTROL_CLOSE_DOOR_1)
        {
            false >> SW2;
        } 
        else if (control == CONTROL_OPEN_LIGHTS)
        {
            true >> SW3;
            true >> SW4;
            true >> SW5;
            true >> SW6;
        } 
        else if (control == CONTROL_CLOSE_LIGHTS) 
        {
            false >> SW3;
            false >> SW4;
            false >> SW5;
            false >> SW6;
        }
        else if (control == CONTROL_SHUTDOWN) 
        {
            false >> SW3;
            false >> SW4;
            false >> SW5;
            false >> SW6;
        }
        else if (controll == CONTROL_GETSENSOR_INFO) {
            %% Temporary variable declerations   %%
            INT humidity;
            INT temperature;
            INT light;

            %% read the sensor data from different sensors %%
            humidity << HUM(0);
            temperature << TEMP(0);
            light << LIGHT(0);

            %% Outputs the sensor data %%
            %% nonstop keyword denotes the operation as asyncronus %%
            %% In other words, flow of the program is not interrupted for sending the data. %%
            nonstop telephoneUrl >> humidity;
            nonstop telephoneUrl >> temperature;
            nonstop telephoneUrl >> light;
        }
        else
        {
            %% Prints out the error message. %%
            doit("There is a parsing error.");

            %% Gives out the error and exits from the program. %%
            %% Gives out the time as an error message %%
            hollycow(time());
        };
    };
};

%% Function call, calls our function. %%
checkAll(telephoneUrl);