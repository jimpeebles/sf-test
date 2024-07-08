trigger accountTrigger on Account (after update) {
System.debug('Account Trigger ' + Trigger.new);
}
