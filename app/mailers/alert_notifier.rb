class AlertNotifier < ActionMailer::Base
  include ActionMailerThemer
  helper :application, :applications

  def alert(theme, alert, applications, comments = [], replies = [])
    @theme = theme
    @alert = alert
    @applications = applications
    @comments = comments
    @replies = replies

    themed_mail(theme: theme, from: email_from(theme), to: alert.email,
      subject: render_to_string(partial: "subject",
        locals: {applications: applications, comments: comments, alert: alert, replies: replies}).strip,
      "List-Unsubscribe" => "<" + unsubscribe_alert_url(protocol: protocol(theme), host: host(theme), id: alert.confirm_id) + ">")
  end
end
