There are 2 ways to run the Load Foundations script.
1. Using the XML configuration file created by the Installer Configuration GUI
2. Using command line parameters to pass values into the PowerShell script


Using XML Configuration

./LoadFoundations.ps1 <installer generated configuration file with xml extension>

Note that this usage will prompt for a password if Windows Authentication is set to false.


Using command line parameters example

./LoadFoundations.ps1 -IsWindowsAuthentication <true/false> -DBServerLocation <DB Server Hostname> -DBName <DB name> -DBAdminUserName <DB Admin User> -DBPassword <DB Admin User Password> -IsSingleDatabase <true/false>

Note that if IsWindowsAuthentication is set to true and DBAdminUserName and DBPassword are present, both values will be ignored.



IMPORTING SAMPLE WORKFLOWS:
1. Log into the Storyteller Admin Portal (ie http://StorytellerURL:8080/adminportal)
2. Under Administration > Workflows > Manage Workflows, click on the Upload Workflow button
3. Click Browse and select the 'Process-Standard.xml' file. Click the Upload button.
4. When completed, you will see the "Process-Standard" workflow in the list
5. Click Browse and select the 'User Story - Standard.xml' file. Click the Upload button.
6. When completed, you will see the "User Story - Standard" workflow in the list

