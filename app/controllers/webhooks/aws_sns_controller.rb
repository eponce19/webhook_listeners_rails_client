class Webhooks::AwsSnsController < ApplicationController

    # In AWS Topic Dashboard subscribe your route as http protocol, then request a confirmation and you going to receive in your console an event where will be an attribute called 'SubscribeURL', copy it open your AWS Topic dashboard, click 'Confirm Subscription' and paste in Confirmation URL. 

    # SES notifications format
    # {"id"=>nil, "notification_type"=>"Bounce", "client_id"=>10, "message_id"=>"0101016dbd383c40-a2ebb1f6-1dd7-4f62-a599-4c2758a8fecd-000000", "message_timestamp"=>"2019-10-11T23:47:22.304Z", "source_email"=>"notifications@example.com", "source_ip"=>nil, "sending_account_id"=>"11111111111", "destination_email"=>"example@gmail.con\", "campaign_id"=>nil, "template_identifier"=>"system/email_template_locales/layouts/000/000/052/original/D1_Welcome_mail_EN.html", "message_headers"=>"{\"Received\"=>\"from localhost.localdomain (ec2-54-189-8-215.us-west-2.compute.amazonaws.com [54.189.8.215]) by email-smtp.amazonaws.com with SMTP (SimpleEmailService-d-2OVS3M8GO) id LF9j5Z5mdcbdB41hFYtD for example@gmail.con; Fri, 11 Oct 2019 23:47:22 +0000 (UTC)\", \"Date\"=>\"Fri, 11 Oct 2019 23:47:22 +0000\", \"From\"=>\"notifications@example.com\", \"To\"=>\"example@gmail.con\", \"Message-ID\"=>\"<1111111111_1111111111@169.255.255.255.mail>\", \"Subject\"=>\"Welcome to example\", \"Mime-Version\"=>\"1.0\", \"Content-Type\"=>\"text/html; charset=UTF-8\", \"Content-Transfer-Encoding\"=>\"quoted-printable\", \"X-SES-CONFIGURATION-SET\"=>\"example-engagement-api\", \"Stage\"=>\"staging\", \"Client-Id\"=>\"10\", \"Campaign-Id\"=>\"\", \"Template-Identifier\"=>\"system/email_template_locales/layouts/000/000/052/original/D1_Welcome_mail_EN.html\"}", "delivery_timestamp"=>nil, "delivery_processing_time_millis"=>nil, "delivery_smtp_response"=>nil, "delivery_remote_mta_ip"=>nil, "bounce_type"=>"Permanent", "bounce_subtype"=>"Suppressed", "bounce_timestamp"=>"2019-10-11T23:47:22.719Z", "bounce_feedback_id"=>nil, "complaint_timestamp"=>nil, "complaint_feedback_id"=>nil, "complaint_feedback_type"=>nil, "created_at"=>nil, "updated_at"=>nil, "click_timestamp"=>nil, "click_ip_address"=>nil, "click_user_agent"=>nil, "click_link"=>nil, "open_timestamp"=>nil, "open_ip_address"=>nil, "open_user_agent"=>nil, "stage"=>"staging", "converted_at"=>nil, "converted_info"=>nil}

    def listen
        begin
            
            p "Receive event"
            p event = JSON.parse(request.raw_post)
            method = "handle_" + (event['notification_type'].tr('.', '_')).downcase
            self.send method, event
            
        rescue Exception => ex
            render :json => {:status => 400, :error => "Webhook failed"} and return
        end
        render :json => {:status => 200}
    end

    def handle_bounce(event)
        email = event['destination_email']
        p "Bounce Blacklist email #{email}"
        # Unsubscribe email or delete email from audience
    end
      
    def handle_complaint(event)
        email = event['destination_email']
        p "Complaint Blacklist email #{email}"
        # Unsubscribe email or delete email from audience
    end
    
end