// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents
//insert new Account(Name = 'James');
// List<Account> records = [SELECT Id,Name FROM Account WHERE Name LIKE '%James%'];
Contact cons = [SELECT Id,Name,Description FROM Contact LIMIT 1];
cons.Description = 'I like to play basketball. I like horses. I like dancing';
System.debug('our cons:' + cons);
// update cons;
String prompt = 'I am going to provide you with a description for a contact in my salesforce org. I want you to analyze the description and do the best you can to extract their main interests. I want you to return only a list of categories with nothing else included in the response. It should be formatted as a comma-separated list. Here is the description: ' + cons.Description;

String response = OpenAiSvc.getGPT4Response(prompt);
System.debug('OpenAI API response: ' + response);
