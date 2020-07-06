module PrettyTime
  include ActionView::Helpers::TextHelper

  def normalize_time(seconds)
    days, rest = seconds.to_i.divmod(86_400)
    hours, rest = rest.divmod(3_600)
    minutes = rest / 60

    response = ''
    response << pluralize(days, 'day') << ' ' if days.positive?
    response << pluralize(hours, 'hour') << ' ' if hours.positive?
    response << pluralize(minutes, 'minute') if minutes.positive?

    response.present? ? response.strip : '0 minutes'
  end
end
