require_relative 'oneapi/client'

username = ARGV[0]
password = ARGV[1]

if username == nil or username.empty?
    puts 'No username given'
    exit
end
if password == nil or password.empty?
    puts 'No password given'
    exit
end

# example:initialize-sms-client
sms_client = OneApi::SmsClient.new(username, password)
# ----------------------------------------------------------------------------------------------------

# example:login-sms-client
sms_client.login
# ----------------------------------------------------------------------------------------------------

# example:prepare-message-without-notify-url
sms = OneApi::SMSRequest.new
sms.sender_address = '38598854702'
sms.address = '38598854702'
sms.message = 'Test message'
sms.callback_data = 'Any string'
# ----------------------------------------------------------------------------------------------------

# example:send-message
result = sms_client.send_sms(sms)

# Store the client correlator to be able to query for the delivery status later:
client_correlator = result.client_correlator
# ----------------------------------------------------------------------------------------------------

# example:query-for-delivery-status
delivery_status = sms_client.query_delivery_status(client_correlator)
# ----------------------------------------------------------------------------------------------------

sleep(10)

for delivery_info in delivery_status.delivery_info
    puts "Delivery status id #{delivery_info.delivery_status}"
end
