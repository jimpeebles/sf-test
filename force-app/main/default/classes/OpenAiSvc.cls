public with sharing class OpenAiSvc {
    private static final String OPENAI_API_URL = 'https://api.openai.com/v1/chat/completions';

    public static String getGPT4Response(String prompt) {
        // Get the API key from custom settings
        OpenAISettings__c settings = OpenAISettings__c.getOrgDefaults();
        if (settings == null || String.isEmpty(settings.OPENAI_API_KEY__c)) {
            System.debug('OpenAI API Key is not set in Custom Settings.');
            return null;
        }

        String apiKey = settings.OPENAI_API_KEY__c;

        // Prepare the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(OPENAI_API_URL);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + apiKey);

        // Prepare the request body
        String requestBody = JSON.serialize(new Map<String, Object>{
            'model' => 'gpt-4',
            'messages' => new List<Map<String, String>>{
                new Map<String, String>{'role' => 'user', 'content' => prompt}
            }
        });
        req.setBody(requestBody);

        // Send the request and handle the response
        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            List<Object> choices = (List<Object>) responseMap.get('choices');
            if (!choices.isEmpty()) {
                Map<String, Object> choice = (Map<String, Object>) choices[0];
                Map<String, Object> message = (Map<String, Object>) choice.get('message');
                return (String) message.get('content');
            }
        } else {
            System.debug('Error from OpenAI: ' + res.getStatus() + ' ' + res.getStatusCode() + ' ' + res.getBody());
        }

        return null;
    }

    @future (Callout=true)
    public static void runInTheFuture(String prompt) {
        String response = getGPT4Response(prompt);
        System.debug('OpenAI API response: ' + response);
    }
}
