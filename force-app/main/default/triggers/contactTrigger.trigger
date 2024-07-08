trigger contactTrigger on Contact (after update) {
    for (Contact c : Trigger.new) {
        Contact oldContact = Trigger.oldMap.get(c.Id);
        if (c.Description != oldContact.Description) {
            String prompt = 'I am going to provide you with a description for a contact in my salesforce org. I want you to analyze the description and do the best you can to extract their main interests. I want you to return only a list of categories with nothing else included in the response. It should be formatted as a comma-separated list. Here is the description: ' + c.Description;
            OpenAiSvc.runInTheFuture(prompt);
        }
    }
}
